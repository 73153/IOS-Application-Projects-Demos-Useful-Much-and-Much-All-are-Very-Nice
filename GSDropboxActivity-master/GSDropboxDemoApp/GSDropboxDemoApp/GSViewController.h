//
//  GSViewController.h
//  GSDropboxDemoApp
//
//  Created by Simon Whitaker on 25/11/2012.
//  Copyright (c) 2012 Goo Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIProgressView *progressView;
- (IBAction)shareKitten:(id)sender;

@end
