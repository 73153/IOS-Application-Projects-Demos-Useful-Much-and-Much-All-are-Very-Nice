//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "AppLabel.h"
#import "TapUtils.h"

@implementation AppLabel

- (id)initWithStyle:(AppLabelStyle)labelStyle {
    self = [super init];
    if (self) {
      label = [[UILabel alloc] init];
      [self addSubview:label];
      label.backgroundColor = [UIColor clearColor];
      label.numberOfLines = 0;
      switch (labelStyle) {
        case AppLabelStyleDefault: {
        } break;
        case AppLabelStyleWhiteBoldCenter: {
          label.font = [UIFont fontWithName:@"DINEngschrift" size:22];
          label.textColor = [UIColor whiteColor];
          label.textAlignment = UITextAlignmentCenter;
        } break;
        case AppLabelStyleBlueBoldCenter: {
          label.font = [UIFont fontWithName:@"DINEngschrift" size:22];
          label.textColor = HEXCOLOR(0x243d4b);
          label.textAlignment = UITextAlignmentCenter;
        } break;
        case AppLabelStyleBlueLeft: {
          label.font = [UIFont fontWithName:@"DINEngschrift" size:18];
          label.textColor = HEXCOLOR(0x243d4b);
          label.textAlignment = UITextAlignmentLeft;
        } break;
        case AppLabelStyleBlueBoldLeft: {
          label.font = [UIFont fontWithName:@"DINEngschrift" size:22];
          label.textColor = HEXCOLOR(0x243d4b);
          label.textAlignment = UITextAlignmentLeft;
        } break;
        case AppLabelStyleGreen: {
          label.font = [UIFont fontWithName:@"DINEngschrift" size:18];
          label.textColor = HEXCOLOR(0x8dc63f);
          label.textAlignment = UITextAlignmentLeft;
        } break;
      }
    }
    return self;
}

-(void)set:(NSString*)text {
  label.text = text;
}

-(void)layoutSubviews {
  label.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
}

@end
