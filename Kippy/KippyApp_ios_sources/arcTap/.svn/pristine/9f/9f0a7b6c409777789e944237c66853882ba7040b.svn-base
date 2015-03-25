//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapView.h"
#include <Box2D/Box2d.h>

#define PTM_RATIO 16

@interface TapBox2DView : TapView {
  b2World* world;
	b2Body* groundBody;
  b2MouseJoint* mouseJoint;
}

-(b2Body*)addPhysicalBodyForView:(UIView *)physicalView;
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;
-(void)idle;

@end
