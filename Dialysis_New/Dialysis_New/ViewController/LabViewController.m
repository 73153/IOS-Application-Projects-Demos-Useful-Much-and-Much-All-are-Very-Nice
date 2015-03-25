//
//  LabViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "LabViewController.h"
#import "DataManager.h"
#import "AppConstant.h"
#import "AddLabViewController.h"
#import "LabViewCell.h"
#import "LabViewCell.h"


@implementation LabViewController

@synthesize btnBack;
@synthesize btnAdd;
@synthesize segmentedControl;
@synthesize tblView;
@synthesize labReadingArray;

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
    labReadingArray = [[DataManager sharedDataManager] getLabData];
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:kDate
                                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray *newArray = [labReadingArray sortedArrayUsingDescriptors:sortDescriptors];
    labReadingArray = newArray;
    
    if([labReadingArray count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"No Data Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    [self.tblView reloadData];
}
- (IBAction)backButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addButtonClicked:(id)sender{
    AddLabViewController *addLabViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        addLabViewController = [[AddLabViewController alloc] initWithNibName:@"AddLabViewController_iPhone" bundle:nil];
    }
    else{
        addLabViewController = [[AddLabViewController alloc] initWithNibName:@"AddLabViewController_iPad" bundle:nil];
    }
    [self.navigationController pushViewController:addLabViewController animated:YES];
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
        labReadingArray = [[DataManager sharedDataManager] getLabData];
    }
    else if(segmentedControl.selectedSegmentIndex == 1){
        labReadingArray = [[DataManager sharedDataManager] getLabData];
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(7*24*60*60)];
        labReadingArray = [self returnArrayOfProperDates:labReadingArray SelectedDate:date];
    }
    else if(segmentedControl.selectedSegmentIndex == 2){
        labReadingArray = [[DataManager sharedDataManager] getLabData];
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(3*30*24*60*60)];
        labReadingArray = [self returnArrayOfProperDates:labReadingArray SelectedDate:date];
    }
    else if(segmentedControl.selectedSegmentIndex == 3){
        labReadingArray = [[DataManager sharedDataManager] getLabData];
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(6*30*24*60*60)];
        labReadingArray = [self returnArrayOfProperDates:labReadingArray SelectedDate:date];
    }
    else if(segmentedControl.selectedSegmentIndex == 4){
        labReadingArray = [[DataManager sharedDataManager] getLabData];
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(1*365*24*60*60)];
        labReadingArray = [self returnArrayOfProperDates:labReadingArray SelectedDate:date];
    }
    [self.tblView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [labReadingArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 142;
}

- (NSString *) getDateStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    return [dateFormatter stringFromDate:date];
}

- (void) editButtonClicked:(id)sender{
    int index = [sender tag] - 1000;
    NSDictionary *dataDictionary = [labReadingArray objectAtIndex:index];
    AddLabViewController *addLabViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        addLabViewController = [[AddLabViewController alloc] initWithNibName:@"AddLabViewController_iPhone" bundle:nil];
    }
    else{
        addLabViewController = [[AddLabViewController alloc] initWithNibName:@"AddLabViewController_iPad" bundle:nil];
    }
    addLabViewController.oldDictionary = dataDictionary;
    [self.navigationController pushViewController:addLabViewController animated:YES];
    
}

- (void) deleteButtonClicked:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Are you sure you want to delete this record?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES", nil];
    [alert setTag:[sender tag]];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        int index = [alertView tag] - 1000;
        NSDictionary *dataDictionary = [labReadingArray objectAtIndex:index];
        int rowId = [[dataDictionary objectForKey:kRowId] intValue];
        if([[DataManager sharedDataManager] deleteLabDataForRowId:rowId]){
            labReadingArray = [[DataManager sharedDataManager] getLabData];
            [self.tblView reloadData];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LabViewCell *cell =(LabViewCell*) [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if (cell == nil){
        NSArray *topLevelObjects;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
           topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LabViewCell" owner:self options:nil];
        }
        else{
           topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LabViewCell_iPad" owner:self options:nil];
        }
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (LabViewCell *) currentObject;
                break;
            }
        }
    }
    NSDictionary *dataDictionary = [labReadingArray objectAtIndex:indexPath.row];
    cell.lblHB.text = [dataDictionary objectForKey:kHB];
    cell.lblBUN.text = [dataDictionary objectForKey:kBun];
    cell.lblCR.text = [dataDictionary objectForKey:kCR];
    cell.lblAlbiumin.text = [dataDictionary objectForKey:kAlbiumin];
    cell.lblPhosph.text = [dataDictionary objectForKey:kPhosph];
    cell.lblPTH.text = [dataDictionary objectForKey:kPTH];
    cell.lblKT.text = [dataDictionary objectForKey:kKT];
    cell.lblINR.text = [dataDictionary objectForKey:kINR];
    cell.lblDate.text = [self getDateStringFromDate:[dataDictionary objectForKey:kDate]];
    
    [cell.btnEdit setTag:indexPath.row+1000];
    [cell.btnDelete setTag:indexPath.row+1000];
    [cell.btnEdit addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnDelete addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


@end
