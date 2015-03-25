//
//  RegistrationViewController.h
//  CustomerLoyalty
//
//  Created by Amit Parmar on 13/02/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *txtFieldFirstName;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldLastName;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldDateOfBirth;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldEmailId;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldContactNumber;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldPassword;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldConfirmPassword;

@property (nonatomic, strong) IBOutlet UIButton *btnMale;
@property (nonatomic, strong) IBOutlet UIButton *btnFemale;
@property (nonatomic, strong) IBOutlet UIButton *btnSubmit;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) IBOutlet UIView *pickerBackground;
@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;

- (IBAction)toggleRadioButton:(id)sender;
- (IBAction)submitButtonClicked:(id)sender;
- (IBAction)backButtonClicked:(id)sender;
- (IBAction)cancelButtonClicked:(id)sender;
- (IBAction)doneButtonClicked:(id)sender;

@end
