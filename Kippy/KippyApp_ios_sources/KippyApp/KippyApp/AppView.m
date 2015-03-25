  //
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapUtils.h"
#import "AppView.h"
#import "HeaderView.h"

@implementation AppView

- (id)initWithTitle:(NSString*)title {
    self = [super init];
    if (self) {
      standbyBtn = [[UIButton alloc] init];
      [standbyBtn addTarget:self action:@selector(standby) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:standbyBtn];
      self.backgroundColor = HEXCOLOR(0xe6e6e6);
      headerView = [[HeaderView alloc] initWithTitle:title];
      [self addSubview:headerView];
      spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
      [self addSubview:spinner];
    }
    return self;
}

-(void)standby {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"Standby" object:nil];
}

-(void)layoutSubviews {
  CGSize size = self.frame.size;
  spinner.center = CGPointMake(size.width/2, size.height/2);
  standbyBtn.frame = CGRectMake(0, 0, size.width, size.height);
  headerView.frame = CGRectMake(0, 0, size.width, 44);
}

-(void)disable {
  [spinner startAnimating];
  [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
    self.alpha = 0.5;
  } completion:nil];
  self.userInteractionEnabled = NO;
}

-(void)enable {
  [spinner stopAnimating];
  [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
    self.alpha = 1;
  } completion:nil];
  self.userInteractionEnabled = YES;
}

@end
