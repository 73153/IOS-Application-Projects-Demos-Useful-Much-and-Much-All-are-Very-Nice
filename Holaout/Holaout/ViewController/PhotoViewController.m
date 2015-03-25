//
//  PhotoViewController.m
//  Holaout
//
//  Created by Amit Parmar on 11/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "PhotoViewController.h"
#import "SettingsViewController.h"
#import "VideoViewController.h"
#import "DrawingViewController.h"
#import "FriendsViewController.h"
#import "EditPhotoViewController.h"
#import "ImageListViewController.h"

@implementation PhotoViewController
@synthesize imageViewProfile;
@synthesize needToHideBottomView;
@synthesize btnPhoto;
@synthesize btnDrawing;
@synthesize btnVideo;
@synthesize btnHolaout;
@synthesize seledtedFriend;
@synthesize lblName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if(needToHideBottomView){
        [btnDrawing setHidden:YES];
        [btnHolaout setHidden:YES];
        [btnPhoto setHidden:YES];
        [btnVideo setHidden:YES];
    }
    else{
        [btnDrawing setHidden:NO];
        [btnHolaout setHidden:NO];
        [btnPhoto setHidden:NO];
        [btnVideo setHidden:NO];
    }
    
    NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:stringPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:stringPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    CALayer* containerLayer = [CALayer layer];
    containerLayer.shadowColor = [UIColor blackColor].CGColor;
    containerLayer.shadowRadius = 10.f;
    containerLayer.shadowOffset = CGSizeMake(0.f, 5.f);
    containerLayer.shadowOpacity = 1.f;
    
    imageViewProfile.layer.cornerRadius = roundf(imageViewProfile.frame.size.width/2.0);
    imageViewProfile.layer.masksToBounds = YES;
    [containerLayer addSublayer:imageViewProfile.layer];
    [self.view.layer addSublayer:containerLayer];
    if(seledtedFriend){
        lblName.text = [seledtedFriend objectForKey:kContactName];
        NSString *fileName = [seledtedFriend objectForKey:kContactImage];
        NSData *data = [NSData dataWithContentsOfFile:fileName];
        imageViewProfile.image = [UIImage imageWithData:data];
    }
    else{
        NSString *fileName = [stringPath stringByAppendingFormat:@"/profile.png"];
        NSData *data = [NSData dataWithContentsOfFile:fileName];
        imageViewProfile.image = [UIImage imageWithData:data];
        NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredData];
        lblName.text = [dictionary objectForKey:kUserName];
    }
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)btnBackClicked:(id)sender{
    if(needToHideBottomView){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        NSNotification * notification = [NSNotification notificationWithName:@"BACKTOINDEXNOTE" object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
}
- (IBAction)btnSettingsClicked:(id)sender{
    SettingsViewController *settingsViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPhone" bundle:nil];
    }
    else{
       settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPad" bundle:nil];
    }
    [self presentViewController:settingsViewController animated:YES completion:nil];
}
- (IBAction)btnTakePhotoClicked:(id)sender{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
}
- (IBAction)btnChooseFromLibraryClicked:(id)sender{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
}

- (void) openNewView:(UIImage *)image{
    EditPhotoViewController *editPhotoViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        editPhotoViewController = [[EditPhotoViewController alloc] initWithNibName:@"EditPhotoViewController_iPhone" bundle:nil];
    }
    else{
        editPhotoViewController = [[EditPhotoViewController alloc] initWithNibName:@"EditPhotoViewController_iPad" bundle:nil];
    }
    editPhotoViewController.image = image;
    editPhotoViewController.seledtedFriend = seledtedFriend;
    [self presentViewController:editPhotoViewController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
   [self performSelector:@selector(openNewView:) withObject:chosenImage afterDelay:1.5];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnChoosefromGoogleClicked:(id)sender{
    ImageListViewController *imageListViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        imageListViewController = [[ImageListViewController alloc] initWithNibName:@"ImageListViewController_iPhone" bundle:nil];
    }
    else{
        imageListViewController = [[ImageListViewController alloc] initWithNibName:@"ImageListViewController_iPad" bundle:nil];
    }
    [self presentViewController:imageListViewController animated:YES completion:nil];
}

- (IBAction)videoButtonClicked:(id)sender{
        VideoViewController *videoViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            videoViewController = [[VideoViewController alloc] initWithNibName:@"VideoViewController_iPhone" bundle:nil];
        }
        else{
            videoViewController = [[VideoViewController alloc] initWithNibName:@"VideoViewController_iPad" bundle:nil];
        }
        [self presentViewController:videoViewController animated:YES completion:nil];
}
- (IBAction)drawingButtonClicked:(id)sender{
        DrawingViewController *drawingViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            drawingViewController = [[DrawingViewController alloc] initWithNibName:@"DrawingViewController_iPhone" bundle:nil];
        }
        else{
            drawingViewController = [[DrawingViewController alloc] initWithNibName:@"DrawingViewController_iPad" bundle:nil];
        }
       [self presentViewController:drawingViewController animated:YES completion:nil];
}

@end
