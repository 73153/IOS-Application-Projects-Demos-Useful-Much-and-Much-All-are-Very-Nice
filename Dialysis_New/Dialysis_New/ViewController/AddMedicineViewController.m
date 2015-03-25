//
//  AddMedicineViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "AddMedicineViewController.h"
#import "AppConstant.h"

@implementation AddMedicineViewController

@synthesize txtFieldPharmacyName;
@synthesize txtFieldLocation;
@synthesize txtFieldContactOne;
@synthesize txtFieldContactTwo;
@synthesize txtFieldMedicine1;
@synthesize txtFieldMedicine2;
@synthesize txtFieldMedicine3;
@synthesize txtFieldMedicine4;
@synthesize txtFieldMedicine5;

@synthesize btnBack;
@synthesize btnSave;

@synthesize scrollView;
@synthesize oldDictionary;
@synthesize textFieldBackground;
@synthesize btnAddMore;

@synthesize dataArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	[txtFieldPharmacyName setReturnKeyType:UIReturnKeyNext];
    [txtFieldLocation setReturnKeyType:UIReturnKeyNext];
    [txtFieldContactOne setReturnKeyType:UIReturnKeyNext];
    [txtFieldContactTwo setReturnKeyType:UIReturnKeyNext];
    [txtFieldMedicine1 setReturnKeyType:UIReturnKeyNext];
    [txtFieldMedicine2 setReturnKeyType:UIReturnKeyNext];
    [txtFieldMedicine3 setReturnKeyType:UIReturnKeyNext];
    [txtFieldMedicine4 setReturnKeyType:UIReturnKeyNext];
    [txtFieldMedicine5 setReturnKeyType:UIReturnKeyDone];
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,550)];
    }
    
    dataArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(oldDictionary){
        txtFieldPharmacyName.text = [oldDictionary objectForKey:kPharmacyName];
        txtFieldLocation.text = [oldDictionary objectForKey:kLocation];
        txtFieldContactOne.text = [oldDictionary objectForKey:kFirstContactNO];
        txtFieldContactTwo.text = [oldDictionary objectForKey:kSecondContactNo];
        NSMutableArray *phonesArray = [[NSMutableArray alloc] initWithArray:[[oldDictionary objectForKey:kMedicine1] componentsSeparatedByString:@","]];
        txtFieldMedicine1.text = [phonesArray objectAtIndex:0];
        [phonesArray removeObjectAtIndex:0];
        
        txtFieldMedicine2.text = [phonesArray objectAtIndex:0];
        [phonesArray removeObjectAtIndex:0];
        
        txtFieldMedicine3.text = [phonesArray objectAtIndex:0];
        [phonesArray removeObjectAtIndex:0];
        
        txtFieldMedicine4.text = [phonesArray objectAtIndex:0];
        [phonesArray removeObjectAtIndex:0];
        
        txtFieldMedicine5.text = [phonesArray objectAtIndex:0];
        [phonesArray removeObjectAtIndex:0];
        
        for(int i=0;i<[phonesArray count];i++){
            UITextField *txtField;
            int y;
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
                y = [dataArray count]*41;
                y = y + txtFieldMedicine5.frame.origin.y+txtFieldMedicine5.frame.size.height+11;
                txtField = [[UITextField alloc] initWithFrame:CGRectMake(0, y, 280, 30)];
                [txtField setBorderStyle:UITextBorderStyleNone];
                [txtField setBackground:[UIImage imageNamed:@"screen2_input.png"]];
                [txtField setTag:[dataArray count]+1001];
                [txtField setText:[phonesArray objectAtIndex:i]];
                [txtField setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
                [txtField setPlaceholder:[NSString stringWithFormat:@"Medicine %d",6+[dataArray count]]];
                [txtField setDelegate:self];
                [textFieldBackground addSubview:txtField];
                [textFieldBackground setFrame:CGRectMake(textFieldBackground.frame.origin.x, textFieldBackground.frame.origin.y,textFieldBackground.frame.size.width, textFieldBackground.frame.size.height+41)];
                [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,scrollView.frame.size.height+(textFieldBackground.frame.size.height*2))];
                [btnAddMore setFrame:CGRectMake(btnAddMore.frame.origin.x,txtField.frame.origin.y+txtField.frame.size.height+5,btnAddMore.frame.size.width, btnAddMore.frame.size.height)];
                [dataArray addObject:[NSString stringWithFormat:@"%d",[txtField tag]]];
            }
            else{
                y = [dataArray count]*71;
                y = y + txtFieldMedicine5.frame.origin.y+txtFieldMedicine5.frame.size.height+18;
                txtField = [[UITextField alloc] initWithFrame:CGRectMake(0,y,641,53)];
                [txtField setBorderStyle:UITextBorderStyleNone];
                [txtField setBackground:[UIImage imageNamed:@"txtField_iPad.png"]];
                [txtField setTag:[dataArray count]+1001];
                [txtField setText:[phonesArray objectAtIndex:i]];
                [txtField setFont:[UIFont fontWithName:@"Helvetica" size:18.0]];
                [txtField setPlaceholder:[NSString stringWithFormat:@"Medicine %d",6+[dataArray count]]];
                [txtField setDelegate:self];
                [textFieldBackground addSubview:txtField];
                [textFieldBackground setFrame:CGRectMake(textFieldBackground.frame.origin.x, textFieldBackground.frame.origin.y,textFieldBackground.frame.size.width, textFieldBackground.frame.size.height+71)];
                [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,scrollView.frame.size.height+(textFieldBackground.frame.size.height*2))];
                [btnAddMore setFrame:CGRectMake(btnAddMore.frame.origin.x,txtField.frame.origin.y+txtField.frame.size.height+5,btnAddMore.frame.size.width, btnAddMore.frame.size.height)];
                [dataArray addObject:[NSString stringWithFormat:@"%d",[txtField tag]]];
            }
        }
    }
    else{
        txtFieldPharmacyName.text = @"";
        txtFieldLocation.text = @"";
        txtFieldContactOne.text = @"";
        txtFieldContactTwo.text = @"";
        txtFieldMedicine1.text = @"";
        txtFieldMedicine2.text = @"";
        txtFieldMedicine3.text = @"";
        txtFieldMedicine4.text = @"";
        txtFieldMedicine5.text = @"";
    }
}


