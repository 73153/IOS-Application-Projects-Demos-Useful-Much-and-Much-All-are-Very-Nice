//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "AppView.h"
#import "TapWebView.h"

@interface InfoView : AppView{
  TapWebView* webView;
  BOOL inited;
}

-(void)setup;

@end
