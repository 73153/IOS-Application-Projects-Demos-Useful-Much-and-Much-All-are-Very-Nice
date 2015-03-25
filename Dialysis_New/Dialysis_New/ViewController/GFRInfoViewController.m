//
//  GFRInfoViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 28/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "GFRInfoViewController.h"

@interface GFRInfoViewController ()

@end

@implementation GFRInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
