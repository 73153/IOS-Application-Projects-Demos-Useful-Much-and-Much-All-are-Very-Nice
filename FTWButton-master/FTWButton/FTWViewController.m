//
//  FTWViewController.m
//  FTWButton
//
//  Created by Soroush Khanlou on 10/12/12.
//  Copyright (c) 2012 FTW. All rights reserved.
//

#import "FTWViewController.h"
#import "FTWButton.h"

@interface FTWViewController ()

@property (nonatomic, strong) FTWButton *button1;
@property (nonatomic, strong) FTWButton *button6;

@end

@implementation FTWViewController

@synthesize button1, button6;

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.view.backgroundColor = [UIColor whiteColor];
	button1 = [[FTWButton alloc] init];
	
	button1.frame = CGRectMake(20, 20, 280, 40);
	[button1 addBlueStyleForState:UIControlStateNormal];
	[button1 addYellowStyleForState:UIControlStateSelected];
	
	[button1 setText:@"Tap me" forControlState:UIControlStateNormal];
	[button1 setText:@"Tapped!" forControlState:UIControlStateSelected];
	
	[button1 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button1];
	
	
	
	
	FTWButton *button2 = [[FTWButton alloc] init];
	
	button2.frame = CGRectMake(20, 80, 280, 40);
	[button2 addDeleteStyleForState:UIControlStateNormal];
	
	[button2 setText:@"Do weird things to the border!" forControlState:UIControlStateNormal];
	
	[button2 setCornerRadius:4.0f forControlState:UIControlStateNormal];
	[button2 setCornerRadius:14.0f forControlState:UIControlStateHighlighted];
	[button2 setBorderColor:[UIColor blackColor] forControlState:UIControlStateNormal];
	[button2 setBorderWidth:1.0f forControlState:UIControlStateNormal];
	[button2 setBorderWidth:4.0f forControlState:UIControlStateHighlighted];
	
	[button2 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button2];
	
	
	
	
	
	FTWButton *button3 = [[FTWButton alloc] init];
	button3.frame = CGRectMake(20, 140, 280, 40);
	[button3 addDisabledStyleForState:UIControlStateDisabled];
	button3.enabled = NO;
	[button3 setText:@"Disabled button style" forControlState:UIControlStateNormal];
	[button3 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button3];
	
	
	
	
	
	FTWButton *button4 = [[FTWButton alloc] init];
	
	button4.frame = CGRectMake(20, 200, 280, 40);
	[button4 addGrayStyleForState:UIControlStateNormal];
	
	[button4 setBorderColors:[NSArray arrayWithObjects:
						 [UIColor colorWithWhite:0.6f alpha:1.0f],
						 [UIColor colorWithWhite:0.1f alpha:1.0f],
						 nil] forControlState:UIControlStateNormal];
	[button4 setBorderColors:[NSArray arrayWithObjects:
						 [UIColor colorWithWhite:0.2f alpha:1.0f],
						 [UIColor colorWithWhite:0.0f alpha:1.0f],
						 nil] forControlState:UIControlStateHighlighted];
	[button4 setBorderWidth:2.0f forControlState:UIControlStateNormal];
	[button4 setCornerRadius:4.0f forControlState:UIControlStateNormal];
	
	[button4 setText:@"Gradient borders!" forControlState:UIControlStateNormal];
	
	
	[button4 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button4];
	
	
	
	
	FTWButton *button5 = [[FTWButton alloc] init];
	
	button5.frame = CGRectMake(20, 260, 280, 40);
	[button5 addBlueStyleForState:UIControlStateNormal];
	[button5 setText:@"Blurred inner shadows" forControlState:UIControlStateNormal];
	
	
	[button5 setColors:[NSArray arrayWithObjects:
					[UIColor colorWithWhite:98.0f/255 alpha:1.0f],
					[UIColor colorWithWhite:108.0f/255 alpha:1.0f],
					nil] forControlState:UIControlStateHighlighted];
	
	[button5 setInnerShadowColor:[UIColor blackColor] forControlState:UIControlStateHighlighted];
	[button5 setInnerShadowRadius:4.0f forControlState:UIControlStateHighlighted];
	[button5 setInnerShadowOffset:CGSizeMake(0, 2) forControlState:UIControlStateHighlighted];
	
	[button5 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button5];
	
	
	
	
	
	button6 = [[FTWButton alloc] init];
	button6.frame = CGRectMake(40, 320, 240, 40);
	[button6 setFrame:CGRectMake(67, 320, 185, 40) forControlState:UIControlStateSelected];
	[button6 addBlueStyleForState:UIControlStateNormal];
	[button6 setInnerShadowColor:[UIColor colorWithRed:200.0f/255 green:250.0f/255 blue:253.0f/255 alpha:1.0f] forControlState:UIControlStateNormal];
	[button6 setInnerShadowRadius:2.0f forControlState:UIControlStateNormal];
	[button6 setText:@"Here is some normal text" forControlState:UIControlStateNormal];
	[button6 setText:@"Selected state text" forControlState:UIControlStateSelected];
	[button6 setIcon:[UIImage imageNamed:@"planet"] forControlState:UIControlStateNormal];
	[button6 setIcon:[UIImage imageNamed:@"weather"] forControlState:UIControlStateSelected];
	
	button6.textAlignment = NSTextAlignmentLeft;
	[button6 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button6];

    FTWButton *button7 = [FTWButton new];
    button7.frame = CGRectMake(40, 365, 240, 30);
    [button7 addBlueStyleForState:UIControlStateNormal];
    [button7 setText:@"Left Edge" forControlState:UIControlStateNormal];
    [button7 setIcon:[UIImage imageNamed:@"planet"] forControlState:UIControlStateNormal];
    [self.view addSubview:button7];

    FTWButton *button8 = [FTWButton new];
    button8.frame = CGRectMake(40, 400, 240, 30);
    [button8 addBlueStyleForState:UIControlStateNormal];
    [button8 setIconAlignment:FTWButtonIconAlignmentRight];
    [button8 setIconPlacement:FTWButtonIconPlacementEdge];
    [button8 setText:@"Right Edge" forControlState:UIControlStateNormal];
    [button8 setIcon:[UIImage imageNamed:@"planet"] forControlState:UIControlStateNormal];
    [self.view addSubview:button8];

    FTWButton *button9 = [FTWButton new];
    button9.frame = CGRectMake(40, 435, 240, 30);
    [button9 addBlueStyleForState:UIControlStateNormal];
    [button9 setIconAlignment:FTWButtonIconAlignmentLeft];
    [button9 setIconPlacement:FTWButtonIconPlacementTight];
    [button9 setText:@"Left Tight" forControlState:UIControlStateNormal];
    [button9 setIcon:[UIImage imageNamed:@"planet"] forControlState:UIControlStateNormal];
    button9.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:button9];

    FTWButton *button10 = [FTWButton new];
    button10.frame = CGRectMake(40, 470, 240, 30);
    [button10 addBlueStyleForState:UIControlStateNormal];
    [button10 setIconAlignment:FTWButtonIconAlignmentRight];
    [button10 setIconPlacement:FTWButtonIconPlacementTight];
    [button10 setText:@"Right Tight" forControlState:UIControlStateNormal];
    [button10 setIcon:[UIImage imageNamed:@"planet"] forControlState:UIControlStateNormal];
    [self.view addSubview:button10];

    // No text on this one.
    FTWButton *button11 = [FTWButton new];
    button11.frame = CGRectMake(40, 505, 240, 30);
    [button11 addBlueStyleForState:UIControlStateNormal];
    [button11 setIconPlacement:FTWButtonIconPlacementTight];
    [button11 setIcon:[UIImage imageNamed:@"planet"] forControlState:UIControlStateNormal];
    [self.view addSubview:button11];
}

- (IBAction) buttonTapped:(id)sender {
	if (sender == button1) {
		button1.selected = !button1.selected;
	}
	if (sender == button6) {
		button6.selected = !button6.selected;
	}
}

@end
