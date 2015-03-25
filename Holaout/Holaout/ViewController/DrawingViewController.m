//
//  DrawingViewController.m
//  Holaout
//
//  Created by Amit Parmar on 11/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "DrawingViewController.h"
#import "SettingsViewController.h"
#import "PhotoViewController.h"
#import "VideoViewController.h"
#import "FriendsViewController.h"
#import "EditPhotoViewController.h"

@implementation DrawingViewController
@synthesize imageViewProfile;
@synthesize mainImage;
@synthesize activeMotion;
@synthesize startPoint;
@synthesize needToHideBottomView;
@synthesize btnPhoto;
@synthesize btnVideo;
@synthesize btnHolaout;
@synthesize btnDrawing;
@synthesize selectedFriend;
@synthesize lblName;
@synthesize activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if(needToHideBottomView){
        [btnPhoto setHidden:YES];
        [btnVideo setHidden:YES];
        [btnHolaout setHidden:YES];
        [btnDrawing setHidden:YES];
    }
    else{
        [btnPhoto setHidden:NO];
        [btnVideo setHidden:NO];
        [btnHolaout setHidden:NO];
        [btnDrawing setHidden:NO];
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
    
    if(selectedFriend){
        lblName.text = [selectedFriend objectForKey:kContactName];
        NSString *fileName = [selectedFriend objectForKey:kContactImage];
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

- (void) imageSavedSuccess{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Image Saved successfully" delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)btnSaveClicked:(id)sender{
    UIImageWriteToSavedPhotosAlbum(mainImage.image, nil, nil, nil);
}
- (IBAction)btnTimerClicked:(id)sender{
    
}
- (IBAction)btnSendClicked:(id)sender{
    mainImage.image = nil;
}

- (IBAction)photoButtonClicked:(id)sender{
        PhotoViewController *photoViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            photoViewController = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController_iPhone" bundle:nil];
        }
        else{
            photoViewController = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController_iPad" bundle:nil];
        }
        [self presentViewController:photoViewController animated:YES completion:nil];
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

- (void) uploadImageAndSendTextLinkToFriends{
    NSData *imageData = UIImagePNGRepresentation(mainImage.image);
    [QBContent TUploadFile:imageData fileName:@"image.png" contentType:@"image/png" isPublic:NO delegate:self];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([alertView tag] == 10001 && buttonIndex == 0){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)completedWithResult:(Result*)result{
     [activityIndicator stopAnimating];
    if(result.success && [result isKindOfClass:[QBCFileUploadTaskResult class]]){
        QBCFileUploadTaskResult *res = (QBCFileUploadTaskResult *)result;
        NSUInteger uploadedFileID = res.uploadedBlob.ID;
        
        NSData *imageData = UIImagePNGRepresentation(mainImage.image);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *yourArtPath = [NSString stringWithFormat:@"%@/%d.png",documentsDirectory,uploadedFileID];
        [imageData writeToFile:yourArtPath atomically:YES];
        
        QBChatMessage *message = [QBChatMessage message];
        message.senderID = [LocalStorageService shared].currentUser.ID;
        message.recipientID = [[selectedFriend objectForKey:kContactHolaoutId] intValue]; // opponent's id
        [message setCustomParameters:(NSMutableDictionary *
                                      )@{@"fileID": @(uploadedFileID)}];
        [[QBChat instance] sendMessage:message];
        [[LocalStorageService shared] saveImageToHistory:[NSDictionary dictionaryWithObjectsAndKeys:message,kMessage,[NSString stringWithFormat:@"%d",uploadedFileID],@"image", nil] withUserID:message.recipientID];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Image sent successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView setTag:10001];
        [alertView show];
    }else{
        NSLog(@"errors=%@", result.errors);
    }
}

- (IBAction)btnSendImageClicked:(id)sender{
        if(selectedFriend){
            [activityIndicator startAnimating];
            [self uploadImageAndSendTextLinkToFriends];
        }
        else{
            EditPhotoViewController *editPhotoViewController;
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
                editPhotoViewController = [[EditPhotoViewController alloc] initWithNibName:@"EditPhotoViewController_iPhone" bundle:nil];
            }
            else{
                editPhotoViewController = [[EditPhotoViewController alloc] initWithNibName:@"EditPhotoViewController_iPad" bundle:nil];
            }
            editPhotoViewController.image = mainImage.image;
            editPhotoViewController.seledtedFriend = selectedFriend;
            [self presentViewController:editPhotoViewController animated:YES completion:nil];
        }
}

- (void)drawLineFrom:(CGPoint)start To:(CGPoint)end {
    // begin image context
    UIGraphicsBeginImageContext(mainImage.frame.size);
    
    // define image rect for drawing
    [mainImage.image drawInRect:CGRectMake(0, 0, mainImage.frame.size.width, mainImage.frame.size.height)];
    
    // set line properties
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 8.0f);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0f, 0.0f, 0.0f, 1.0);
    
    // move context to start point
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), start.x, start.y);
    
    // define path to end point
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), end.x, end.y);
    
    // stroke path
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    // flush context to be sure all drawing operations were processed
    CGContextFlush(UIGraphicsGetCurrentContext());
    
    // get UIImage from context and pass it to our image view
    mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    
    // end image context
    UIGraphicsEndImageContext();
}

#pragma mark -
#pragma mark UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // backup first touch point in our image view
    startPoint = [[touches anyObject] locationInView:mainImage];
    
    // set or reset motion boolean to no
    activeMotion = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // get new touch point in our image view
    CGPoint newPoint = [[touches anyObject] locationInView:mainImage];
    
    // set motion boolean to yes
    activeMotion = YES;
    
    // draw line from last start point to new point
    [self drawLineFrom:startPoint To:newPoint];
    
    // overwrite last start point with new point
    startPoint = newPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // get new touch point in our image view
    CGPoint newPoint = [[touches anyObject] locationInView:mainImage];
    
    // draw line from last start point to new point if no motion has taken place - results in a point
    if(!activeMotion) [self drawLineFrom:startPoint To:newPoint];
}

@end
