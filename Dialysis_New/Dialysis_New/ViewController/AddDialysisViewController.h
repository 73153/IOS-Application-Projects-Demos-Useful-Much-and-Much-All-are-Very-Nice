//
//  AddDialysisViewController.h
//  Dialysis_New
//
//  Created by Amit Parmar on 28/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddDialysisViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *txtfield1;
@property (nonatomic, strong) IBOutlet UITextField *txtfield2;
@property (nonatomic, strong) IBOutlet UITextField *txtfield3;
@property (nonatomic, strong) IBOutlet UITextField *txtfield4;
@property (nonatomic, strong) IBOutlet UITextField *txtfield5;
@property (nonatomic, strong) IBOutlet UITextField *txtfield6;
@property (nonatomic, strong) IBOutlet UITextField *txtfield7;
@property (nonatomic, strong) IBOutlet UITextField *txtfield8;
@property (nonatomic, strong) IBOutlet UITextField *txtfield9;
@property (nonatomic, strong) IBOutlet UITextField *txtfield10;
@property (nonatomic, strong) IBOutlet UITextField *txtfield11;
@property (nonatomic, strong) IBOutlet UITextField *txtfield12;
@property (nonatomic, strong) IBOutlet UITextField *txtfield13;
@property (nonatomic, strong) IBOutlet UITextField *txtfield14;
@property (nonatomic, strong) IBOutlet UITextField *txtfield15;
@property (nonatomic, strong) IBOutlet UITextField *txtfield16;

@property (nonatomic, strong) IBOutlet UIButton *btnBack;
@property (nonatomic, strong) IBOutlet UIButton *btnSave;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) NSDictionary *oldDictionary;

@property (nonatomic, strong) IBOutlet UIView *pickerBackGroundView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *btnBarCancel;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *btnBarDone;
@property (nonatomic, strong) IBOutlet UILabel  *lblDate;
@property (nonatomic, strong) IBOutlet UIButton *btnChangeDate;
@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;

- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnSaveClicked:(id)sender;

- (IBAction)cancelButtonClicked:(id)sender;
- (IBAction)doneButtonClicked:(id)sender;
- (IBAction)changeDateButtonClicked:(id)sender;

@end
