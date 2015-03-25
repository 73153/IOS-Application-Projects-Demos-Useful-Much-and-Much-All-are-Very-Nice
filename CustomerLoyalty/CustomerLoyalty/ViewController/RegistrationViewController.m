//
//  RegistrationViewController.m
//  CustomerLoyalty
//
//  Created by Amit Parmar on 13/02/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import "RegistrationViewController.h"
#import "LoginViewController.h"


@implementation RegistrationViewController
@synthesize txtFieldFirstName;
@synthesize txtFieldLastName;
@synthesize txtFieldDateOfBirth;
@synthesize txtFieldEmailId;
@synthesize txtFieldContactNumber;
@synthesize txtFieldPassword;
@synthesize txtFieldConfirmPassword;

@synthesize btnMale;
@synthesize btnFemale;
@synthesize btnSubmit;
@synthesize scrollView;

@synthesize pickerBackground;
@synthesize datePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [txtFieldFirstName setReturnKeyType:UIReturnKeyNext];
    [txtFieldLastName setReturnKeyType:UIReturnKeyNext];
    [txtFieldDateOfBirth setReturnKeyType:UIReturnKeyNext];
    [txtFieldEmailId setReturnKeyType:UIReturnKeyNext];
    [txtFieldContactNumber setReturnKeyType:UIReturnKeyNext];
    [txtFieldPassword setReturnKeyType:UIReturnKeyNext];
    [txtFieldConfirmPassword setReturnKeyType:UIReturnKeyDone];
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,504)];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
- (IBAction)toggleRadioButton:(id)sender{
    if([sender tag] == 101){
        [btnMale setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [btnFemale setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    else{
        [btnMale setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [btnFemale setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    
}
- (IBAction)submitButtonClicked:(id)sender{
    if([txtFieldFirstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please enter first name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txtFieldLastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please enter last name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txtFieldDateOfBirth.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please select date of birth" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txtFieldEmailId.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please enter email id" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txtFieldContactNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please enter contact number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txtFieldPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please enter password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txtFieldConfirmPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please enter confirm password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(![txtFieldPassword.text isEqualToString:txtFieldConfirmPassword.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Password should match with confirm password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)backButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == txtFieldDateOfBirth){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [pickerBackground setFrame:CGRectMake(pickerBackground.frame.origin.x,self.view.frame.size.height-(pickerBackground.frame.size.height), pickerBackground.frame.size.width,pickerBackground.frame.size.height)];
        [UIView commitAnimations];
        
        return NO;
    }
    else if(textField == txtFieldPassword){
        [scrollView setContentOffset:CGPointMake(scrollView.frame.origin.x,txtFieldPassword.frame.origin.y) animated:YES];
    }
    else if(textField == txtFieldConfirmPassword){
        [scrollView setContentOffset:CGPointMake(scrollView.frame.origin.x,txtFieldConfirmPassword.frame.origin.y) animated:YES];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(txtFieldFirstName == textField){
        [txtFieldFirstName resignFirstResponder];
        [txtFieldLastName becomeFirstResponder];
    }
    else if(txtFieldLastName == textField){
        [txtFieldLastName resignFirstResponder];
        [txtFieldEmailId becomeFirstResponder];
    }
    else if(txtFieldEmailId == textField){
        [txtFieldEmailId resignFirstResponder];
        [txtFieldContactNumber becomeFirstResponder];
    }
    else if(txtFieldContactNumber == textField){
        [txtFieldContactNumber resignFirstResponder];
        [txtFieldPassword becomeFirstResponder];
    }
    else if(txtFieldPassword == textField){
        [txtFieldPassword resignFirstResponder];
        [txtFieldConfirmPassword becomeFirstResponder];
    }
    else if(txtFieldConfirmPassword == textField){
        [txtFieldConfirmPassword resignFirstResponder];
        [scrollView setContentOffset:CGPointMake(scrollView.frame.origin.x,0) animated:YES];
    }
    return YES;
}

- (NSString *) getDateStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    return [dateFormatter stringFromDate:date];
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
- (IBAction)doneButtonClicked:(id)sender{
    txtFieldDateOfBirth.text = [self getDateStringFromDate:[datePicker date]];
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
