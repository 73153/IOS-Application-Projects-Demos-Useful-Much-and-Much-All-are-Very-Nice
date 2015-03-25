//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapView.h"

@class AppLabel;

@interface FormInput : TapView {
  UIView* line;
  AppLabel* label;
  UITextField* input;
}

-(id)initWithLabel:(NSString*)s1 placeholder:(NSString*)s2;
-(UITextField*)input;

@end
