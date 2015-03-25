//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapButton.h"
#import "TapUtils.h"

@implementation TapButton

- (id)initWithUnicode:(NSString*)unicode color:(UIColor*)color {
    self = [super init];
    if (self) {
      iconLabel = [[UILabel alloc] init];
      iconLabel.textColor = color;
      iconLabel.backgroundColor = [UIColor clearColor];
      iconLabel.text = unicode;
      iconLabel.textAlignment = NSTextAlignmentCenter;
      [self addSubview:iconLabel];
      iconLabel.userInteractionEnabled = NO;
    }
    return self;
}

- (void)update:(NSString*)unicode color:(UIColor*)color {
  iconLabel.text = unicode;
  iconLabel.textColor = color;
}

-(void)layoutSubviews {
  CGSize size = self.frame.size;
  iconLabel.frame = CGRectMake(0, 0, size.width, size.height);
  if(IS_IPAD) {
    iconLabel.font = [UIFont fontWithName:@"FontAwesome" size:size.width/3];
  } else {
    iconLabel.font = [UIFont fontWithName:@"FontAwesome" size:size.width/2];
  }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  iconLabel.alpha = 0.5;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  iconLabel.alpha = 1;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];
  iconLabel.alpha = 1;
}


@end
