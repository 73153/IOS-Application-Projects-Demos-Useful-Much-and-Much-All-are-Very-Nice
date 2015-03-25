//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "UserPhoto.h"
#import "AppDelegate.h"
#import "TapUtils.h"
#import "TapNetworkImageView.h"
#import "ASIFormDataRequest.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation UserPhoto

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePhoto) name:@"UserDataChanged" object:nil];
  }
  return self;
}

-(void)updatePhoto {
  if(photo != nil) {
    [photo removeFromSuperview];
  }
  photo = [[TapNetworkImageView alloc] initWithFrame:CGRectMake(0,0,80,80) url:[NSString stringWithFormat:@"http://dev.kippy.eu/user_img/%@/img.jpg", [self app].userId]];
  [self addSubview:photo];
  [self sendSubviewToBack:photo];
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
  ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://dev.kippy.eu/kippymap_uploadImg.php?app_code=%@&app_verification_code=%@&file_field=file&main_folder=user_img&img_folder=%@&image_name=foto.jpg", [self app].appCode, [self app].appVerificationCode, [self app].userId]]];
  [request addFile:[self userPhotoPath] forKey:@"file"];
  [request setDelegate:self];
  [request setDidFinishSelector:@selector(uploadFinished:)];
  [request startAsynchronous];
}

-(void)uploadFinished:(ASIFormDataRequest *)request {
  [spinner stopAnimating];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"UserDataChanged" object:nil];
}

-(NSString*)userPhotoPath {
  NSString *path = [[TapUtils documentDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"user.jpg"]];
  return path;
}

@end
