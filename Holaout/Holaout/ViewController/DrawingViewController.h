//
//  DrawingViewController.h
//  Holaout
//
//  Created by Amit Parmar on 11/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingViewController : UIViewController<QBActionStatusDelegate>{
    BOOL   activeMotion;
    CGPoint startPoint; 
}

@property (nonatomic, strong) IBOutlet UIImageView *imageViewProfile;
@property (nonatomic, strong) IBOutlet UIImageView *mainImage;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) BOOL activeMotion;
@property (nonatomic) BOOL needToHideBottomView;
@property (nonatomic, strong) IBOutlet UIButton *btnPhoto;
@property (nonatomic, strong) IBOutlet UIButton *btnVideo;
@property (nonatomic, strong) IBOutlet UIButton *btnHolaout;
@property (nonatomic, strong) IBOutlet UIButton *btnDrawing;
@property (nonatomic, strong) NSDictionary *selectedFriend;
@property (nonatomic, strong) IBOutlet UILabel *lblName;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnSettingsClicked:(id)sender;
- (IBAction)btnSaveClicked:(id)sender;
- (IBAction)btnTimerClicked:(id)sender;
- (IBAction)btnSendClicked:(id)sender;

- (IBAction)photoButtonClicked:(id)sender;
- (IBAction)videoButtonClicked:(id)sender;

- (IBAction)btnSendImageClicked:(id)sender;

@end
