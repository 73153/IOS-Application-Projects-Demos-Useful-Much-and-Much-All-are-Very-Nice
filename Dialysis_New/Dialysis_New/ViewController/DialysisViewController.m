//
//  DialysisViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "DialysisViewController.h"
#import "DataManager.h"
#import "AppConstant.h"
#import "AddDialysisViewController.h"
#import "DialysisReadingCell.h"

@implementation DialysisViewController

@synthesize btnBack;
@synthesize btnAdd;
@synthesize segmentedControl;
@synthesize tblView;
@synthesize dialysisReadingArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    dialysisReadingArray = [[DataManager sharedDataManager] getDialysisReading];
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:kDate
                                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray *newArray = [dialysisReadingArray sortedArrayUsingDescriptors:sortDescriptors];
    dialysisReadingArray = newArray;
    if([dialysisReadingArray count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"No Data Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    [self.tblView reloadData];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addButtonClicked:(id)sender{
    AddDialysisViewController *dialysisViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        dialysisViewController = [[AddDialysisViewController alloc] initWithNibName:@"AddDialysisViewController_iPhone" bundle:nil];
    }
    else{
       dialysisViewController = [[AddDialysisViewController alloc] initWithNibName:@"AddDialysisViewController_iPad" bundle:nil];
    }
    [self.navigationController pushViewController:dialysisViewController animated:YES];
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
        dialysisReadingArray = [[DataManager sharedDataManager] getDialysisReading];
    }
    else if(segmentedControl.selectedSegmentIndex == 1){
        dialysisReadingArray = [[DataManager sharedDataManager] getDialysisReading];
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(7*24*60*60)];
        dialysisReadingArray = [self returnArrayOfProperDates:dialysisReadingArray SelectedDate:date];
    }
    else if(segmentedControl.selectedSegmentIndex == 2){
        dialysisReadingArray = [[DataManager sharedDataManager] getDialysisReading];
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(3*30*24*60*60)];
        dialysisReadingArray = [self returnArrayOfProperDates:dialysisReadingArray SelectedDate:date];
    }
    else if(segmentedControl.selectedSegmentIndex == 3){
        dialysisReadingArray = [[DataManager sharedDataManager] getDialysisReading];
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(6*30*24*60*60)];
        dialysisReadingArray = [self returnArrayOfProperDates:dialysisReadingArray SelectedDate:date];
    }
    else if(segmentedControl.selectedSegmentIndex == 4){
        dialysisReadingArray = [[DataManager sharedDataManager] getDialysisReading];
       NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(1*365*24*60*60)];
        dialysisReadingArray = [self returnArrayOfProperDates:dialysisReadingArray SelectedDate:date];
    }
    [self.tblView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dialysisReadingArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 290;
}

- (NSString *) getDateStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    return [dateFormatter stringFromDate:date];
}

- (void) editButtonClicked:(id)sender{
    int index = [sender tag] - 1000;
    NSDictionary *dataDictionary = [dialysisReadingArray objectAtIndex:index];
    AddDialysisViewController *addDialysisViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        addDialysisViewController = [[AddDialysisViewController alloc] initWithNibName:@"AddDialysisViewController_iPhone" bundle:nil];
    }
    else{
        addDialysisViewController = [[AddDialysisViewController alloc] initWithNibName:@"AddDialysisViewController_iPad" bundle:nil];
    }
    addDialysisViewController.oldDictionary = dataDictionary;
    [self.navigationController pushViewController:addDialysisViewController animated:YES];
    
}

- (void) deleteButtonClicked:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Are you sure you want to delete this record?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES", nil];
    [alert setTag:[sender tag]];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        int index = [alertView tag] - 1000;
        NSDictionary *dataDictionary = [dialysisReadingArray objectAtIndex:index];
        int rowId = [[dataDictionary objectForKey:kRowId] intValue];
        if([[DataManager sharedDataManager] deleteDialysisReadingForRowId:rowId]){
            dialysisReadingArray = [[DataManager sharedDataManager] getDialysisReading];
            [self.tblView reloadData];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DialysisReadingCell *cell =(DialysisReadingCell*) [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if (cell == nil){
        NSArray *topLevelObjects;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
           topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DialysisReadingCell" owner:self options:nil];
        }
        else{
           topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DialysisReadingCell_iPad" owner:self options:nil]; 
        }
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (DialysisReadingCell *) currentObject;
                break;
            }
        }
    }
    NSDictionary *dataDictionary = [dialysisReadingArray objectAtIndex:indexPath.row];
    cell.lblVP.text = [dataDictionary objectForKey:kVP];
    cell.lblAP.text = [dataDictionary objectForKey:kAP];
    cell.lblBF.text = [dataDictionary objectForKey:kBF];
    cell.lblSystolic.text = [dataDictionary objectForKey:kSystolic];
    cell.lblDiastolic.text = [dataDictionary objectForKey:kdiastolic];
    cell.lblDryWeight.text = [dataDictionary objectForKey:kDryWeight];
    cell.lblFluidgain.text = [dataDictionary objectForKey:kFluidGain];
    cell.lblHB.text = [dataDictionary objectForKey:kHB];
    cell.lblBUN.text = [dataDictionary objectForKey:kBun];
    cell.lblCR.text = [dataDictionary objectForKey:kCR];
    cell.lblAlbiumin.text = [dataDictionary objectForKey:kAlbiumin];
    cell.lblPhosph.text = [dataDictionary objectForKey:kPhosph];
    cell.lblPTH.text = [dataDictionary objectForKey:kPTH];
    cell.lblKT.text = [dataDictionary objectForKey:kKT];
    cell.lblINR.text = [dataDictionary objectForKey:kINR];
    cell.lblKTV.text = [dataDictionary objectForKey:kKTV];
    cell.lblDate.text = [self getDateStringFromDate:[dataDictionary objectForKey:kDate]];
    
    [cell.btnEdit setTag:indexPath.row+1000];
    [cell.btnDelete setTag:indexPath.row+1000];
    [cell.btnEdit addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnDelete addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
@end
