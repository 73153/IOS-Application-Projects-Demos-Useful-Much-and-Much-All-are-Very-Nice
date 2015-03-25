//
//  AddLabViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "AddLabViewController.h"
#import "AppConstant.h"


@implementation AddLabViewController

@synthesize txtFieldHB;
@synthesize txtfieldBUN;
@synthesize txtfieldCR;
@synthesize txtfieldAlbumin;
@synthesize txtfieldPhosph;
@synthesize txtfieldPTH;
@synthesize txtfieldKT;
@synthesize txtfieldINR;

@synthesize btnBack;
@synthesize btnSave;

@synthesize scrollView;
@synthesize selectedDate;
@synthesize oldDictionary;

@synthesize pickerBackGroundView;
@synthesize btnBarCancel;
@synthesize btnBarDone;
@synthesize lblDate;
@synthesize btnChangeDate;
@synthesize datePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
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
    [txtFieldHB setReturnKeyType:UIReturnKeyNext];
    [txtfieldBUN setReturnKeyType:UIReturnKeyNext];
    [txtfieldCR setReturnKeyType:UIReturnKeyNext];
    [txtfieldAlbumin setReturnKeyType:UIReturnKeyNext];
    [txtfieldPhosph setReturnKeyType:UIReturnKeyNext];
    [txtfieldPTH setReturnKeyType:UIReturnKeyNext];
    [txtfieldKT setReturnKeyType:UIReturnKeyNext];
    [txtfieldINR setReturnKeyType:UIReturnKeyDone];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,500)];
    }
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    selectedDate = [NSDate date];
    if(oldDictionary){
        [txtFieldHB setText:[oldDictionary objectForKey:kHB]];
        [txtfieldBUN setText:[oldDictionary objectForKey:kBun]];
        [txtfieldCR setText:[oldDictionary objectForKey:kCR]];
        [txtfieldAlbumin setText:[oldDictionary objectForKey:kAlbiumin]];
        [txtfieldPhosph setText:[oldDictionary objectForKey:kPhosph]];
        [txtfieldPTH setText:[oldDictionary objectForKey:kPTH]];
        [txtfieldKT setText:[oldDictionary objectForKey:kKT]];
        [txtfieldINR setText:[oldDictionary objectForKey:kINR]];
        lblDate.text = [self getDateStringFromDate:[oldDictionary objectForKey:kDate]];
        selectedDate = [oldDictionary objectForKey:kDate];
    }
    else{
        [txtFieldHB setText:@""];
        [txtfieldBUN setText:@""];
        [txtfieldCR setText:@""];
        [txtfieldAlbumin setText:@""];
        [txtfieldPhosph setText:@""];
        [txtfieldPTH setText:@""];
        [txtfieldKT setText:@""];
        [txtfieldINR setText:@""];
        lblDate.text = [self getDateStringFromDate:selectedDate];
    }
}

- (IBAction)btnBackClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnSaveClicked:(id)sender{
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
    [dataDictionary setObject:txtFieldHB.text forKey:kHB];
    [dataDictionary setObject:txtfieldBUN.text forKey:kBun];
    [dataDictionary setObject:txtfieldCR.text forKey:kCR];
    [dataDictionary setObject:txtfieldAlbumin.text forKey:kAlbiumin];
    [dataDictionary setObject:txtfieldPhosph.text forKey:kPhosph];
    [dataDictionary setObject:txtfieldPTH.text forKey:kPTH];
    [dataDictionary setObject:txtfieldKT.text forKey:kKT];
    [dataDictionary setObject:txtfieldINR.text forKey:kINR];
    [dataDictionary setObject:selectedDate forKey:kDate];
    if(oldDictionary){
        [[DataManager sharedDataManager] updateLabData:dataDictionary forRowId:[[oldDictionary objectForKey:kRowId] intValue]];
    }
    else{
        [[DataManager sharedDataManager] insertLabData:dataDictionary];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == txtFieldHB){
        [txtFieldHB resignFirstResponder];
        [txtfieldBUN becomeFirstResponder];
    }
    else if(textField == txtfieldBUN){
        [txtfieldBUN resignFirstResponder];
        [txtfieldCR becomeFirstResponder];
    }
    else if(textField == txtfieldCR){
        [txtfieldCR resignFirstResponder];
        [txtfieldAlbumin becomeFirstResponder];
    }
    else if(textField == txtfieldAlbumin){
        [txtfieldAlbumin resignFirstResponder];
        [txtfieldPhosph becomeFirstResponder];
    }
    else if(textField == txtfieldPhosph){
        [txtfieldPhosph resignFirstResponder];
        [txtfieldPTH becomeFirstResponder];
    }
    else if(textField == txtfieldPTH){
        [txtfieldPTH resignFirstResponder];
        [txtfieldKT becomeFirstResponder];
    }
    else if(textField == txtfieldKT){
        [txtfieldKT resignFirstResponder];
        [txtfieldINR becomeFirstResponder];
    }
    else if(textField == txtfieldINR){
        [txtfieldINR resignFirstResponder];
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,0,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
     if(textField == txtfieldAlbumin){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtfieldAlbumin.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtfieldPhosph){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtfieldPhosph.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtfieldPTH){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtfieldPTH.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtfieldKT){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtfieldKT.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtfieldINR){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtfieldINR.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
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
