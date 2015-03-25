//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapNavigationController.h"
#import "TapUtils.h"
#import "AppDelegate.h"
#import "AppController.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation AppDelegate

@synthesize appCode, appVerificationCode, userId, userData, geofence_v1, geofence_v2, geofence_v3, geofence_v4, geofence_v5, geofence_v6, selectedKippy;

-(void)openApp:(UIApplication *)application options:(NSDictionary *)launchOptions {

  geoCoder = [[CLGeocoder alloc] init];

  self.appCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"appCode"];
  self.appVerificationCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"appVerificationCode"];
  self.userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];

  self.language = @"en";
  AppController* controller = [[AppController alloc] init];
  navigationController = [[TapNavigationController alloc] initWithRootViewController:controller];
  navigationController.navigationBarHidden = YES;
  self.window.backgroundColor = HEXCOLOR(0xffffff);
  [self.window setRootViewController:navigationController];

  self.window.backgroundColor = HEXCOLOR(0x243d4b);
	[FBAppEvents activateApp];
	[FBAppCall handleDidBecomeActive];

 // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateGeofence:) name:@"KippyMoved" object:nil];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
	// attempt to extract a token from the url
	return [FBAppCall handleOpenURL:url
                sourceApplication:sourceApplication
                  fallbackHandler:^(FBAppCall *call) {
                    NSLog(@"In fallback handler");
                  }];
}

-(void)updateGeofence:(NSNotification*)notification {
  NSDictionary* info = notification.object;
  double lat = 0;
  double lng = 0;
  if(![[info objectForKey:@"lat"] isKindOfClass:[NSNull class]]) {
    lat = [[info objectForKey:@"lat"] doubleValue];
  }
  if(![[info objectForKey:@"lng"] isKindOfClass:[NSNull class]]) {
    lng = [[info objectForKey:@"lng"] doubleValue];
  }
  if(lat != 0 && lng != 0) {
    self.geofence_v1 = CLLocationCoordinate2DMake(lat+0.0125,lng+0.01);
    self.geofence_v2 = CLLocationCoordinate2DMake(lat,lng+0.02);
    self.geofence_v3 = CLLocationCoordinate2DMake(lat-0.015,lng+0.01);
    self.geofence_v4 = CLLocationCoordinate2DMake(lat-0.015,lng-0.01);
    self.geofence_v5 = CLLocationCoordinate2DMake(lat,lng-0.02);
    self.geofence_v6 = CLLocationCoordinate2DMake(lat+0.0125,lng-0.01);
  }
  NSLog(@"updateGeofence");
}

-(CLGeocoder*) geoCoder {
  return geoCoder;
}

-(void)setStatus:(int)n kippyId:(NSString*)uid {
  [self downloadResource:[NSString stringWithFormat:@"%@kippymap_set_operating_status.php?app_code=%@&app_verification_code=%@&kippy_id=%@&operating_status=%d", SERVER_URL, self.appCode, self.appVerificationCode, uid, n] sender:self];
}

-(void)setGeofenceStatus:(int)n kippyId:(NSString*)uid {
  [self downloadResource:[NSString stringWithFormat:@"%@kippymap_setGeofenceStatus.php?app_code=%@&app_verification_code=%@&kippy_id=%@&operating_status=%d", SERVER_URL, self.appCode, self.appVerificationCode, uid, n] sender:self];
}


-(void)downloadResourceSuccess:(ASIHTTPRequest*)request {
  NSLog(@"%@", [request responseString]);
  [[NSNotificationCenter defaultCenter] postNotificationName:@"DataExpired" object:nil];
}

-(void)downloadResourceFailed:(ASIHTTPRequest*)request {
  NSLog(@"%@", [request responseString]);
}


@end
