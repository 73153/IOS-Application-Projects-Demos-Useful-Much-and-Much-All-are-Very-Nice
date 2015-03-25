//
// Copyright 2011-2012 Adar Porat (https://github.com/aporat)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "MainViewController.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	CGRect statusToolbarFrame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 44);
	self.statusToolbar = [[KKProgressToolbar alloc] initWithFrame:statusToolbarFrame];
	self.statusToolbar.actionDelegate = self;
	[self.view addSubview:self.statusToolbar];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}
- (void)didCancelButtonPressed:(KKProgressToolbar *)toolbar {
    [self stopUILoading];
}


- (IBAction)startUILoading  {
    
    self.statusToolbar.statusLabel.text = @"Loading from server...";
    [self.statusToolbar show:YES completion:^(BOOL finished) {
        
    }];
    
}


- (IBAction)stopUILoading {
    [self.statusToolbar hide:YES completion:^(BOOL finished) {
        
    }];
    
}

@end
