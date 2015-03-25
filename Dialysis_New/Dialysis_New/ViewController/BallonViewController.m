//
//  BallonViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "BallonViewController.h"
#import "DataManager.h"
#import "AppConstant.h"
#import "BallonAngioplastyCell.h"
#import "AddBallonAngioPlastyViewController.h"

@implementation BallonViewController

@synthesize btnBack;
@synthesize btnAdd;
@synthesize segmentedControl;
@synthesize tblView;
@synthesize ballonAngioplastyArray;

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
    ballonAngioplastyArray = [[DataManager sharedDataManager] getBallonData];
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:kDate
                                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray *newArray = [ballonAngioplastyArray sortedArrayUsingDescriptors:sortDescriptors];
    ballonAngioplastyArray = newArray;
    if([ballonAngioplastyArray count] == 0){
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
    AddBallonAngioPlastyViewController *addBallonViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        addBallonViewController = [[AddBallonAngioPlastyViewController alloc] initWithNibName:@"AddBallonAngioPlastyViewController_iPhone" bundle:nil];
    }
    else{
        addBallonViewController = [[AddBallonAngioPlastyViewController alloc] initWithNibName:@"AddBallonAngioPlastyViewController_iPad" bundle:nil];
    }
    [self.navigationController pushViewController:addBallonViewController animated:YES];
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
        ballonAngioplastyArray = [[DataManager sharedDataManager] getBallonData];
    }
    else if(segmentedControl.selectedSegmentIndex == 1){
        ballonAngioplastyArray = [[DataManager sharedDataManager] getBallonData];
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(7*24*60*60)];
        ballonAngioplastyArray = [self returnArrayOfProperDates:ballonAngioplastyArray SelectedDate:date];
    }
    else if(segmentedControl.selectedSegmentIndex == 2){
        ballonAngioplastyArray = [[DataManager sharedDataManager] getBallonData];
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(3*30*24*60*60)];
        ballonAngioplastyArray = [self returnArrayOfProperDates:ballonAngioplastyArray SelectedDate:date];
    }
    else if(segmentedControl.selectedSegmentIndex == 3){
        ballonAngioplastyArray = [[DataManager sharedDataManager] getBallonData];
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(6*30*24*60*60)];
        ballonAngioplastyArray = [self returnArrayOfProperDates:ballonAngioplastyArray SelectedDate:date];
    }
    else if(segmentedControl.selectedSegmentIndex == 4){
        ballonAngioplastyArray = [[DataManager sharedDataManager] getBallonData];
        NSDate *date  = [[NSDate date] dateByAddingTimeInterval:-(1*365*24*60*60)];
        ballonAngioplastyArray = [self returnArrayOfProperDates:ballonAngioplastyArray SelectedDate:date];
    }
    [self.tblView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ballonAngioplastyArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 134;
}

- (NSString *) getDateStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    return [dateFormatter stringFromDate:date];
}

- (void) editButtonClicked:(id)sender{
    int index = [sender tag] - 1000;
    NSDictionary *dataDictionary = [ballonAngioplastyArray objectAtIndex:index];
    AddBallonAngioPlastyViewController *addBallonViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        addBallonViewController = [[AddBallonAngioPlastyViewController alloc] initWithNibName:@"AddBallonAngioPlastyViewController_iPhone" bundle:nil];
    }
    else{
        addBallonViewController = [[AddBallonAngioPlastyViewController alloc] initWithNibName:@"AddBallonAngioPlastyViewController_iPad" bundle:nil];
    }
    addBallonViewController.oldDictionary = dataDictionary;
    [self.navigationController pushViewController:addBallonViewController animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        int index = [alertView tag] - 1000;
        NSDictionary *dataDictionary = [ballonAngioplastyArray objectAtIndex:index];
        int rowId = [[dataDictionary objectForKey:kRowId] intValue];
        if([[DataManager sharedDataManager] deleteBallonDataForRowId:rowId]){
            ballonAngioplastyArray = [[DataManager sharedDataManager] getBallonData];
            [self.tblView reloadData];
        }
    }
}

- (void) deleteButtonClicked:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Are you sure you want to delete this record?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES", nil];
    [alert setTag:[sender tag]];
    [alert show];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BallonAngioplastyCell *cell =(BallonAngioplastyCell*) [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if (cell == nil){
        NSArray *topLevelObjects;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"BallonAngioplastyCell" owner:self options:nil];
        }
        else{
           topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"BallonAngioplastyCell_iPad" owner:self options:nil]; 
        }
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (BallonAngioplastyCell *) currentObject;
                break;
            }
        }
    }
    NSDictionary *dataDictionary = [ballonAngioplastyArray objectAtIndex:indexPath.row];
    cell.lblDate.text = [self getDateStringFromDate:[dataDictionary objectForKey:kDate]];
    cell.lblAngiography.text = [dataDictionary objectForKey:kAngiography];
    cell.lblBallonAngioplasty.text = [dataDictionary objectForKey:kBallonAngioPlasty];
    cell.lblStentPlacement.text = [dataDictionary objectForKey:kStentPlacement];
    
    
    [cell.btnEdit setTag:indexPath.row+1000];
    [cell.btnDelete setTag:indexPath.row+1000];
    [cell.btnEdit addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnDelete addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
@end
