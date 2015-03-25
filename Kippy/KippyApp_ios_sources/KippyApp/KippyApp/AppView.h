//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapView.h"

@class HeaderView;

@interface AppView : TapView {
  HeaderView* headerView;
  UIButton* standbyBtn;
  UIActivityIndicatorView* spinner;
}

- (id)initWithTitle:(NSString*)title;
-(void)standby;
-(void)enable;
-(void)disable;

@end
