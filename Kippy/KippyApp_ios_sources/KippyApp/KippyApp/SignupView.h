//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "AppView.h"

@class InputView;

@interface SignupView : AppView {
  UIImageView* bg;
  InputView* email;
  InputView* name;
  InputView* surname;
  InputView* password;
  UIButton* btnDone;

  BOOL checkEmail;
}

@end
