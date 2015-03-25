//
//  iLikeItAppDelegate.h
//  iLikeIt
//
//  Created by Regular Berry on 3/20/11.
//  Copyright 2011 Regular Berry Software LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iLikeItViewController;

@interface iLikeItAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet iLikeItViewController *viewController;

@end
