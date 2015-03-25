//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "AppView.h"
#import "TapWebView.h"
#import "KippySlider.h"

@class KippyPhoto;

@interface KippyProfileView : AppView<UITextFieldDelegate> {
  UIScrollView* container;
  KippyPhoto* photo;
  UIButton* btnDone;
  KippySlider* slider;
  int frequency;
}

-(void)setup:(NSDictionary*)info;

@end
