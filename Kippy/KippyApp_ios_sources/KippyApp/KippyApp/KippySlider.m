//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "KippySlider.h"

@implementation KippySlider

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      UIImageView* bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slider.png"]];
      [self addSubview:bg];
      indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slider_pin.png"]];
      [self addSubview:indicator];
   }
    return self;
}

-(void)setMinutes:(int)n {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"FrequencyChanged" object:[NSNumber numberWithInt:n]];
  indicator.center = CGPointMake(64+(n-1)*8, 16);
  indicator.alpha = 1;
}

-(void)reset {
  indicator.alpha = 0;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  int value = location.x;
  if(value < 64)
    value = 64;
  if(value > 54+200)
    value = 254;
  [self setMinutes:(value-64)/8+1];
}

@end
