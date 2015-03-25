//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "AppView.h"
#import "TapWebView.h"

@class UserPhoto;

@interface ProfileView : AppView<UITextFieldDelegate> {
  UIScrollView* container;
  UserPhoto* photo;
  UIButton* btnDone;
}

-(void)setup;

@end
