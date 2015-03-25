//
//  CompleteRegistrationViewController.h
//  CustomerLoyalty
//
//  Created by Amit Parmar on 13/02/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompleteRegistrationViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UITextView *txtView;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldCountry;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldState;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldCity;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldZipCode;

@property (nonatomic, strong) IBOutlet UIView *pickerBackground;
@property (nonatomic, strong) IBOutlet UIPickerView *pickerView;

@property (nonatomic) BOOL isCountryPicker;
@property (nonatomic) BOOL isStatePicker;
@property (nonatomic) BOOL isCityPicker;

@property (nonatomic, strong) NSDictionary *selectedCountry;
@property (nonatomic, strong) NSDictionary *selectedState;
@property (nonatomic, strong) NSDictionary *selectedCity;

@property (nonatomic, strong) NSArray *countryArray;
@property (nonatomic, strong) NSArray *stateArray;
@property (nonatomic, strong) NSArray *cityArray;


- (IBAction)backButtonClicked:(id)sender;
- (IBAction)submitButonClicked:(id)sender;
- (IBAction)doneButtonClicked:(id)sender;
- (IBAction)cancelButtonClicked:(id)sender;

@end
