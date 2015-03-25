//
//  BloodPressureViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "BloodPressureViewController.h"
#import "DataManager.h"
#import "AppConstant.h"
#import "BloodPressureCell.h"
#import "AddBloodPressureViewController.h"

@implementation BloodPressureViewController

@synthesize btnBack;
@synthesize btnAdd;
@synthesize segmentedControl;
@synthesize tblView;
@synthesize bloodPressureArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    bloodPressureArray = [[DataManager sharedDataManager] getBloodPressureData];
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:kDate
                                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray *newArray = [bloodPressureArray sortedArrayUsingDescriptors:sortDescriptors];
    bloodPressureArray = newArray;
    if([bloodPressureArray count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"No Data Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    [self.tblView reloadData];
}

- (IBAction)backButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addButtonClicked:(id)sender{
    AddBloodPressureViewController *addBloodPressureViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        addBloodPressureViewController = [[AddBloodPressureViewController alloc] initWithNibName:@"AddBloodPressureViewController_iPhone" bundle:nil];
    }
    else{
        addBloodPressureViewController = [[AddBloodPressureViewController alloc] initWithNibName:@"AddBloodPressureViewController_iPad" bundle:nil];
    }
    [self.navigationController pushViewController:addBloodPressureViewController animated:YES];
}
- (NSArray *) returnArrayOfProperDates:(NSArray *)array SelectedDate:(NSDate *)date{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for(int i=0;i<[array count];i++){
        NSDictionary *dataDictionary = [array objectAtIndex:i];
        NSDate *storedDate = [dataDictionary objectForKey:kDate];
        if([storedDate compare:date] == NSOrderedDescending){
            [tempArray addObject:dataDictionary];
        }
    }
    return tempArray;
}



- (IBAction)segmentedControlValueChanged:(id)sender{
    if(segmentedControl.selectedSegmentIndex == 0){
        bloodPressureArray = [[DataManager sharedDataManager] getBloodPressureData];
    }
    else if(segmentedControl.selectedSegmentIndex == 1){
        bloodPressureArray = [[DataManager sharedDataManager] getBloodPressureData];
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(7*24*60*60)];
        bloodPressureArray = [self returnArrayOfProperDates:bloodPressureArray SelectedDate:date];
    }
    else if(segmentedControl.selectedSegmentIndex == 2){
        bloodPressureArray = [[DataManager sharedDataManager] getBloodPressureData];
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(3*30*24*60*60)];
        bloodPressureArray = [self returnArrayOfProperDates:bloodPressureArray SelectedDate:date];
    }
    else if(segmentedControl.selectedSegmentIndex == 3){
        bloodPressureArray = [[DataManager sharedDataManager] getBloodPressureData];
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(6*30*24*60*60)];
        bloodPressureArray = [self returnArrayOfProperDates:bloodPressureArray SelectedDate:date];
    }
    else if(segmentedControl.selectedSegmentIndex == 4){
        bloodPressureArray = [[DataManager sharedDataManager] getBloodPressureData];
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(1*365*24*60*60)];
        bloodPressureArray = [self returnArrayOfProperDates:bloodPressureArray SelectedDate:date];
    }
    [self.tblView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [bloodPressureArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 103;
}

- (NSString *) getDateStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    return [dateFormatter stringFromDate:date];
}

- (void) editButtonClicked:(id)sender{
    int index = [sender tag] - 1000;
    NSDictionary *dataDictionary = [bloodPressureArray objectAtIndex:index];
    AddBloodPressureViewController *addBloodPressureViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        addBloodPressureViewController = [[AddBloodPressureViewController alloc] initWithNibName:@"AddBloodPressureViewController_iPhone" bundle:nil];
    }
    else{
        addBloodPressureViewController = [[AddBloodPressureViewController alloc] initWithNibName:@"AddBloodPressureViewController_iPad" bundle:nil];
    }
    addBloodPressureViewController.oldDictionary = dataDictionary;
    [self.navigationController pushViewController:addBloodPressureViewController animated:YES];
}

- (void) deleteButtonClicked:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Are you sure you want to delete this record?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES", nil];
    [alert setTag:[sender tag]];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        int index = [alertView tag] - 1000;
        NSDictionary *dataDictionary = [bloodPressureArray objectAtIndex:index];
        int rowId = [[dataDictionary objectForKey:kRowId] intValue];
        if([[DataManager sharedDataManager] deleteBloodPressureDataForRowId:rowId]){
            bloodPressureArray = [[DataManager sharedDataManager] getBloodPressureData];
            [self.tblView reloadData];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BloodPressureCell *cell =(BloodPressureCell*) [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if (cell == nil){
        NSArray *topLevelObjects;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
           topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"BloodPressureCell" owner:self options:nil];
        }
        else{
           topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"BloodPressureCell_iPad" owner:self options:nil];
        }
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (BloodPressureCell *) currentObject;
                break;
            }
        }
    }
    NSDictionary *dataDictionary = [bloodPressureArray objectAtIndex:indexPath.row];
    cell.lblDate.text = [self getDateStringFromDate:[dataDictionary objectForKey:kDate]];
    cell.lblSystolic.text = [dataDictionary objectForKey:kSystolic];
    cell.lblDiastolic.text = [dataDictionary objectForKey:kdiastolic];
    
    [cell.btnEdit setTag:indexPath.row+1000];
    [cell.btnDelete setTag:indexPath.row+1000];
    [cell.btnEdit addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnDelete addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
@end
