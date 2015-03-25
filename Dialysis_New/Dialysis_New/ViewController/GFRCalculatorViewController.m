//
//  GFRCalculatorViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 07/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "GFRCalculatorViewController.h"
#import "AppConstant.h"

@implementation GFRCalculatorViewController

@synthesize creatinineTextField;
@synthesize ageTextField;
@synthesize maleButton;
@synthesize femaleButton;
@synthesize africanButton;
@synthesize allOtherButton;
@synthesize isMale;
@synthesize isAfrican;
@synthesize selectedDate;
@synthesize pickerBackGroundView;
@synthesize btnBarCancel;
@synthesize btnBarDone;
@synthesize lblDate;
@synthesize btnChangeDate;
@synthesize datePicker;

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
    isMale = YES;
    isAfrican = YES;
    [creatinineTextField setReturnKeyType:UIReturnKeyNext];
    [ageTextField setReturnKeyType:UIReturnKeyDone];
	// Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    selectedDate = [NSDate date];
    lblDate.text = [self getDateStringFromDate:selectedDate];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sexSelection:(id)sender{
    if ([sender tag] == 101){
        isMale = true;
        [maleButton setBackgroundImage:[UIImage imageNamed:@"redioSelected.png"] forState:UIControlStateNormal];//
        [femaleButton setBackgroundImage:[UIImage imageNamed:@"redioUnSelected.png"] forState:UIControlStateNormal];
    }
    else if ([sender tag] == 102){
        isMale = false;
        [maleButton setBackgroundImage:[UIImage imageNamed:@"redioUnSelected.png"] forState:UIControlStateNormal];//
        [femaleButton setBackgroundImage:[UIImage imageNamed:@"redioSelected.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)raceSelection:(id)sender{
    if ([sender tag] == 201){
        isAfrican = true;
        [africanButton setBackgroundImage:[UIImage imageNamed:@"redioSelected.png"] forState:UIControlStateNormal];//
        [allOtherButton setBackgroundImage:[UIImage imageNamed:@"redioUnSelected.png"] forState:UIControlStateNormal];
    }
    else if ([sender tag] == 202){
        isAfrican = false;
        [africanButton setBackgroundImage:[UIImage imageNamed:@"redioUnSelected.png"] forState:UIControlStateNormal];//
        [allOtherButton setBackgroundImage:[UIImage imageNamed:@"redioSelected.png"] forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == creatinineTextField){
        [creatinineTextField resignFirstResponder];
        [ageTextField becomeFirstResponder];
    }
    else if(textField == ageTextField){
        [ageTextField resignFirstResponder];
    }
    return YES;
}

- (IBAction)backButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (int) returnsDaysBetweenDate:(NSDate *)date1 AndDate:(NSDate *)date2{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:date1
                                                          toDate:date2
                                                         options:0];
    return components.day;
}
- (NSArray *) calculateDays:(NSArray *)array{
    if([array count] == 0)
        return nil;
    NSDate *firstDate = [[array objectAtIndex:0] objectForKey:kDate];
    NSMutableArray *finalArray = [[NSMutableArray alloc] init];
    for(int i=0;i<[array count];i++){
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:[array objectAtIndex:i]];
        NSDate *date = [dictionary objectForKey:kDate];
        int day = [self returnsDaysBetweenDate:firstDate AndDate:date];
        if(day == 0 && i == 0)
            day = 1;
        else
            day = day + 1;
        [dictionary setObject:[NSString stringWithFormat:@"%d",day] forKey:@"day"];
        [finalArray addObject:dictionary];
    }
    return finalArray;
}

- (BOOL )returnCalculations:(NSArray *)array{
    float a = 0;
    float b = 0;
    int b1 = 0;
    float b2 = 0;
    int c = 0;
    for(int i=0;i<[array count];i++){
        NSDictionary *dict = [array objectAtIndex:i];
        a = a + ([[dict objectForKey:@"day"] intValue] * [[dict objectForKey:kGFR] floatValue]);
        b1 = b1 + [[dict objectForKey:@"day"] intValue];
        b2 = b2 + [[dict objectForKey:kGFR] floatValue];
        c = c  + ([[dict objectForKey:@"day"] intValue] * [[dict objectForKey:@"day"] intValue]);
    }
    c = c * [array count];
    a = a  * [array count];
    b = b1 * b2;
    float d = (b1*b1);
    float m = (a-b);
    if((c-d) > 0)
        m = m /(c-d);
    if(m > 0){
        return NO;
    }
    else{
        return YES;
    }
}


- (BOOL) isValid:(NSDictionary *)dictionary{
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[[DataManager sharedDataManager] getGFRData]];
    [array addObject:dictionary];
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:kDate
                                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray *newArray = [array sortedArrayUsingDescriptors:sortDescriptors];
    return [self returnCalculations:[self calculateDays:newArray]];
}


- (IBAction)submitButtonClicked:(id)sender{
    if([creatinineTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please enter creatinine" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([ageTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please enter age" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        double gfr = 0.0;
        double tempSexValue = 0.0;
        double tempRaceValue = 0.0;
        if(isMale){
            tempSexValue = 1.0;
        }
        else{
            tempSexValue = 0.742;
        }
        
        if(isAfrican){
            tempRaceValue = 1.212;
        }
        else{
            tempRaceValue = 1.0;
        }
        gfr = 175*pow([[creatinineTextField text] doubleValue],-1.154)*pow([[ageTextField text] doubleValue],-0.203)*tempSexValue*tempRaceValue;
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        [dataDictionary setObject:creatinineTextField.text forKey:kCreatinine];
        [dataDictionary setObject:[NSString stringWithFormat:@"%0.2f",gfr] forKey:kGFR];
        [dataDictionary setObject:selectedDate forKey:kDate];
        [[DataManager sharedDataManager] insertGFRData:dataDictionary];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
