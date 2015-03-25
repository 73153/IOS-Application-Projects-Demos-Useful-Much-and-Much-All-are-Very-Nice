//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapNetworkButtonView.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "ASIHTTPRequest.h"

@implementation TapNetworkButtonView

- (id)initWithFrame:(CGRect)frame url:(NSString*)url {
    self = [super initWithFrame:frame];
    if (self) {
      spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
      spinner.center = CGPointMake(frame.size.width/2, frame.size.height/2);
      [self addSubview:spinner];
      self.clipsToBounds = YES;
      [spinner startAnimating];

      button = [[UIButton alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
      [self addSubview:button];
      button.alpha = 0;

      [[self app] downloadResource:url sender:self];
    }
    return self;
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
  [button addTarget:target action:action forControlEvents:controlEvents];
}

-(void)downloadResourceSuccess:(ASIHTTPRequest*)request {
  [button setImage:[UIImage imageWithData:[request responseData]] forState:UIControlStateNormal];
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.5];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(removeSpinner)];
  button.alpha = 1;
  spinner.alpha = 0;
  [UIView commitAnimations];
}

-(void)downloadResourceFailed:(ASIHTTPRequest*)request {
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.5];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(removeSpinner)];
  spinner.alpha = 0;
  [UIView commitAnimations];
}

-(void)removeSpinner {
  [spinner stopAnimating];
  [spinner removeFromSuperview];
}

@end
