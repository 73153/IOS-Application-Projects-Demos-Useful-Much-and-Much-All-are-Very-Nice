//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "InfoView.h"
#import "AppDelegate.h"

@implementation InfoView

- (id)initWithTitle:(NSString *)title {
  self = [super initWithTitle:title];
  if (self) {
    webView = [[TapWebView alloc] init];
    webView.scalesPageToFit = NO;
    [self addSubview:webView];
    inited = NO;
  }
  return self;
}

-(void)setup {
  if(!inited) {
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.kippy.eu/app.html"]]];
    inited = YES;
  }
}

-(void)layoutSubviews {
  [super layoutSubviews];
  CGSize size = self.frame.size;
  webView.frame = CGRectMake(0, 44, size.width, size.height-44);
}

@end
