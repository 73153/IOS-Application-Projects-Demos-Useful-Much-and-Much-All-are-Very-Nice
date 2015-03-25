//
//  GraphViewController.h
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSLineChartView.h"

@interface GraphViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic) BOOL isFromPush;
@property (nonatomic, strong) IBOutlet UIButton *btnBack;
@property (nonatomic, strong) IBOutlet UISegmentedControl *timeSegment;
@property (nonatomic, strong) IBOutlet UISegmentedControl *graphSegment;
@property (nonatomic, strong) IBOutlet UISegmentedControl *nonDialysisGraphSegment;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIWebView *webView;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *finalGraphArray;
@property (nonatomic, strong) NSDictionary *alert1Dictionary;
@property (nonatomic, strong) NSDictionary *alert2Dictionary;
@property (nonatomic, strong) WSLineChartView *lineChart;

@property (nonatomic, strong) NSArray *array1;
@property (nonatomic, strong) NSArray *array2;
@property (nonatomic, strong) NSArray *array3;
@property (nonatomic, strong) NSArray *array4;

@property (nonatomic, strong) NSArray *arrayDates;
@property (nonatomic, strong) NSArray *arrayGFR;
@property (nonatomic, strong) NSArray *arrayYValues;

@property (nonatomic) BOOL isGFRGraph;
@property (nonatomic) BOOL isBPGraph;

- (IBAction)timeSegmentValueChanged:(id)sender;
- (IBAction)graphSegmentValueChanged:(id)sender;
- (IBAction)backButtonClicked:(id)sender;
- (IBAction)nonDialysisGraphSegmentValueChanged:(id)sender;

@end
