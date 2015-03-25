//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "KippyPhoto.h"
#import "AppDelegate.h"
#import "TapUtils.h"
#import "TapNetworkImageView.h"
#import "ASIFormDataRequest.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation KippyPhoto

- (id)initWithWhiteMask:(BOOL)whiteMask {
  self = [super init];
  if (self) {
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:spinner];
    spinner.center = CGPointMake(40, 40);
    photo = nil;
    if(!whiteMask) {
      UIImageView* bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_mask.png"]];
      [self addSubview:bg];
    } else {
      UIImageView* bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kippy_photo_mask.png"]];
      [self addSubview:bg];
    }
    UIImageView* camera = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera_ico.png"]];
    [self addSubview:camera];
    camera.center = CGPointMake(70,70);
    UIButton* photoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,80,80)];
    [photoBtn addTarget:self action:@selector(showPhotoOptions) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:photoBtn];
  }
  return self;
}

-(void)setup:(NSDictionary*)dictionary {
  self.info = dictionary;
  [self updatePhoto];
}

-(void)updatePhoto {
  if(photo != nil) {
    [photo removeFromSuperview];
  }
  if(self.info != nil) {
    photo = [[TapNetworkImageView alloc] initWithFrame:CGRectMake(0,0,80,80) url:[NSString stringWithFormat:@"%@/%@", SERVER_URL, [info objectForKey:@"img_src"]]];
    [self addSubview:photo];
    [self sendSubviewToBack:photo];
  }
}

-(void)showPhotoOptions {
  UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
  [actionSheet setDelegate:self];
  if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
    [actionSheet addButtonWithTitle:@"Import from Camera"];
    [actionSheet addButtonWithTitle:@"Import from Library"];
    [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet setCancelButtonIndex:2];
  } else {
    [actionSheet addButtonWithTitle:@"Import from Library"];
    [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet setCancelButtonIndex:1];
  }
  [actionSheet showInView:[self superview]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
  if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
    if(buttonIndex == 0) {
      [self takeNewPhoto];
    }
    if(buttonIndex == 1) {
      [self importPhoto];
    }
  } else {
    if(buttonIndex == 0) {
      [self importPhoto];
    }
  }
}

-(void)takeNewPhoto {
  UIImagePickerController *controller = [[UIImagePickerController alloc] init];
  controller.delegate = self;
  controller.sourceType = UIImagePickerControllerSourceTypeCamera;
  controller.allowsEditing = YES;
  [[self app].navigationController presentModalViewController:controller animated:YES];
}

-(void)importPhoto {
  UIImagePickerController *controller = [[UIImagePickerController alloc] init];
  controller.delegate = self;
  controller.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
  controller.mediaTypes =  [NSArray arrayWithObject:(NSString *)kUTTypeImage];
  controller.allowsEditing = YES;
  [[self app].navigationController presentModalViewController:controller animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)mediaInfo {
  UIImage *image = [mediaInfo objectForKey: UIImagePickerControllerEditedImage];
  UIGraphicsBeginImageContextWithOptions(CGSizeMake(160, 160), NO, 0.0);
  [image drawInRect:CGRectMake(0,0,160,160)];
  image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  NSString *photoPath = [self userPhotoPath];
  [[NSFileManager defaultManager] removeItemAtPath:photoPath error:nil];
  [UIImageJPEGRepresentation(image, 0.8) writeToFile:photoPath atomically:YES];
  [picker dismissModalViewControllerAnimated:YES];
  if(photo != nil) {
    [photo removeFromSuperview];
    photo = nil;
  }
  [spinner startAnimating];
  ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://dev.kippy.eu/kippymap_uploadImg.php?app_code=%@&app_verification_code=%@&file_field=file&main_folder=kippy_img&img_folder=%@&image_name=foto.jpg", [self app].appCode, [self app].appVerificationCode, [self.info objectForKey:@"id"]]]];
  [request addFile:[self userPhotoPath] forKey:@"file"];
  [request setDelegate:self];
  [request setDidFinishSelector:@selector(uploadFinished:)];
  [request startAsynchronous];
}

-(void)uploadFinished:(ASIFormDataRequest *)request {
  [spinner stopAnimating];
  [self updatePhoto];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"KippyDataChanged" object:nil];
}

-(NSString*)userPhotoPath {
  NSString *path = [[TapUtils documentDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"kippy.jpg"]];
  return path;
}

@end
