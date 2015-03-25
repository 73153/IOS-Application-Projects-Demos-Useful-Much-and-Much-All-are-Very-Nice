//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapBox2DController.h"
#import "TapBox2DView.h"

@implementation TapBox2DController


- (void)loadUi {
  [super loadUi];
  TapBox2DView* view = [[TapBox2DView alloc] init];
  self.view = view;
}

- (void)unloadUi {
  self.view = nil;
  [super unloadUi];
}

-(b2Body*)addPhysicalBodyForView:(UIView *)view {
  return [((TapBox2DView*)self.view) addPhysicalBodyForView:view];
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
  [((TapBox2DView*)self.view) accelerometer:accelerometer didAccelerate:acceleration];
}

-(void)idle {
  [((TapBox2DView*)self.view) idle];
}

@end
