//
//  DSViewController.m
//  DSBarChart
//
//  Created by DhilipSiva Bijju on 31/10/12.
//  Copyright (c) 2012 Tataatsu IdeaLabs. All rights reserved.
//

#import "DSViewController.h"
#import "DSBarChart.h"

@interface DSViewController ()

@end

@implementation DSViewController
@synthesize ChartView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSInteger maxValue = 0;
    {
        NSArray *vals = [NSArray arrayWithObjects:
                         [NSNumber numberWithInt:30],
                         [NSNumber numberWithInt:40],
                         [NSNumber numberWithInt:20],
                         [NSNumber numberWithInt:56],
                         [NSNumber numberWithInt:90],
                         [NSNumber numberWithInt:34],
                         [NSNumber numberWithInt:43],
                         [NSNumber numberWithInt:14],
                         [NSNumber numberWithInt:16],
                         [NSNumber numberWithInt:24],
                         [NSNumber numberWithInt:12],
                         [NSNumber numberWithInt:52],
                         [NSNumber numberWithInt:63],
                         [NSNumber numberWithInt:32],
                         [NSNumber numberWithInt:57],
                         nil];
        NSArray *refs = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", nil];
        DSBarChart *chrt = [[DSBarChart alloc] initWithFrame:ChartView.bounds
                                                       color:[UIColor greenColor]
                                                  references:refs
                                                   andValues:vals];
        chrt.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        chrt.opaque = YES;
        [chrt addInterestPointWithText:@"Mean" inColumn:4 percentageInColumn:0.9f];
        [ChartView addSubview:chrt];
        maxValue = chrt.maxLen;
    }
    
    {
        NSMutableArray * scatterSample = [NSMutableArray arrayWithArray:@[@1, @23, @13, @44, @54, @46, @7, @8, @9, @10, @11, @12, @13, @14, @545]];
        
        for (int ii = 0; ii < 50; ++ii) {
            [scatterSample addObject:[NSNumber numberWithInteger:arc4random_uniform(500)]];
        }
        
        NSInteger maxValue = [DSBarChart maxValue:scatterSample];
        NSArray *vals = [DSBarChart histogramData:scatterSample intoBuckets:maxValue / 20];

        DSBarChart *chrt = [[DSBarChart alloc] initWithFrame:ChartView.bounds
                                                       color:[UIColor orangeColor]
                                                  references:nil
                                                   andValues:vals];
        chrt.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        chrt.opaque = NO;
        chrt.showNumberValues = NO;
//        chrt.shouldCalculateMaxValue = NO;
//        chrt.maxLen = 90;
        
        [chrt addInterestPointWithText:@"Just Scored" inColumn:2 percentageInColumn:0.19f];
        
        [ChartView addSubview:chrt];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
