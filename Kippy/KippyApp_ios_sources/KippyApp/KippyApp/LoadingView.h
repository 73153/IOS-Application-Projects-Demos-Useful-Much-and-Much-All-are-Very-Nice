//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapView.h"

@interface LoadingView : TapView {
  UIImageView* logo;
  UIActivityIndicatorView* spinner;
  int n;
  BOOL inited;
}

-(void)idle;

@end
