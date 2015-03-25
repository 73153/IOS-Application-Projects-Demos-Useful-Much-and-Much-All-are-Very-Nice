//
//  GFRCalculatorViewController.h
//  Dialysis_New
//
//  Created by Amit Parmar on 07/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFRCalculatorViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *creatinineTextField;
@property (nonatomic, strong) IBOutlet UITextField *ageTextField;

@property (nonatomic, strong) IBOutlet UIButton *maleButton;
@property (nonatomic, strong) IBOutlet UIButton *femaleButton;

@property (nonatomic, strong) IBOutlet UIButton *africanButton;
@property (nonatomic, strong) IBOutlet UIButton *allOtherButton;

@property (nonatomic) BOOL isMale;
@property (nonatomic) BOOL isAfrican;

@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) IBOutlet UIView *pickerBackGroundView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *btnBarCancel;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *btnBarDone;
@property (nonatomic, strong) IBOutlet UILabel  *lblDate;
@property (nonatomic, strong) IBOutlet UIButton *btnChangeDate;
@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;

- (IBAction)cancelButtonClicked:(id)sender;
- (IBAction)doneButtonClicked:(id)sender;
- (IBAction)changeDateButtonClicked:(id)sender;


- (IBAction)sexSelection:(id)sender;
- (IBAction)raceSelection:(id)sender;

- (IBAction)backButtonClicked:(id)sender;
- (IBAction)submitButtonClicked:(id)sender;
@end
