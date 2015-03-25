//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "GeofenceData.h"
#import "AppDelegate.h"

@implementation GeofenceData

-(AppDelegate*)app {
  return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (id)init {
  self = [super init];
  if (self) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveData) name:@"SaveGeofence" object:nil];
  }
  return self;
}

-(void)saveData {
  if(isBusy) {
    [self performSelector:@selector(saveData) withObject:nil afterDelay:100];
    return;
  }

  [[self app] downloadResource:[NSString stringWithFormat:@"%@kippymap_saveGeofenceData.php?app_code=%@&app_verification_code=%@&marker1_lat=%f&marker1_lng=%f&marker2_lat=%f&marker2_lng=%f&marker3_lat=%f&marker3_lng=%f&marker4_lat=%f&marker4_lng=%f&marker5_lat=%f&marker5_lng=%f&marker6_lat=%f&marker6_lng=%f", SERVER_URL,
    [self app].appCode, [self app].appVerificationCode,
                                [self app].geofence_v1.latitude,[self app].geofence_v1.longitude,
                                [self app].geofence_v2.latitude,[self app].geofence_v2.longitude,
                                [self app].geofence_v3.latitude,[self app].geofence_v3.longitude,
                                [self app].geofence_v4.latitude,[self app].geofence_v4.longitude,
                                [self app].geofence_v5.latitude,[self app].geofence_v5.longitude,
                                [self app].geofence_v6.latitude,[self app].geofence_v6.longitude
                                ] sender:self];
  isBusy = YES;
  isLoad = NO;
  NSLog(@"save geofence");
}

-(void)loadData {
  if(isBusy) {
    [self performSelector:@selector(loadData) withObject:nil afterDelay:100];
    return;
  }
  isBusy = YES;
  isLoad = YES;
  [[self app] downloadResource:[NSString stringWithFormat:@"%@kippymap_getGeofenceMarker.php?app_code=%@&app_verification_code=%@", SERVER_URL, [self app].appCode, [self app].appVerificationCode] sender:self];
  NSLog(@"load geofence");
}

-(void)deleteData {
  if(isBusy) {
    [self performSelector:@selector(deleteData) withObject:nil afterDelay:100];
    return;
  }
  isBusy = YES;
  isLoad = NO;
  [[self app] downloadResource:[NSString stringWithFormat:@"%@kippymap_deleteGeofence.php?app_code=%@&app_verification_code=%@", SERVER_URL, [self app].appCode, [self app].appVerificationCode] sender:self];
  NSLog(@"delete geofence");
}

-(void)downloadResourceSuccess:(ASIHTTPRequest*)request {
  NSLog(@"ok: %@", [request responseString]);
  if(isLoad) {
    NSDictionary *info = [NSJSONSerialization JSONObjectWithData:[request responseData] options: NSJSONReadingMutableContainers error: nil];
    if([[info objectForKey:@"return"] boolValue]) {
      [self app].geofence_v1 = CLLocationCoordinate2DMake([[info objectForKey:@"marker1_lat"] doubleValue],[[info objectForKey:@"marker1_lng"] doubleValue]);
      [self app].geofence_v2 = CLLocationCoordinate2DMake([[info objectForKey:@"marker2_lat"] doubleValue],[[info objectForKey:@"marker2_lng"] doubleValue]);
      [self app].geofence_v3 = CLLocationCoordinate2DMake([[info objectForKey:@"marker3_lat"] doubleValue],[[info objectForKey:@"marker3_lng"] doubleValue]);
      [self app].geofence_v4 = CLLocationCoordinate2DMake([[info objectForKey:@"marker4_lat"] doubleValue],[[info objectForKey:@"marker4_lng"] doubleValue]);
      [self app].geofence_v5 = CLLocationCoordinate2DMake([[info objectForKey:@"marker5_lat"] doubleValue],[[info objectForKey:@"marker5_lng"] doubleValue]);
      [self app].geofence_v6 = CLLocationCoordinate2DMake([[info objectForKey:@"marker6_lat"] doubleValue],[[info objectForKey:@"marker6_lng"] doubleValue]);
      [[NSNotificationCenter defaultCenter] postNotificationName:@"GeofenceChanged" object:nil];
    }
  }
  isBusy = NO;
}

-(void)downloadResourceFailed:(ASIHTTPRequest*)request {
  NSLog(@"ko: %@", [request responseString]);
  isBusy = NO;
}

@end
