//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapTapView.h"

@implementation TapTapView

-(void)openMe {
}

-(void)openMeSync {
  [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(openMe) object:nil];
  [self performSelector:@selector(openMe) withObject:nil afterDelay:0.3];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.05];
  self.transform = CGAffineTransformMakeScale(0.98, 0.98);
  [UIView commitAnimations];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.2];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(openMeSync)];
  self.transform = CGAffineTransformMakeScale(1.0, 1.0);
  [UIView commitAnimations];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.2];
  self.transform = CGAffineTransformMakeScale(1.0, 1.0);
  [UIView commitAnimations];
}

@end
