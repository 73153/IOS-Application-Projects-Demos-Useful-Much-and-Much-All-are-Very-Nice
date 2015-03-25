//
//  ViewController.m
//  PPiFlatSegmentedControl-Demo
//
//  Created by Pedro Piñera Buendía on 12/08/13.
//  Copyright (c) 2013 PPinera. All rights reserved.
//

#import "ViewController.h"
#import "PPiFlatSegmentedControl.h"
#import "NSString+FontAwesome.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    PPiFlatSegmentedControl *segmented=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20, 20, 250, 30) items:@[               @{@"text":@"Face",@"icon":@"icon-facebook"},
                                        @{@"text":@"Linkedin",@"icon":@"icon-linkedin"},
                                        @{@"text":@"Twitter",@"icon":@"icon-twitter"}
                                        ]
                                        iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex) {
                                            
                                        }];
    segmented.color=[UIColor colorWithRed:88.0f/255.0 green:88.0f/255.0 blue:88.0f/255.0 alpha:1];
    segmented.borderWidth=0.5;
    segmented.borderColor=[UIColor darkGrayColor];
    segmented.selectedColor=[UIColor colorWithRed:0.0f/255.0 green:141.0f/255.0 blue:147.0f/255.0 alpha:1];
    segmented.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    segmented.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmented];
    
    
    PPiFlatSegmentedControl *segmented2=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20, 80, 250, 30) items:@[               @{@"text":@"Face",@"icon":@"icon-facebook"},
                                         @{@"text":@"Linkedin",@"icon":@"icon-linkedin"},
                                         @{@"text":@"Twitter",@"icon":@"icon-twitter"}
                                         ]
                                                                          iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex) {
                                                                              
                                                                          }];
    segmented2.color=[UIColor whiteColor];
    segmented2.borderWidth=0.5;
    segmented2.borderColor=[UIColor colorWithRed:244.0f/255.0 green:67.0f/255.0 blue:60.0f/255.0 alpha:1];
    segmented2.selectedColor=[UIColor colorWithRed:244.0f/255.0 green:67.0f/255.0 blue:60.0f/255.0 alpha:1];
    segmented2.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:[UIColor colorWithRed:244.0f/255.0 green:67.0f/255.0 blue:60.0f/255.0 alpha:1]};
    segmented2.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                       NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmented2];
    
    PPiFlatSegmentedControl *segmented3=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20, 140, 150, 30) items:@[               @{@"text":@"Face",@"icon":@"icon-facebook"},
                                         @{@"text":@"Linkedin",@"icon":@"icon-linkedin"}
                                         ]
                                                                          iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex) {
                                                                              
                                                                          }];
    segmented3.color=[UIColor colorWithRed:88.0f/255.0 green:88.0f/255.0 blue:88.0f/255.0 alpha:1];
    segmented3.borderWidth=0.5;
    segmented3.borderColor=[UIColor darkGrayColor];
    segmented3.selectedColor=[UIColor colorWithRed:0.0f/255.0 green:141.0f/255.0 blue:176.0f/255.0 alpha:1];
    segmented3.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    segmented3.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                       NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmented3];
    
    PPiFlatSegmentedControl *segmented4=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20, 200, 200, 30) items:@[               @{@"text":@"",@"icon":@"icon-facebook"},
                                         @{@"text":@"",@"icon":@"icon-linkedin"}
                                         ]
                                                                          iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex) {
                                                                              
                                                                          }];
    segmented4.color=[UIColor colorWithRed:88.0f/255.0 green:88.0f/255.0 blue:88.0f/255.0 alpha:1];
    segmented4.borderWidth=0.5;
    segmented4.borderColor=[UIColor darkGrayColor];
    segmented4.selectedColor=[UIColor colorWithRed:0.0f/255.0 green:141.0f/255.0 blue:176.0f/255.0 alpha:1];
    segmented4.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:17],
                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    segmented4.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                       NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmented4];
    
    PPiFlatSegmentedControl *segmented5=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20, 260, 250, 30) items:@[               @{@"text":@"Face",@"icon":@"icon-facebook"},
                                         @{@"text":@"Linkedin",@"icon":@"icon-linkedin"},
                                         @{@"text":@"Twitter",@"icon":@"icon-twitter"}
                                         ]
                                                                          iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex) {
                                                                              
                                                                          }];
    segmented5.color=[UIColor colorWithRed:88.0f/255.0 green:88.0f/255.0 blue:88.0f/255.0 alpha:1];
    segmented5.borderWidth=0.5;
    segmented5.borderColor=[UIColor darkGrayColor];
    segmented5.selectedColor=[UIColor colorWithRed:0.0f/255.0 green:141.0f/255.0 blue:176.0f/255.0 alpha:1];
    segmented5.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    segmented5.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                       NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmented5];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
