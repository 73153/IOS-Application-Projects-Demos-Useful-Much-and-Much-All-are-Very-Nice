//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "LoadingView.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"

@implementation LoadingView

- (id)init {
  self = [super init];
  if (self) {
    logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kippy.png"]];
    [self addSubview:logo];
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:spinner];
    [spinner startAnimating];
    [self updateData];
    n = 101;
    inited = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData) name:@"DataExpired" object:nil];
    self.backgroundColor = [UIColor whiteColor];
  }
  return self;
}

-(void)updateData {
  [[self app] downloadResource:[NSString stringWithFormat:@"%@kippymap_getKippyList.php?app_code=%@&app_verification_code=%@", SERVER_URL, [self app].appCode, [self app].appVerificationCode] sender:self];
}

-(void)downloadResourceSuccess:(ASIHTTPRequest*)request {
  n = 0;
  NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[request responseData] options: NSJSONReadingMutableContainers error: nil];
  if(dictionary == nil) {
    [self shakeView:logo];
    [spinner stopAnimating];
  } else {
  //  NSLog(@"%@", dictionary);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"IncomingKippyList" object:dictionary];
    if(!inited) {
      [self performSelector:@selector(openMap:) withObject:dictionary afterDelay:1];
      inited = YES;
    }
  }
}

-(void)downloadResourceFailed:(ASIHTTPRequest*)request {
  n = 0;
  [self shakeView:logo];
  [spinner stopAnimating];
}

-(void)openMap:(NSDictionary*)dictionary {
  [spinner stopAnimating];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"Map" object:dictionary];
}

-(void)layoutSubviews {
  CGSize size = self.frame.size;
  spinner.center = CGPointMake(size.width/2, size.height/2);
  logo.center = CGPointMake(size.width/2,size.height/4);
}

-(void)idle {
  if(n==1000) {
    [self updateData];
  }

  n++;
}

@end
