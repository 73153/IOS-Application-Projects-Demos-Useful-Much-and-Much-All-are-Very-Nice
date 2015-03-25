//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapApp.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : TapApp {
  NSString* appCode;
  NSString* appVerificationCode;
  NSString* userId;
  CLGeocoder* geoCoder;
  NSDictionary* userData;
  NSDictionary* selectedKippy;

  CLLocationCoordinate2D geofence_v1;
  CLLocationCoordinate2D geofence_v2;
  CLLocationCoordinate2D geofence_v3;
  CLLocationCoordinate2D geofence_v4;
  CLLocationCoordinate2D geofence_v5;
  CLLocationCoordinate2D geofence_v6;
}

@property (nonatomic, copy) NSString* appCode;
@property (nonatomic, copy) NSString* appVerificationCode;
@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSDictionary* userData;
@property (nonatomic, copy) NSDictionary* selectedKippy;

@property CLLocationCoordinate2D geofence_v1;
@property CLLocationCoordinate2D geofence_v2;
@property CLLocationCoordinate2D geofence_v3;
@property CLLocationCoordinate2D geofence_v4;
@property CLLocationCoordinate2D geofence_v5;
@property CLLocationCoordinate2D geofence_v6;

-(CLGeocoder*) geoCoder;

-(void)setStatus:(int)n kippyId:(NSString*)uid;
-(void)setGeofenceStatus:(int)n kippyId:(NSString*)uid;

@end
