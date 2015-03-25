//
//  JCButtonArcView.m
//  ButtonWheel1
//
//  Created by John Fowler on 11/2/12.
//  Copyright (c) 2012 johnscode.com. All rights reserved.
//
// TODO: Create an arc version of this control
//
/*
 Copyright 2012 John J. Fowler
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "JCArcButtonWheelView.h"
#import <math.h>

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

#define kFirstImageOffset 2.5   // degrees
#define kImageSeparation  10    // degrees


@implementation JCArcButtonWheelView

@synthesize leftHanded=_leftHanded;
@synthesize controlView;
@synthesize buttons;
@synthesize angle;
@synthesize firstAngle;
@synthesize radialCenter;
@synthesize radius;
@synthesize delta;
@synthesize theta1;
@synthesize theta2;
@synthesize numVisible;
@synthesize fullSweep;
@synthesize visibleArc;
@synthesize touchVel;
@synthesize spinningWheel;
@synthesize spinTimer;

-(void)logRect:(CGRect)r msg:(NSString*)str {
  NSLog(@"%@: %4.1f,%4.1f sz: %4.1f,%4.1f",str,r.origin.x,r.origin.y,r.size.width,r.size.height);
}

-(id)initWithFrame:(CGRect)frame buttonArray:(NSArray*)buttonArray leftHanded:(BOOL)leftHanded arcCenter:(CGPoint)theCenter radius:(double)theRadius {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    self.buttons=[NSMutableArray arrayWithArray:buttonArray];
    self.controlView = [[UIView alloc] initWithFrame:frame];
    if (leftHanded) {
      [self configureLeftHandedWithArcCenter:theCenter radius:theRadius];
    } else {
      [self configureRightHandedWithArcCenter:theCenter radius:theRadius];
    }
    [self assembleViews];
  }
  return self;
}

-(void)setLeftHanded:(BOOL)leftHanded {
  if (leftHanded!=_leftHanded) {
    if (leftHanded) {
      [self configureLeftHandedWithArcCenter:radialCenter radius:radius];
    } else {
      [self configureRightHandedWithArcCenter:radialCenter radius:radius];
    }
    [controlView setNeedsDisplay];
  }
}

-(void)configureRightHandedWithArcCenter:(CGPoint)theCenter radius:(double)theRadius {
  _leftHanded=FALSE;
  self.radialCenter=theCenter;
  self.radius=theRadius;
  CGRect viewRect = self.frame;
  
  // find the visible portion of a circle of 'radius' centered a radialCenter, Note: we use
  // a simplifying assumption: the center is below and right of the screen and it intersects
  // on the right and bottom sides
  // compute the intersection of the right side of screen to a line of length radius from center
  self.theta1=asin((320-radialCenter.x)/radius);
  // compute the intersection of the bottom side of screen to a line of length radius from center
  self.theta2=-M_PI+acos((viewRect.size.height-radialCenter.y)/radius); // this corrects to give us a 3rd/4th quadrant arccos for [-1,0)
  self.visibleArc=fabs(theta2-theta1);
  NSLog(@"visible arc: %4.2f from %4.2f to %4.2f",RADIANS_TO_DEGREES(visibleArc),RADIANS_TO_DEGREES(theta1),RADIANS_TO_DEGREES(theta2));
  self.angle=0;
  self.firstAngle=theta1-DEGREES_TO_RADIANS(kFirstImageOffset);
  NSLog(@"first angle: %4.2f",RADIANS_TO_DEGREES(firstAngle));
  self.delta=DEGREES_TO_RADIANS(kImageSeparation);
  self.numVisible=trunc(fabs(theta2-firstAngle)/delta); // approximately
  NSLog(@"numVisible: %d",numVisible);
  self.fullSweep=delta*[buttons count];
  NSLog(@"fullSweep is %4.2f",RADIANS_TO_DEGREES(fullSweep));
//  self.currentIndex=0; 

}

-(void) configureLeftHandedWithArcCenter:(CGPoint)theCenter radius:(double)theRadius {
  _leftHanded=TRUE;
  self.radialCenter=theCenter;
  self.radius=theRadius;
  CGRect viewRect = self.frame;
  [self logRect:viewRect msg:@"buttonView rect"];

  // find the visible portion of a circle of 'radius' centered a radialCenter, Note: we use
  // a simplifying assumption: the center is below and left of the screen and it intersects
  // on the left and bottom sides
  // compute the intersection of the left side of screen to a line of length radius from center
  self.theta1=asin((0-radialCenter.x)/radius);
  // compute the intersection of the bottom side of screen to a line of length radius from center
  self.theta2=M_PI-acos((viewRect.size.height-radialCenter.y)/radius); //want a 1st/2nd quadrant arccos for [-1,0)
  self.visibleArc=fabs(theta2-theta1);
  NSLog(@"visible arc: %4.2f from %4.2f to %4.2f",RADIANS_TO_DEGREES(visibleArc),RADIANS_TO_DEGREES(theta1),RADIANS_TO_DEGREES(theta2));
  self.angle=0;
  self.firstAngle=theta1+DEGREES_TO_RADIANS(kFirstImageOffset);
  NSLog(@"first angle: %4.2f",RADIANS_TO_DEGREES(firstAngle));
  self.delta=DEGREES_TO_RADIANS(kImageSeparation);
  self.numVisible=trunc(fabs(theta2-firstAngle)/delta); // approximately
  NSLog(@"numVisible: %d",numVisible);
  self.fullSweep=delta*[buttons count];
  NSLog(@"fullSweep is %4.2f",RADIANS_TO_DEGREES(fullSweep));

}

-(void)assembleViews {
  [self positionImages];
  for (UIButton *imv in buttons) {
    [controlView addSubview:imv];
  }
  [self addSubview:controlView];
}

-(void)clearSpin {
  self.touchVel=0;
  self.spinningWheel=FALSE;
}

-(void)spinWheel {
  [self performSelectorOnMainThread:@selector(repositionImagesWithDelta:) withObject:[NSNumber numberWithDouble:self.touchVel] waitUntilDone:false];
  // FIXME: make the decay multiplier configurable
  self.touchVel*=0.9;
  if (fabs(touchVel)<0.005) {
    [self clearSpin];
    [spinTimer invalidate];
    self.spinTimer=nil;
  }
}

-(void)repositionImagesWithDelta:(NSNumber*)increment {
  //  NSLog(@"move by %4.3f",[increment doubleValue]);
  self.angle+=[increment doubleValue];
  // this is where i handle rollover. the point is that if the current angle is 
  // within 'delta' of the bounds, rollover to the other side of the range.
  // Note that the bounds is twice the fullSweep. This is because the first button
  // could be at the last  visible position and the last button could be at the
  // first visible position.
  // FIXME: need to figure out what to do when numBtns*delta > 2PI
  if (angle<(delta-fullSweep)) angle+=2*fullSweep;
  else if (angle>(fullSweep-delta)) angle-=2*fullSweep;
  [self positionImages];
}

-(void)positionImages {
  for (int i=0;i<[buttons count];i++) {
    int actualIndex = i; //(currentIndex+i)%[imageViews count];
    UIButton *btnView = [buttons objectAtIndex:actualIndex];
    double x,y,a;
    double offset=0;
    // this is where we roll the images. I assume the buttons don't make up a
    // full circle but I want the wheel to appear 'seamless'. So if I get to a
    // part of the rotation where there would be empty spots in the visible arc,
    // I rotate the button offsets to make the wheel appear 'seamless'.
    // FIXME: need to figure out what to do when numBtns*delta > 2PI
    if (self.leftHanded) {
      offset=angle+(delta*i);
      if (offset<0) offset+=fullSweep;
      else if (offset>fullSweep) offset-=fullSweep;
    } else {
      offset=angle-(delta*i);
      if (offset>0) offset-=fullSweep;
      else if (offset<(-fullSweep)) offset+=fullSweep;
    }
    a=firstAngle+offset;
    x = radialCenter.x + sin(a)*radius;
    y = radialCenter.y - cos(a)*radius;
    btnView.center=CGPointMake(x, y);

    btnView.alpha=(CGRectContainsRect(controlView.bounds, btnView.frame))?1.0:0.0;
  }
}

-(BOOL)ptInTouchBand:(CGPoint)pt {
  return [self ptInCircle:radialCenter radius:radius+kTOUCHBAND point:pt]&&![self ptInCircle:radialCenter radius:radius-kTOUCHBAND point:pt];
}

-(BOOL)ptInCircle:(CGPoint) ctr radius:(double)cradius point:(CGPoint)pt {
  return pow(pt.x-ctr.x, 2)+pow(pt.y-ctr.y, 2)<=pow(cradius, 2);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  if (spinTimer) {
    [spinTimer invalidate];
    self.spinTimer=nil;
  }
  [self clearSpin];
  if ([touches count]==1) {
    UITouch *touch=(UITouch*)[[touches objectEnumerator] nextObject];
    CGPoint pt=[touch locationInView:controlView];
    if ([self ptInTouchBand:pt]) {
      self.spinningWheel=true;
    } else {
      [super touchesBegan:touches withEvent:event];
    }
  } else {
    [super touchesBegan:touches withEvent:event];
  }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  if ( [touches count]>=1) {
    UITouch *touch=(UITouch*)[[touches objectEnumerator] nextObject];
    CGPoint pt=[touch locationInView:controlView];
    if (self.spinningWheel) {
      CGPoint lastPt=[touch previousLocationInView:controlView];
      //    NSLog(@"  x: %3.1f, y: %3.1f",pt.x,pt.y);
      //    NSLog(@"  lx: %3.1f, ly: %3.1f",lastPt.x,lastPt.y);
      // here we come up with a number to represent the velocity of the swipe, it IS NOT the true velocity
      // we don't need the TRUE velocity, just something that gets large if we swipe faster. We use 2xradius
      // to avoid NaN in the arccos and arcsin
      double x2=asin((pt.x-radialCenter.x)/(2*radius));
      double x1=asin((lastPt.x-radialCenter.x)/(2*radius));
      double y2=M_PI-acos((pt.y-radialCenter.y)/(2*radius));
      double y1=M_PI-acos((lastPt.y-radialCenter.y)/(2*radius));
      //    NSLog(@"  y1: %4.3f, y2: %4.3f",RADIANS_TO_DEGREES(y1),RADIANS_TO_DEGREES(y2));
      if (!self.leftHanded) {
        // adjust for 3rd/4th quadrant arccos
        y2=-y2;
        y1=-y1;
      }
      // FIXME: make the multiplier configurable
      double approxVel=2*MAX(x2-x1, y2-y1); // 'correct' for the extra radius
                                            //  double approxVel=x2-x1;
      self.touchVel=approxVel;
      
      [self performSelectorOnMainThread:@selector(repositionImagesWithDelta:) withObject:[NSNumber numberWithDouble:approxVel] waitUntilDone:false];
    } else {
      [super touchesMoved:touches withEvent:event];
    }
  } else {
    [super touchesMoved:touches withEvent:event];
  }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  if ([touches count]>=1) {
    if (spinningWheel) {
      if (fabs(touchVel)>0.0262) {
        self.spinTimer = [NSTimer timerWithTimeInterval:0.03 target:self selector:@selector(spinWheel) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:spinTimer forMode:NSDefaultRunLoopMode];
      } else {
        [self clearSpin];
      }
    } else {
      [super touchesEnded:touches withEvent:event];
    }
  }
   else {
    [super touchesEnded:touches withEvent:event];
  }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//  NSLog(@"touchesEnded: ");
  [self clearSpin];
  [super touchesCancelled:touches withEvent:event];
}

-(void)dealloc {
  if (spinTimer) {
    [spinTimer invalidate];
    self.spinTimer=nil;
  }
  [controlView release];
  [buttons release];
  
  [super dealloc];
}

@end
