//
//  CompleteRegistrationViewController.m
//  CustomerLoyalty
//
//  Created by Amit Parmar on 13/02/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import "CompleteRegistrationViewController.h"

@implementation CompleteRegistrationViewController

@synthesize scrollView;
@synthesize txtView;
@synthesize txtFieldCountry;
@synthesize txtFieldState;
@synthesize txtFieldCity;
@synthesize txtFieldZipCode;

@synthesize isCountryPicker;
@synthesize isStatePicker;
@synthesize isCityPicker;

@synthesize selectedCity;
@synthesize selectedCountry;
@synthesize selectedState;

@synthesize countryArray;
@synthesize stateArray;
@synthesize cityArray;

@synthesize pickerBackground;
@synthesize pickerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [txtView setReturnKeyType:UIReturnKeyDone];
    [txtFieldCountry setReturnKeyType:UIReturnKeyNext];
    [txtFieldState setReturnKeyType:UIReturnKeyNext];
    [txtFieldCity setReturnKeyType:UIReturnKeyNext];
    [txtFieldZipCode setReturnKeyType:UIReturnKeyDone];
    
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,504)];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitButonClicked:(id)sender{
    if([txtView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please enter address" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txtFieldCountry.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please select country" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txtFieldState.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please select state" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txtFieldCity.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please select city" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txtFieldZipCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please enter zip code" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Registration completed Successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == txtFieldCountry){
        isCountryPicker = YES;
        isStatePicker = NO;
        isCityPicker = NO;
        return NO;
    }
    else if(textField == txtFieldState){
        isCountryPicker = NO;
        isStatePicker = YES;
        isCityPicker = NO;
        return NO;
    }
    else if(textField == txtFieldCity){
        isCountryPicker = NO;
        isStatePicker = NO;
        isCityPicker = YES;
        return NO;
    }
    else if(textField == txtFieldZipCode){
        [scrollView setContentOffset:CGPointMake(scrollView.frame.origin.x, txtFieldZipCode.frame.origin.x+txtFieldZipCode.frame.size.height) animated:YES];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(scrollView.frame.origin.x,0) animated:YES];
    return YES;
}
- (IBAction)doneButtonClicked:(id)sender{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [pickerBackground setFrame:CGRectMake(pickerBackground.frame.origin.x,800, pickerBackground.frame.size.width,pickerBackground.frame.size.height)];
    }
    else{
        [pickerBackground setFrame:CGRectMake(pickerBackground.frame.origin.x,1200, pickerBackground.frame.size.width,pickerBackground.frame.size.height)];
    }
    [UIView commitAnimations];
}
- (IBAction)cancelButtonClicked:(id)sender{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [pickerBackground setFrame:CGRectMake(pickerBackground.frame.origin.x,800, pickerBackground.frame.size.width,pickerBackground.frame.size.height)];
    }
    else{
        [pickerBackground setFrame:CGRectMake(pickerBackground.frame.origin.x,1200, pickerBackground.frame.size.width,pickerBackground.frame.size.height)];
    }
    [UIView commitAnimations];
}
@end
