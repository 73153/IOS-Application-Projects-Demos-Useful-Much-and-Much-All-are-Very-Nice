//
//  ViewController.m
//  MIS-Linkedin-Share-Demo
//
//  Created by Pedro Milanez on 27/09/12.
//  Copyright (c) 2012 Pedro Milanez. All rights reserved.
//

#import "ViewController.h"
#import "MISLinkedinShare.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)share:(id)sender {
	
	[[MISLinkedinShare sharedInstance] shareContent:self postTitle:@"Title" postDescription:@"Description" postURL:@"www.google.com" postImageURL:@"http://www.google.com/images/errors/logo_sm.gif"];
}
@end
