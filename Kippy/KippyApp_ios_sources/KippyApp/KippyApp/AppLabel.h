//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapView.h"

typedef enum {
  AppLabelStyleDefault,
  AppLabelStyleWhiteBoldCenter,
  AppLabelStyleBlueBoldCenter,
  AppLabelStyleBlueLeft,
  AppLabelStyleBlueBoldLeft,
  AppLabelStyleGreen
} AppLabelStyle;

@interface AppLabel : TapView {
  UILabel* label;
}

- (id)initWithStyle:(AppLabelStyle)labelStyle;
- (void)set:(NSString*)text;

@end
