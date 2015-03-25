//
//  JCArcButtonWheelView
//  ButtonWheel1
//
//  Created by John Fowler on 11/2/12.
//  Copyright (c) 2012 johnscode.com. All rights reserved.
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

#import <UIKit/UIKit.h>

#define kTOUCHBAND 25

@interface JCArcButtonWheelView : UIView

@property (nonatomic,retain) UIView *controlView;
@property (nonatomic,retain) NSArray *imageNames;
@property (nonatomic,retain) NSMutableArray *buttons;

// sets whether the wheel will be operated left or right handed
@property (readonly) BOOL leftHanded;

// the 'center' of the wheel relative to the screen
@property (assign) CGPoint radialCenter;

// the radius of the wheel
@property (assign) double radius;

// the 'current' angle of the wheel rotation, angle = 0 represents the rotation that places
// button0 at the upper right (or left depending on the value of leftHanded)
@property (assign) double angle;

// the position of the first button, angle within the sweep
@property (assign) double firstAngle;

// the angular separation of the buttons
@property (assign) double delta;

// the minimum visible angle in the sweep
@property (assign) double theta1;

// the maximum visible angle in the sweep
@property (assign) double theta2;

@property (assign) int numVisible;

// the total angle given the number of buttons a user can rotate before 'rollover'
// numbuttons * delta
@property (assign) double fullSweep;

// theta2 - theta1
@property (assign) double visibleArc;

// how fast did the user swipe
@property (assign) double touchVel;

// the wheel is currently spinning
@property (assign) BOOL spinningWheel;

// allows the wheel to spin after user's touch ends, a little more realistic
// adjust the constants to get the feel you want. It's pretty subjective.
@property (nonatomic,retain) NSTimer *spinTimer;

-(id)initWithFrame:(CGRect)frame buttonArray:(NSArray*)buttonArray leftHanded:(BOOL)leftHanded arcCenter:(CGPoint)theCenter radius:(double)theRadius;
-(void)setLeftHanded:(BOOL)leftHanded;

@end
