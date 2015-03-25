//
//  PointsViewController.h
//  CustomerLoyalty
//
//  Created by Amit Parmar on 13/02/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointsViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSArray *pointsArray;

- (IBAction)backButtonClicked:(id)sender;
@end
