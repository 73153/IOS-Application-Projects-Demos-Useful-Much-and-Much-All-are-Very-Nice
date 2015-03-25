//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "Proximity.h"

#define degreesToRadians(x) (M_PI * x / 180.0)
#define radiandsToDegrees(x) (x * 180.0 / M_PI)

@implementation Proximity

- (id)init {
    self = [super init];
    if (self) {
      motionManager = [[CMMotionManager alloc] init];
      motionManager.showsDeviceMovementDisplay = YES;
      motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
      [motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXTrueNorthZVertical];
      self.backgroundColor = [UIColor whiteColor];
      bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compass.png"]];
      [self addSubview:bg];
      indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compass-indicator.png"]];
      [self addSubview:indicator];
      kippyDir = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kippy_dir.png"]];
      [self addSubview:kippyDir];
    }
    return self;
}


-(void)layoutSubviews {
  CGSize size = self.frame.size;
  bg.center = CGPointMake(size.width/2,size.height/2);
  indicator.center = CGPointMake(size.width/2,size.height/2);
  kippyDir.center = CGPointMake(size.width/2,size.height/2);
}

- (void)setHeadingForDirectionFromCoordinate:(CLLocationCoordinate2D)fromLoc toCoordinate:(CLLocationCoordinate2D)toLoc {
  float fLat = degreesToRadians(fromLoc.latitude);
  float fLng = degreesToRadians(fromLoc.longitude);
  float tLat = degreesToRadians(toLoc.latitude);
  float tLng = degreesToRadians(toLoc.longitude);
  float odegree = radiandsToDegrees(atan2(sin(tLng-fLng)*cos(tLat), cos(fLat)*sin(tLat)-sin(fLat)*cos(tLat)*cos(tLng-fLng)));
  float degree = odegree-30;
  if (degree >= 0) {
    degree = degree;
  } else {
    degree = 360+degree;
  }
	CMDeviceMotion *d = motionManager.deviceMotion;
	if (d != nil) {
    lastDegree = degree;
    indicator.transform = CGAffineTransformMakeRotation(d.attitude.yaw+degreesToRadians(lastDegree));
    bg.transform = CGAffineTransformMakeRotation(d.attitude.yaw);
    kippyDir.transform = CGAffineTransformMakeRotation(d.attitude.yaw-54);
	}
  degree = odegree;
  if (degree >= 0) {
    degree = degree;
  } else {
    degree = 360+degree;
  }
  [[NSNotificationCenter defaultCenter] postNotificationName:@"PetDirection" object:[NSNumber numberWithInt:degree]];
  MKMapPoint p1 = MKMapPointForCoordinate(fromLoc);
  MKMapPoint p2 = MKMapPointForCoordinate(toLoc);
  int kmDistance = (int)(MKMetersBetweenMapPoints(p1, p2)/1000);
  [[NSNotificationCenter defaultCenter] postNotificationName:@"PetDistance" object:[NSNumber numberWithInt:kmDistance]];
}

-(void)idle {
	CMDeviceMotion *d = motionManager.deviceMotion;
	if (d != nil) {
    indicator.transform = CGAffineTransformMakeRotation(d.attitude.yaw+degreesToRadians(lastDegree));
    bg.transform = CGAffineTransformMakeRotation(d.attitude.yaw);
	}
}


@end
