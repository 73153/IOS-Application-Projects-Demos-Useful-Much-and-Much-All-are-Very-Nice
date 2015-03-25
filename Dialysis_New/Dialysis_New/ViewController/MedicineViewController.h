//
//  MedicineViewController.h
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicineViewController : UIViewController
@property (nonatomic, strong) IBOutlet UIButton *btnBack;
@property (nonatomic, strong) IBOutlet UIButton *btnAdd;
@property (nonatomic, strong) IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSArray *medicineReadingArray;
@property (nonatomic) BOOL isFromPush;

- (IBAction)backButtonClicked:(id)sender;
- (IBAction)addButtonClicked:(id)sender;

@end
