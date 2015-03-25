//
//  FirstViewController.h
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoCell.h"

@interface FirstViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITableView *tableview;
@property (nonatomic, strong) InfoCell *Cell;
@property (nonatomic, strong) NSMutableArray *ArrayData;
@property (nonatomic, strong) IBOutlet UIButton *btnSwitchToDialysis;

- (IBAction)dialysisNonDialysisButtonClicked:(id)sender;

@end
