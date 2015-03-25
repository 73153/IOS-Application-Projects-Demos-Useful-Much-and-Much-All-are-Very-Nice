//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapView.h"

@interface InputView : TapView<UITextFieldDelegate> {
  UILabel* label;
  UITextField* input;
}

- (id)initWithLabel:(NSString*)label placeholder:(NSString*)placeholder frame:(CGRect)frame;

-(UITextField*)input;

@end
