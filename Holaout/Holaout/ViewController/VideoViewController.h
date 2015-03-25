//
//  VideoViewController.h
//  Holaout
//
//  Created by Amit Parmar on 11/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *imageViewProfile;
@property (copy,   nonatomic) NSURL *movieURL;
@property (strong, nonatomic) MPMoviePlayerController *movieController;
@property (nonatomic) BOOL needToHideBottomView;
@property (nonatomic, strong) IBOutlet UIButton *btnPhoto;
@property (nonatomic, strong) IBOutlet UIButton *btnVideo;
@property (nonatomic, strong) IBOutlet UIButton *btnHolaout;
@property (nonatomic, strong) IBOutlet UIButton *btnDrawing;
@property (nonatomic, strong) NSDictionary *seledtedFriend;
@property (nonatomic, strong) IBOutlet UILabel *lblName;

- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnSettingsClicked:(id)sender;
- (IBAction)btnTakePhotoClicked:(id)sender;
- (IBAction)btnChooseFromLibraryClicked:(id)sender;
- (IBAction)btnChoosefromGoogleClicked:(id)sender;

- (IBAction)photoButtonClicked:(id)sender;
- (IBAction)drawingButtonClicked:(id)sender;


@end
