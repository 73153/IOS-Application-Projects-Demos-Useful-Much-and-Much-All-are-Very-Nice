//
//  Copyright (c) 2012 Click'nTap SRL. All rights reserved.
//

#import "TapWebView.h"

@implementation TapWebView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    for(UIView* view in [self subviews]) {
      if([view isKindOfClass:[UIScrollView class]]) {
        ((UIScrollView*)view).showsVerticalScrollIndicator = NO;
        //((UIScrollView*)view).bounces = NO;
      }
      for(UIView* subview in [view subviews])
        if([subview isKindOfClass:[UIImageView class]])
          subview.hidden = YES;
    }
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self setBackgroundColor:[UIColor clearColor]];
    self.opaque = NO;
    [self addSubview:spinner];
    [self startAnimating];
    self.scalesPageToFit = YES;
    self.delegate = self;
  }
  return self;
}

-(void)layoutSubviews {
  spinner.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
}

-(void)startAnimating {
  [spinner startAnimating];
}

-(void)stopAnimating {
  [spinner stopAnimating];
}

- (void)webView:(UIWebView *)aWebView didFailLoadWithError:(NSError *)error {
  [self stopAnimating];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  for(UIView* view in [self subviews]) {
    if(![view isKindOfClass:[UIActivityIndicatorView class]]) {
      view.alpha = 1;
    }
  }
  if(navigationType != UIWebViewNavigationTypeLinkClicked) {
    [self startAnimating];
  }
  return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)aWebView {
  for(UIView* view in [self subviews]) {
    if(![view isKindOfClass:[UIActivityIndicatorView class]]) {
      view.alpha = 1;
    }
  }
  [self startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.5];
  for(UIView* view in [self subviews]) {
    if(![view isKindOfClass:[UIActivityIndicatorView class]]) {
      view.alpha = 1;
    }
  }
  [UIView commitAnimations];
  [self stopAnimating];
}


@end
