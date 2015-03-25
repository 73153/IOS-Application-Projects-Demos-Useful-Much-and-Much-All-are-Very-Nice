//
//  EditPhotoViewController.h
//  Holaout
//
//  Created by Amit Parmar on 11/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface EditPhotoViewController : UIViewController<QBActionStatusDelegate,ContactDelegate>{
    BOOL   activeMotion;
    CGPoint startPoint;
}

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) int currentIndex;
@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, strong) NSArray *friendsOnHolaout;
@property (nonatomic, strong) NSDictionary *seledtedFriend;

- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnSendClicked:(id)sender;

@end
