//
//  Copyright (c) 2012 Click'nTap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapNetwork.h"
#import <AVFoundation/AVFoundation.h>

@interface TapApp : UIResponder <UIApplicationDelegate, UIAccelerometerDelegate> {
  UINavigationController* navigationController;
  TapNetwork* network;
  NSString* language;
  AVAudioPlayer* music;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (nonatomic, copy) NSString* language;

-(void)openApp:(UIApplication *)application options:(NSDictionary*)launchOptions;
-(void)closeApp;

-(void)registerDownload:(ASIHTTPRequest*)request sender:(NSObject*)sender;
-(void)downloadResourceToPath:(NSString*)url sender:(NSObject*)sender path:(NSString*)path;
-(void)downloadResource:(NSString*)url sender:(NSObject*)sender;
-(void)cancelDownloadResource:(NSObject*)sender;
-(void)playSound:(NSString*)resource ofType:(NSString*)ofType;

@end
