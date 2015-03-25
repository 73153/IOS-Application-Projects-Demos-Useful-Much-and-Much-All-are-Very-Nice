//
//  AddBallonAngioPlastyViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "AddBallonAngioPlastyViewController.h"
#import "AppConstant.h"

@implementation AddBallonAngioPlastyViewController

@synthesize txtfieldAngioGraphy;
@synthesize txtfieldBallon;
@synthesize txtfieldStent;

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
    [txtfieldAngioGraphy setReturnKeyType:UIReturnKeyNext];
    [txtfieldBallon setReturnKeyType:UIReturnKeyNext];
    [txtfieldStent setReturnKeyType:UIReturnKeyDone];
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
       [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,465)];
    }
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    selectedDate = [NSDate date];
    if(oldDictionary){
        txtfieldAngioGraphy.text = [oldDictionary objectForKey:kAngiography];
        txtfieldBallon.text = [oldDictionary objectForKey:kBallonAngioPlasty];
        txtfieldStent.text = [oldDictionary objectForKey:kStentPlacement];
        lblDate.text = [self getDateStringFromDate:[oldDictionary objectForKey:kDate]];
        selectedDate = [oldDictionary objectForKey:kDate];
    }
    else{
        txtfieldAngioGraphy.text = @"";
        txtfieldBallon.text = @"";
        txtfieldStent.text = @"";
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
    [dataDictionary setObject:txtfieldAngioGraphy.text forKey:kAngiography];
    [dataDictionary setObject:txtfieldBallon.text forKey:kBallonAngioPlasty];
    [dataDictionary setObject:txtfieldStent.text forKey:kStentPlacement];
    [dataDictionary setObject:selectedDate forKey:kDate];
    if(oldDictionary){
        [[DataManager sharedDataManager] updateBallonData:dataDictionary forRowId:[[oldDictionary objectForKey:kRowId] intValue]];
    }
    else{
        [[DataManager sharedDataManager] insertBallonData:dataDictionary];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == txtfieldAngioGraphy){
        [txtfieldAngioGraphy resignFirstResponder];
        [txtfieldBallon becomeFirstResponder];
    }
    else if(textField == txtfieldBallon){
        [txtfieldBallon resignFirstResponder];
        [txtfieldStent becomeFirstResponder];
    }
    else if(textField == txtfieldStent){
        [txtfieldStent resignFirstResponder];
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,0,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
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
