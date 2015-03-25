//
//  VideoViewController.m
//  Holaout
//
//  Created by Amit Parmar on 11/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "VideoViewController.h"
#import "DrawingViewController.h"
#import "PhotoViewController.h"
#import "SettingsViewController.h"
#import "FriendsViewController.h"
#import "PlayVideoViewController.h"
#import "VideoListViewController.h"

@implementation VideoViewController
@synthesize imageViewProfile;
@synthesize movieURL;
@synthesize movieController;
@synthesize needToHideBottomView;
@synthesize btnPhoto;
@synthesize btnHolaout;
@synthesize btnVideo;
@synthesize btnDrawing;
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
        NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredData];
        lblName.text = [dictionary objectForKey:kUserName];
        NSString *fileName = [stringPath stringByAppendingFormat:@"/profile.png"];
        NSData *data = [NSData dataWithContentsOfFile:fileName];
        imageViewProfile.image = [UIImage imageWithData:data];
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
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    [self presentViewController:picker animated:YES completion:NULL];
    
}
- (IBAction)btnChooseFromLibraryClicked:(id)sender{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    [self presentViewController:picker animated:YES completion:NULL];
}
- (IBAction)btnChoosefromGoogleClicked:(id)sender{
    VideoListViewController *videoListViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        videoListViewController = [[VideoListViewController alloc] initWithNibName:@"VideoListViewController_iPhone" bundle:nil];
    }
    else{
        videoListViewController = [[VideoListViewController alloc] initWithNibName:@"VideoListViewController_iPad" bundle:nil];
    }
    videoListViewController.selectedFriend = seledtedFriend;
    [self presentViewController:videoListViewController animated:YES completion:nil];
}

- (IBAction)photoButtonClicked:(id)sender{
        PhotoViewController *photoViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            photoViewController = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController_iPhone" bundle:nil];
        }
        else{
            photoViewController = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController_iPad" bundle:nil];
        }
    photoViewController.seledtedFriend = seledtedFriend;
    [self presentViewController:photoViewController animated:YES completion:nil];
}
- (IBAction)drawingButtonClicked:(id)sender{
        DrawingViewController *drawingViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            drawingViewController = [[DrawingViewController alloc] initWithNibName:@"DrawingViewController_iPhone" bundle:nil];
        }
        else{
            drawingViewController = [[DrawingViewController alloc] initWithNibName:@"DrawingViewController_iPad" bundle:nil];
        }
        drawingViewController.selectedFriend = seledtedFriend;
       [self presentViewController:drawingViewController animated:YES completion:nil];
}

- (void) openPlayVideoView{
    PlayVideoViewController *playVideoViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        playVideoViewController = [[PlayVideoViewController alloc] initWithNibName:@"PlayVideoViewController_iPhone" bundle:nil];
    }
    else{
        playVideoViewController = [[PlayVideoViewController alloc] initWithNibName:@"PlayVideoViewController_iPad" bundle:nil];
    }
    playVideoViewController.movieUrl = self.movieURL;
    playVideoViewController.selectedFriend = seledtedFriend;
    [self presentViewController:playVideoViewController animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.movieURL = info[UIImagePickerControllerMediaURL];
    [self performSelector:@selector(openPlayVideoView) withObject:nil afterDelay:1.5];
    [picker dismissViewControllerAnimated:NO completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)moviePlayBackDidFinish:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [self.movieController stop];
    [self.movieController.view removeFromSuperview];
    self.movieController = nil;
    
}

@end
