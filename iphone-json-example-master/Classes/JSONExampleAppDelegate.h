//
//  JSONExampleAppDelegate.h
//  JSONExample
//
//  Created by Christopher Burnett on 12/17/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSONExampleViewController;

@interface JSONExampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    JSONExampleViewController *viewController;
	NSMutableData *jsonData;
}

- (void)getJSONFeed;
- (NSDictionary *)parseJSON:(NSMutableData *)data;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet JSONExampleViewController *viewController;
@property (nonatomic, retain) NSMutableData *jsonData;

@end

