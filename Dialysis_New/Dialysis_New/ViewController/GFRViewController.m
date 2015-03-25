//
//  GFRViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 26/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "GFRViewController.h"
#import "GFRCalculatorViewController.h"
#import "AppConstant.h"
#import "GFRCell.h"

@implementation GFRViewController

@synthesize btnBack;
@synthesize btnAdd;
@synthesize tblView;
@synthesize gfrReadingArray;

- (NSString *) getDateStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    return [dateFormatter stringFromDate:date];
}


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
    gfrReadingArray = [[DataManager sharedDataManager] getGFRData];
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:kDate
                                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray *newArray = [gfrReadingArray sortedArrayUsingDescriptors:sortDescriptors];
    gfrReadingArray = newArray;
    if([gfrReadingArray count] == 0){
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
    GFRCalculatorViewController *gfrCalculatorViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        gfrCalculatorViewController = [[GFRCalculatorViewController alloc] initWithNibName:@"GFRCalculatorViewController_iPhone" bundle:nil];
    }
    else{
        gfrCalculatorViewController = [[GFRCalculatorViewController alloc] initWithNibName:@"GFRCalculatorViewController_iPad" bundle:nil];
    }
    [self.navigationController pushViewController:gfrCalculatorViewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [gfrReadingArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 103;
}

- (void) deleteButtonClicked:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Are you sure you want to delete this record?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES", nil];
    [alert setTag:[sender tag]];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        int index = [alertView tag] - 1000;
        NSDictionary *dataDictionary = [gfrReadingArray objectAtIndex:index];
        int rowId = [[dataDictionary objectForKey:kRowId] intValue];
        if([[DataManager sharedDataManager] deleteGFRDataForRowId:rowId]){
            gfrReadingArray = [[DataManager sharedDataManager] getGFRData];
            [self.tblView reloadData];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GFRCell *cell =(GFRCell*) [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if (cell == nil){
        NSArray *topLevelObjects;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"GFRCell_iPhone" owner:self options:nil];
        }
        else{
            topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"GFRCell_iPad" owner:self options:nil];
        }
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (GFRCell *) currentObject;
                break;
            }
        }
    }
    NSDictionary *dataDictionary = [gfrReadingArray objectAtIndex:indexPath.row];
    [cell.lblCreatinine setText:[dataDictionary objectForKey:kCreatinine]];
    [cell.lblGFR setText:[dataDictionary objectForKey:kGFR]];
    cell.lblDate.text = [self getDateStringFromDate:[dataDictionary objectForKey:kDate]];
    [cell.btnDelete setTag:indexPath.row+1000];
    [cell.btnDelete addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


@end
