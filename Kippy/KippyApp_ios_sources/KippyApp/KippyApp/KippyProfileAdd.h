//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "AppView.h"
#import "TapWebView.h"

@class KippyPhoto;

@interface KippyProfileAdd : AppView<UITextFieldDelegate> {
  UIScrollView* container;
  KippyPhoto* photo;
  UIButton* btnDone;
}

-(void)setup:(NSDictionary*)info;

@end