- (IBAction)btnBackClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnSaveClicked:(id)sender{
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
    [dataDictionary setObject:txtFieldPharmacyName.text forKey:kPharmacyName];
    [dataDictionary setObject:txtFieldLocation.text forKey:kLocation];
    [dataDictionary setObject:txtFieldContactOne.text forKey:kFirstContactNO];
    [dataDictionary setObject:txtFieldContactTwo.text forKey:kSecondContactNo];

    NSArray *array = [NSArray arrayWithObjects:txtFieldMedicine1.text,txtFieldMedicine2.text,txtFieldMedicine3.text,txtFieldMedicine4.text,txtFieldMedicine5.text, nil];
    NSMutableArray *finalArray = [[NSMutableArray alloc] initWithArray:array];
    for(int i=0;i<[dataArray count];i++){
        int tag = [[dataArray objectAtIndex:i] intValue];
        UITextField *txtField = (UITextField *)[textFieldBackground viewWithTag:tag];
        [finalArray addObject:txtField.text];
    }
    NSString *strPhone = [finalArray componentsJoinedByString:@","];
    [dataDictionary setObject:strPhone forKey:kMedicine1];
    if(oldDictionary){
        [[DataManager sharedDataManager] updateMedicineData:dataDictionary forRowId:[[oldDictionary objectForKey:kRowId] intValue]];
    }
    else{
        [[DataManager sharedDataManager] insertMedicineData:dataDictionary];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == txtFieldPharmacyName){
        [txtFieldPharmacyName resignFirstResponder];
        [txtFieldLocation becomeFirstResponder];
    }
    else if(textField == txtFieldLocation){
        [txtFieldLocation resignFirstResponder];
        [txtFieldContactOne becomeFirstResponder];
    }
    else if(textField == txtFieldContactOne){
        [txtFieldContactOne resignFirstResponder];
        [txtFieldContactTwo becomeFirstResponder];
    }
    else if(textField == txtFieldContactTwo){
        [txtFieldContactTwo resignFirstResponder];
        [txtFieldMedicine1 becomeFirstResponder];
    }
    else if(textField == txtFieldMedicine1){
        [txtFieldMedicine1 resignFirstResponder];
        [txtFieldMedicine2 becomeFirstResponder];
    }
    else if(textField == txtFieldMedicine2){
        [txtFieldMedicine2 resignFirstResponder];
        [txtFieldMedicine3 becomeFirstResponder];
    }
    else if(textField == txtFieldMedicine3){
        [txtFieldMedicine3 resignFirstResponder];
        [txtFieldMedicine4 becomeFirstResponder];
    }
    else if(textField == txtFieldMedicine4){
        [txtFieldMedicine4 resignFirstResponder];
        [txtFieldMedicine5 becomeFirstResponder];
    }
    else if(textField == txtFieldMedicine5){
        [txtFieldMedicine5 resignFirstResponder];
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,0,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else{
        [textField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == txtFieldContactTwo){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtFieldContactTwo.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtFieldMedicine1){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtFieldMedicine1.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtFieldMedicine2){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtFieldMedicine2.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtFieldMedicine3){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtFieldMedicine3.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtFieldMedicine4){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtFieldMedicine4.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtFieldMedicine5){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,textFieldBackground.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    return YES;
}

- (IBAction)btnAddMoreClicked:(id)sender{
    UITextField *txtField;
    int y;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        y = [dataArray count]*41;
        y = y + txtFieldMedicine5.frame.origin.y+txtFieldMedicine5.frame.size.height+11;
        txtField = [[UITextField alloc] initWithFrame:CGRectMake(0, y, 280, 30)];
        [txtField setBorderStyle:UITextBorderStyleNone];
        [txtField setBackground:[UIImage imageNamed:@"screen2_input.png"]];
        [txtField setTag:[dataArray count]+1001];
        [txtField setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
        [txtField setPlaceholder:[NSString stringWithFormat:@"Medicine %d",6+[dataArray count]]];
        [txtField setDelegate:self];
        [textFieldBackground addSubview:txtField];
        [textFieldBackground setFrame:CGRectMake(textFieldBackground.frame.origin.x, textFieldBackground.frame.origin.y,textFieldBackground.frame.size.width, textFieldBackground.frame.size.height+41)];
       [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,scrollView.frame.size.height+(textFieldBackground.frame.size.height*2))];
        [btnAddMore setFrame:CGRectMake(btnAddMore.frame.origin.x,txtField.frame.origin.y+txtField.frame.size.height+5,btnAddMore.frame.size.width, btnAddMore.frame.size.height)];
        [dataArray addObject:[NSString stringWithFormat:@"%d",[txtField tag]]];
    }
    else{
        y = [dataArray count]*71;
        y = y + txtFieldMedicine5.frame.origin.y+txtFieldMedicine5.frame.size.height+18;
        txtField = [[UITextField alloc] initWithFrame:CGRectMake(0,y,641,53)];
        [txtField setBorderStyle:UITextBorderStyleNone];
        [txtField setBackground:[UIImage imageNamed:@"txtField_iPad.png"]];
        [txtField setTag:[dataArray count]+1001];
        [txtField setFont:[UIFont fontWithName:@"Helvetica" size:18.0]];
        [txtField setPlaceholder:[NSString stringWithFormat:@"Medicine %d",6+[dataArray count]]];
        [txtField setDelegate:self];
        [textFieldBackground addSubview:txtField];
        [textFieldBackground setFrame:CGRectMake(textFieldBackground.frame.origin.x, textFieldBackground.frame.origin.y,textFieldBackground.frame.size.width, textFieldBackground.frame.size.height+71)];
        [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,scrollView.frame.size.height+(textFieldBackground.frame.size.height*2))];
        [btnAddMore setFrame:CGRectMake(btnAddMore.frame.origin.x,txtField.frame.origin.y+txtField.frame.size.height+5,btnAddMore.frame.size.width, btnAddMore.frame.size.height)];
        [dataArray addObject:[NSString stringWithFormat:@"%d",[txtField tag]]];
    }
}
@end
