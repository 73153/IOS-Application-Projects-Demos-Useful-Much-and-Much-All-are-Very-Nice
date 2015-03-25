//
//  AppDelegate.h
//  Holaout
//
//  Created by Amit Parmar on 04/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class AcceptCallViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,QBActionStatusDelegate,QBActionStatusDelegate,QBChatDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong ,nonatomic) NSString *databaseName;
@property (strong ,nonatomic) NSString *databasePath;
@property (nonatomic) int userID;
@property (nonatomic, strong) QBVideoChat *videoChat;
@property (nonatomic, strong) NSDictionary *selectedFriend;
@property (nonatomic, strong) AcceptCallViewController *acceptViewController;

- (void) callButtoClicked:(int)userId;

+(AppDelegate *)appdelegate;
//- (void) getCheckIns;

@end
