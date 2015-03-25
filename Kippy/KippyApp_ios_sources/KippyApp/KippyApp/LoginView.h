//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapView.h"
#import <FacebookSDK/FacebookSDK.h>

@interface LoginView : TapView<FBLoginViewDelegate> {
  UIImageView* logo;
  UIView* btns;
  FBLoginView* btnFb;
  int n;
  BOOL fbdone;
}

-(void)idle;

@end
