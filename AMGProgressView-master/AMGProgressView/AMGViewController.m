//
//  AMGViewController.m
//  AMGProgressView
//
//  Created by Albert Mata on 15/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMGViewController.h"

@interface AMGViewController()
@property (nonatomic, strong) AMGProgressView *pv1;
@property (nonatomic, strong) AMGProgressView *pv2;
@property (nonatomic, strong) AMGProgressView *pv3;
@property (nonatomic, strong) AMGProgressView *pv4;
@property (nonatomic, strong) AMGProgressView *pv5;
@property (nonatomic, strong) AMGProgressView *pv6;
@end

@implementation AMGViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f];
    
    
    self.pv1 = [[AMGProgressView alloc] initWithFrame:CGRectMake(20, 20, 205, 55)];
    self.pv1.outsideBorder = [UIColor blackColor];
    self.pv1.emptyPartAlpha = 0.5f;
    [self.view addSubview:self.pv1];

    
    self.pv2 = [[AMGProgressView alloc] initWithFrame:CGRectMake(20, 95, 205, 55)];
    self.pv2.gradientColors = @[[UIColor orangeColor]];
    self.pv2.outsideBorder = [UIColor orangeColor];
    [self.view addSubview:self.pv2];
    
    
    self.pv3 = [[AMGProgressView alloc] initWithFrame:CGRectMake(20, 170, 205, 55)];
    self.pv3.gradientColors = @[[UIColor redColor], [UIColor yellowColor]];
    [self.view addSubview:self.pv3];
    
    
    self.pv4 = [[AMGProgressView alloc] initWithFrame:CGRectMake(20, 245, 205, 55)];
    self.pv4.gradientColors = @[[UIColor colorWithRed:0.1f green:0.7f blue:0.1f alpha:1.0f],
                           [UIColor colorWithRed:0.6f green:0.9f blue:0.6f alpha:1.0f]];
    [self.view addSubview:self.pv4];

    
    self.pv5 = [[AMGProgressView alloc] initWithFrame:CGRectMake(20, 320, 205, 55)];
    self.pv5.gradientColors = @[[UIColor colorWithRed:0.7f green:0.1f blue:0.1f alpha:1.0f],
                           [UIColor colorWithRed:0.9f green:0.6f blue:0.6f alpha:1.0f]];
    [self.view addSubview:self.pv5];
    
    
    self.pv6 = [[AMGProgressView alloc] initWithFrame:CGRectMake(245, 20, 55, 355)];
    self.pv6.gradientColors = @[[UIColor colorWithRed:0.0f green:0.0f blue:0.3f alpha:1.00f],
                           [UIColor colorWithRed:0.3f green:0.3f blue:0.6f alpha:1.00f],
                           [UIColor colorWithRed:0.6f green:0.6f blue:0.9f alpha:1.00f]];
    self.pv6.verticalGradient = YES;
    [self.view addSubview:self.pv6];
    
    
    UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectMake(113, 400, 94, 27)];
    stepper.minimumValue = 0.0f;
    stepper.maximumValue = 1.0f;
    stepper.value = 0.0f;
    stepper.stepValue = 0.1f;
    [stepper addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:stepper];
}

- (void)changeValue:(UIStepper *)sender {
    self.pv1.progress = sender.value;
    self.pv2.progress = sender.value;
    self.pv3.progress = sender.value;
    self.pv4.progress = sender.value;
    self.pv5.progress = sender.value;
    self.pv6.progress = sender.value;
}

@end