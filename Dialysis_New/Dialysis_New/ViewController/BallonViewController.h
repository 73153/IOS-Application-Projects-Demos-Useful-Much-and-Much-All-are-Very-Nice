//
//  BallonViewController.h
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BallonViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *btnBack;
@property (nonatomic, strong) IBOutlet UIButton *btnAdd;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, strong) IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSArray *ballonAngioplastyArray;

- (IBAction)backButtonClicked:(id)sender;
- (IBAction)addButtonClicked:(id)sender;
- (IBAction)segmentedControlValueChanged:(id)sender;


@end
