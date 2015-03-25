//
//  AddDialysisViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 28/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "DataManager.h"
#import "AppConstant.h"
#import "AddDialysisViewController.h"

@implementation AddDialysisViewController

@synthesize txtfield1;
@synthesize txtfield2;
@synthesize txtfield3;
@synthesize txtfield4;
@synthesize txtfield5;
@synthesize txtfield6;
@synthesize txtfield7;
@synthesize txtfield8;
@synthesize txtfield9;
@synthesize txtfield10;
@synthesize txtfield11;
@synthesize txtfield12;
@synthesize txtfield13;
@synthesize txtfield14;
@synthesize txtfield15;
@synthesize txtfield16;

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
    [txtfield1 setReturnKeyType:UIReturnKeyNext];
    [txtfield2 setReturnKeyType:UIReturnKeyNext];
    [txtfield3 setReturnKeyType:UIReturnKeyNext];
    [txtfield4 setReturnKeyType:UIReturnKeyNext];
    [txtfield5 setReturnKeyType:UIReturnKeyNext];
    [txtfield6 setReturnKeyType:UIReturnKeyNext];
    [txtfield7 setReturnKeyType:UIReturnKeyNext];
    [txtfield8 setReturnKeyType:UIReturnKeyNext];
    [txtfield9 setReturnKeyType:UIReturnKeyNext];
    [txtfield10 setReturnKeyType:UIReturnKeyNext];
    [txtfield11 setReturnKeyType:UIReturnKeyNext];
    [txtfield12 setReturnKeyType:UIReturnKeyNext];
    [txtfield13 setReturnKeyType:UIReturnKeyNext];
    [txtfield14 setReturnKeyType:UIReturnKeyNext];
    [txtfield15 setReturnKeyType:UIReturnKeyNext];
    [txtfield16 setReturnKeyType:UIReturnKeyDone];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,880)];
    }
    else{
        [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,1300)];
    }
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    selectedDate = [NSDate date];
    if(oldDictionary){
        txtfield1.text = [oldDictionary objectForKey:kVP];
        txtfield2.text = [oldDictionary objectForKey:kAP];
        txtfield3.text = [oldDictionary objectForKey:kBF];
        txtfield4.text = [oldDictionary objectForKey:kKTV];
        txtfield5.text = [oldDictionary objectForKey:kSystolic];
        txtfield6.text = [oldDictionary objectForKey:kdiastolic];
        txtfield7.text = [oldDictionary objectForKey:kDryWeight];
        txtfield8.text = [oldDictionary objectForKey:kFluidGain];
        txtfield9.text = [oldDictionary objectForKey:kHB];
        txtfield10.text = [oldDictionary objectForKey:kBun];
        txtfield11.text = [oldDictionary objectForKey:kCR];
        txtfield12.text = [oldDictionary objectForKey:kAlbiumin];
        txtfield13.text = [oldDictionary objectForKey:kPhosph];
        txtfield14.text = [oldDictionary objectForKey:kPTH];
        txtfield15.text = [oldDictionary objectForKey:kKT];
        txtfield16.text = [oldDictionary objectForKey:kINR];
        lblDate.text = [self getDateStringFromDate:[oldDictionary objectForKey:kDate]];
        selectedDate = [oldDictionary objectForKey:kDate];
    }
    else{
        txtfield1.text = @"";
        txtfield2.text = @"";
        txtfield3.text = @"";
        txtfield4.text = @"";
        txtfield5.text = @"";
        txtfield6.text = @"";
        txtfield7.text = @"";
        txtfield8.text = @"";
        txtfield9.text = @"";
        txtfield10.text = @"";
        txtfield11.text = @"";
        txtfield12.text = @"";
        txtfield13.text = @"";
        txtfield14.text = @"";
        txtfield15.text = @"";
        txtfield16.text = @"";
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
    [dataDictionary setObject:txtfield1.text forKey:kVP];
    [dataDictionary setObject:txtfield2.text forKey:kAP];
    [dataDictionary setObject:txtfield3.text forKey:kBF];
    [dataDictionary setObject:txtfield4.text forKey:kKTV];
    [dataDictionary setObject:txtfield5.text forKey:kSystolic];
    [dataDictionary setObject:txtfield6.text forKey:kdiastolic];
    [dataDictionary setObject:txtfield7.text forKey:kDryWeight];
    [dataDictionary setObject:txtfield8.text forKey:kFluidGain];
    [dataDictionary setObject:txtfield9.text forKey:kHB];
    [dataDictionary setObject:txtfield10.text forKey:kBun];
    [dataDictionary setObject:txtfield11.text forKey:kCR];
    [dataDictionary setObject:txtfield12.text forKey:kAlbiumin];
    [dataDictionary setObject:txtfield13.text forKey:kPhosph];
    [dataDictionary setObject:txtfield14.text forKey:kPTH];
    [dataDictionary setObject:txtfield15.text forKey:kKT];
    [dataDictionary setObject:txtfield16.text forKey:kINR];
    [dataDictionary setObject:selectedDate forKey:kDate];
    if(oldDictionary){
        [[DataManager sharedDataManager] updateDialysisReading:dataDictionary forRowId:[[oldDictionary objectForKey:kRowId] intValue]];
    }
    else{
        [[DataManager sharedDataManager] insertDialysisreading:dataDictionary];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == txtfield1){
        [txtfield1 resignFirstResponder];
        [txtfield2 becomeFirstResponder];
    }
    else if(textField == txtfield2){
        [txtfield2 resignFirstResponder];
        [txtfield3 becomeFirstResponder];
    }
    else if(textField == txtfield3){
        [txtfield3 resignFirstResponder];
        [txtfield4 becomeFirstResponder];
    }
    else if(textField == txtfield4){
        [txtfield4 resignFirstResponder];
        [txtfield7 becomeFirstResponder];
    }
    else if(textField == txtfield7){
        [txtfield7 resignFirstResponder];
        [txtfield8 becomeFirstResponder];
    }
    else if(textField == txtfield8){
        [txtfield8 resignFirstResponder];
        [txtfield5 becomeFirstResponder];
    }
    else if(textField == txtfield5){
        [txtfield5 resignFirstResponder];
        [txtfield6 becomeFirstResponder];
    }
    else if(textField == txtfield6){
        [txtfield6 resignFirstResponder];
        [txtfield9 becomeFirstResponder];
    }
    else if(textField == txtfield9){
        [txtfield9 resignFirstResponder];
        [txtfield10 becomeFirstResponder];
    }
    else if(textField == txtfield10){
        [txtfield10 resignFirstResponder];
        [txtfield11 becomeFirstResponder];
    }
    else if(textField == txtfield11){
        [txtfield11 resignFirstResponder];
        [txtfield12 becomeFirstResponder];
    }
    else if(textField == txtfield12){
        [txtfield12 resignFirstResponder];
        [txtfield13 becomeFirstResponder];
    }
    else if(textField == txtfield13){
        [txtfield13 resignFirstResponder];
        [txtfield14 becomeFirstResponder];
    }
    else if(textField == txtfield14){
        [txtfield14 resignFirstResponder];
        [txtfield15 becomeFirstResponder];
    }
    else if(textField == txtfield15){
        [txtfield15 resignFirstResponder];
        [txtfield16 becomeFirstResponder];
    }
    else if(textField == txtfield16){
        [txtfield16 resignFirstResponder];
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,0,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == txtfield5){
       [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtfield5.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtfield6){
       [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtfield6.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtfield7){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtfield7.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtfield8){
       [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtfield8.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtfield9){
       [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtfield9.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtfield10){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtfield10.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtfield11){
       [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtfield11.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtfield12){
       [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtfield12.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtfield13){
       [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtfield13.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtfield14){
       [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtfield14.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtfield15){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtfield15.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtfield16){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtfield16.frame.origin.y+30,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
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
