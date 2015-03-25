//
//  AddLabViewController.h
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddLabViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *txtFieldHB;
@property (nonatomic, strong) IBOutlet UITextField *txtfieldBUN;
@property (nonatomic, strong) IBOutlet UITextField *txtfieldCR;
@property (nonatomic, strong) IBOutlet UITextField *txtfieldAlbumin;
@property (nonatomic, strong) IBOutlet UITextField *txtfieldPhosph;
@property (nonatomic, strong) IBOutlet UITextField *txtfieldPTH;
@property (nonatomic, strong) IBOutlet UITextField *txtfieldKT;
@property (nonatomic, strong) IBOutlet UITextField *txtfieldINR;

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
