//
//  FriendsViewController.h
//  Holaout
//
//  Created by Amit Parmar on 06/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface FriendsViewController : UIViewController<QBActionStatusDelegate,ContactDelegate>{
    IBOutlet UIImageView *imageView;
    BOOL   activeMotion;
    CGPoint startPoint;
}

@property (nonatomic, strong) IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSArray *friendsOnHolaout;
@property (nonatomic, strong) NSArray *checkInsData;


- (IBAction)btnPhotoClicked:(id)sender;
- (IBAction)btnVideoClicked:(id)sender;
- (IBAction)btnDrawingClicked:(id)sender;
- (void)dismiss;
- (void)leftSideMenuButtonPressed:(id)sender;
- (void) getCheckIns;

@end
