//
//  ImageViewController.m
//  Holaout
//
//  Created by Amit Parmar on 09/01/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import "ImageViewController.h"

@implementation ImageViewController
@synthesize image;
@synthesize imgView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    imgView.image = image;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)btnBackClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
