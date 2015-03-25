//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapView.h"

@interface TapNetworkButtonView : TapView {
  UIActivityIndicatorView* spinner;
  UIButton* button;
}

- (id)initWithFrame:(CGRect)frame url:(NSString*)url;
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
