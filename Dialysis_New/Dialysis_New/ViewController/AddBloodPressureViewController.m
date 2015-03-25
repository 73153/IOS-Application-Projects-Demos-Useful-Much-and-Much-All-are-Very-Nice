//
//  AddBloodPressureViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "AddBloodPressureViewController.h"
#import "AppConstant.h"

@implementation AddBloodPressureViewController

@synthesize txtfieldSystolic;
@synthesize txtfieldDiastolic;

@synthesize btnBack;
@synthesize btnSave;

@synthesize scrollView;
@synthesize selectedDate;

@synthesize oldDictionary;

@synthesize lblDate;
@synthesize btnChangeDate;
@synthesize datePicker;

@synthesize pickerBackGroundView;
@synthesize btnBarCancel;
@synthesize btnBarDone;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSString *) getDateStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    return [dateFormatter stringFromDate:date];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [datePicker setMaximumDate:[NSDate date]];
    [txtfieldSystolic setReturnKeyType:UIReturnKeyNext];
    [txtfieldDiastolic setReturnKeyType:UIReturnKeyDone];
     if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
         [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,465)];
     }
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    selectedDate = [NSDate date];
    if(oldDictionary){
        txtfieldSystolic.text = [oldDictionary objectForKey:kSystolic];
        txtfieldDiastolic.text = [oldDictionary objectForKey:kdiastolic];
        lblDate.text = [self getDateStringFromDate:[oldDictionary objectForKey:kDate]];
        selectedDate = [oldDictionary objectForKey:kDate];
    }
    else{
        txtfieldSystolic.text = @"";
        txtfieldDiastolic.text = @"";
        lblDate.text = [self getDateStringFromDate:selectedDate];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnSaveClicked:(id)sender{
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
    [dataDictionary setObject:txtfieldSystolic.text forKey:kSystolic];
    [dataDictionary setObject:txtfieldDiastolic.text forKey:kdiastolic];
    [dataDictionary setObject:selectedDate forKey:kDate];
    if(oldDictionary){
        [[DataManager sharedDataManager] updateBloodPressureData:dataDictionary forRowId:[[oldDictionary objectForKey:kRowId] intValue]];
    }
    else{
        [[DataManager sharedDataManager] insertBloodPressureData:dataDictionary];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == txtfieldSystolic){
        [txtfieldSystolic resignFirstResponder];
        [txtfieldDiastolic becomeFirstResponder];
    }
    else if(textField == txtfieldDiastolic){
        [txtfieldDiastolic resignFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (IBAction)cancelButtonClicked:(id)sender{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [pickerBackGroundView setFrame:CGRectMake(pickerBackGroundView.frame.origin.x,800, pickerBackGroundView.frame.size.width,pickerBackGroundView.frame.size.height)];
    }
    else{
        [pickerBackGroundView setFrame:CGRectMake(pickerBackGroundView.frame.origin.x,1200, pickerBackGroundView.frame.size.width,pickerBackGroundView.frame.size.height)];
    }
    [UIView commitAnimations];
}
- (IBAction)doneButtonClicked:(id)sender{
    selectedDate = [datePicker date];
    lblDate.text = [self getDateStringFromDate:selectedDate];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [pickerBackGroundView setFrame:CGRectMake(pickerBackGroundView.frame.origin.x,800, pickerBackGroundView.frame.size.width,pickerBackGroundView.frame.size.height)];
    }
    else{
        [pickerBackGroundView setFrame:CGRectMake(pickerBackGroundView.frame.origin.x,1200, pickerBackGroundView.frame.size.width,pickerBackGroundView.frame.size.height)];
    }
    [UIView commitAnimations];
}

- (IBAction)changeDateButtonClicked:(id)sender{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [pickerBackGroundView setFrame:CGRectMake(pickerBackGroundView.frame.origin.x,self.view.frame.size.height-(pickerBackGroundView.frame.size.height+49), pickerBackGroundView.frame.size.width,pickerBackGroundView.frame.size.height)];
    [UIView commitAnimations];
}


@end
