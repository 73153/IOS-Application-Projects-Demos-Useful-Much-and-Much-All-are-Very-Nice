//
//  ViewController.m
//  ButtonWheel1
//
//  Created by jjf on 11/2/12.
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


#import "ViewController.h"
#import <math.h>

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

// undefine for right handed operation
#define LEFTHANDED 1

@interface ViewController ()

@end

@implementation ViewController

@synthesize controlView;
@synthesize buttons;


-(void)logRect:(CGRect)r msg:(NSString*)str {
  NSLog(@"%@: %4.1f,%4.1f sz: %4.1f,%4.1f",str,r.origin.x,r.origin.y,r.size.width,r.size.height);
}

-(void)buttonPressed:(id)btn {
  UIButton *b = (UIButton*)btn;
  NSLog(@"buttonPressed: %d",b.tag);
}

-(UIButton *)makeButton:(NSString *)imageName tag:(NSInteger)tag {
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  UIImage *im = [UIImage imageNamed:imageName];
  [btn setImage:im forState:UIControlStateNormal];
  [btn setShowsTouchWhenHighlighted:TRUE];
  [btn setTag:tag];
  CGRect r = CGRectMake(0,0, im.size.width, im.size.height);
  btn.frame=r;
  [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
  return btn;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
  self.buttons = [NSMutableArray arrayWithCapacity:6];
  UIButton *btn = [self makeButton:@"favicon.png" tag:0];
  [buttons addObject:btn];
  [buttons addObject:[self makeButton:@"chat.png" tag:1]];
  [buttons addObject:[self makeButton:@"calendar.png" tag:2]];
  [buttons addObject:[self makeButton:@"rss.png" tag:3]];
  [buttons addObject:[self makeButton:@"email.png" tag:4]];
  [buttons addObject:[self makeButton:@"settings.png" tag:5]];
  
  CGRect screenRect = [[UIScreen mainScreen] bounds];
  self.controlView = [JCArcButtonWheelView alloc];
  if (![[UIApplication sharedApplication] isStatusBarHidden]) {
    CGSize sz = screenRect.size;
    sz.height -= [[UIApplication sharedApplication] statusBarFrame].size.height;
    screenRect.size=sz;
  }
  [self logRect:screenRect msg:@"screenRect"];
  
  CGRect viewRect = self.view.frame;
  [self logRect:viewRect msg:@"viewRect"];
  [self logRect:self.view.bounds msg:@"view bounds"];
  
  // I have the center and radius of the wheel set for the chosen background
  
#ifdef LEFTHANDED
    
  //  double ypos=viewRect.size.height*1.1;
  //  double radius=ypos;
  //  CGPoint radialCenter=CGPointMake(-ypos*0.644, ypos);
  //  NSLog(@"centerPt: %4.2f, %4.2f",radialCenter.x,radialCenter.y);
  
  double radius=603;
  CGPoint radialCenter=CGPointMake(-388, 603);
  
  UIImageView *uiv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftbg.png"]];

  [controlView initWithFrame:screenRect buttonArray:buttons leftHanded:TRUE arcCenter:radialCenter radius:radius ];
  
#else
  
  //  double ypos=viewRect.size.height*1.1;
  //  double radius=ypos;
  //  NSLog(@"radius: %4.2f",radius);
  //  CGPoint radialCenter=CGPointMake(320+ypos*0.644, ypos);
  //  NSLog(@"centerPt: %4.2f, %4.2f",radialCenter.x,radialCenter.y);
  
  double radius=603;
  CGPoint radialCenter=CGPointMake(708, 603);
  
  UIImageView *uiv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightbg.png"]];
  
  [controlView initWithFrame:screenRect buttonArray:buttons leftHanded:FALSE arcCenter:radialCenter radius:radius ];
  
#endif
  

  [self.view addSubview:uiv];
  [self.view addSubview:controlView];
  [uiv release];
}

-(void)viewWillAppear:(BOOL)animated {
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)dealloc {
  [controlView release];
  [buttons release];
  
  [super dealloc];
}

@end
