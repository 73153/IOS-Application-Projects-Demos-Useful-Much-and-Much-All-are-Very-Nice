//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapView.h"
#import <MapKit/MapKit.h>
#import <CoreMotion/CoreMotion.h>

@interface Proximity : TapView {
  UIImageView* bg;
  UIImageView* indicator;
  UIImageView* kippyDir;
  CMMotionManager* motionManager;
  int lastDegree;

  
}

- (void)setHeadingForDirectionFromCoordinate:(CLLocationCoordinate2D)fromLoc toCoordinate:(CLLocationCoordinate2D)toLoc;
- (void)idle;

@end
