//
//  PrivacyPolicyViewController.m
//  Holaout
//
//  Created by Amit Parmar on 06/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "PrivacyPolicyViewController.h"

@implementation PrivacyPolicyViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
//    NSURL *url = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"Text" ofType:@"pdf"]];
//    [webView loadRequest:[[NSURLRequest alloc] initWithURL:url]];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
