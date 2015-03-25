//
//  DetailViewController.m
//  H2Oteam_Universal
//
//  Created by Luka Penger on 4/21/13.
//  Copyright (c) 2013 LukaPenger. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"Detail View";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    listButton = [[UIBarButtonItem alloc] initWithTitle:@"List" style:UIBarButtonItemStyleBordered target:self action:@selector(listBarButtonClicked:)];
}

- (void)listBarButtonClicked:(id)sender
{
    LPThreeSplitViewController *threeSplitViewController = (LPThreeSplitViewController*)self.parentViewController.parentViewController;
    [threeSplitViewController showListViewController:self withAnimation:YES];
}

- (void)viewDidLayoutSubviews
{
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        self.navigationItem.leftBarButtonItem = listButton;
    } else {
        self.navigationItem.leftBarButtonItem=nil;
    }

    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
