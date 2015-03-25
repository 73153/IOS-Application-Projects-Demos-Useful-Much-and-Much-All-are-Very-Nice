//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapNavigationController.h"

@implementation TapNavigationController

- (BOOL)shouldAutorotate
{
  return self.topViewController.shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
  return self.topViewController.supportedInterfaceOrientations;
}

@end
