//
//  AppDelegate.h
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class EditPersonalInfoViewController;
@class FirstViewController;
@class MedicineViewController;
@class GraphViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) NSString *databaseName;
@property (nonatomic, strong) NSString *databasePath;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) EditPersonalInfoViewController *editViewController;
@property (nonatomic, strong) FirstViewController *firstViewController;
@property (nonatomic, strong) MedicineViewController *medicineViewController;
@property (nonatomic, strong) GraphViewController *graphViewController;

@end
