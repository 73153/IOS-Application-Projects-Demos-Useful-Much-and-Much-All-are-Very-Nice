//
//  ViewController.m
//  FPNumberPadViewDemo
//
//  Created by Fabrizio Prosperi on 7/11/12.
//  Copyright (c) 2012 Absolutely iOS. All rights reserved.
//

#import "ViewController.h"

#import "FPNumberPadView.h"

@interface ViewController () {
    IBOutlet UITextField *textField;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"FPNumberPadView";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    
    
    FPNumberPadView *numberPadView = [[FPNumberPadView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    numberPadView.textField = textField;
}

- (void)done:(id)sender {
    [textField resignFirstResponder];
}

@end
