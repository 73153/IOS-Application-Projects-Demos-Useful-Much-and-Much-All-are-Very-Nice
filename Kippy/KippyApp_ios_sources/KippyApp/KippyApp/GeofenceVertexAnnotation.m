//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "GeofenceVertexAnnotation.h"
#import "AppDelegate.h"

@implementation GeofenceVertexAnnotation

@synthesize coordinate, info;

-(AppDelegate*)app {
  return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (id) initWithIndex:(int)index {
  self = [super init];
  if (self) {
    vertexIndex = index;
    switch (index) {
      case 1:
        coordinate = [self app].geofence_v1;
        break;
      case 2:
        coordinate = [self app].geofence_v2;
        break;
      case 3:
        coordinate = [self app].geofence_v3;
        break;
      case 4:
        coordinate = [self app].geofence_v4;
        break;
      case 5:
        coordinate = [self app].geofence_v5;
        break;
      case 6:
        coordinate = [self app].geofence_v6;
        break;
     default:
        break;
    }
  }
  return self;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
  switch (vertexIndex) {
    case 1:
      coordinate = [self app].geofence_v1 = newCoordinate;
      break;
    case 2:
      coordinate = [self app].geofence_v2 = newCoordinate;
      break;
    case 3:
      coordinate = [self app].geofence_v3 = newCoordinate;
      break;
    case 4:
      coordinate = [self app].geofence_v4 = newCoordinate;
      break;
    case 5:
      coordinate = [self app].geofence_v5 = newCoordinate;
      break;
    case 6:
      coordinate = [self app].geofence_v6 = newCoordinate;
      break;
    default:
      break;
  }
  [[NSNotificationCenter defaultCenter] postNotificationName:@"GeofenceChanged" object:nil];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"SaveGeofence" object:nil];
}

@end
