//
//  VideoListViewController.h
//  Holaout
//
//  Created by Amit Parmar on 16/01/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGBox.h"
#import "MGScrollView.h"
#import "JSONModelLib.h"
#import "VideoModel.h"
#import "PhotoBox.h"

@interface VideoListViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet MGScrollView * scroller;
@property (nonatomic, strong) MGBox* searchBox;
@property (nonatomic, strong) NSArray* videos;
@property (nonatomic, strong) NSDictionary *selectedFriend;

- (IBAction)backButtonClicked:(id)sender;

@end
