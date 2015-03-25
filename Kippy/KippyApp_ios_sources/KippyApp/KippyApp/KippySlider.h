//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapView.h"

@interface KippySlider : TapView {
  UIImageView* indicator;
}

-(void)setMinutes:(int)n;
-(void)reset;

@end
