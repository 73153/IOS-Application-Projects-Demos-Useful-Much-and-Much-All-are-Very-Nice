//
//  MedicineViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 29/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "MedicineViewController.h"
#import "AddMedicineViewController.h"
#import "AppConstant.h"
#import "MedicineCell.h"

@implementation MedicineViewController

@synthesize btnBack;
@synthesize btnAdd;
@synthesize tblView;
@synthesize medicineReadingArray;
@synthesize isFromPush;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"tabMedicine.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tabMedicineSelected.png"];
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
    medicineReadingArray = [[DataManager sharedDataManager] getMedicineData];
    if([medicineReadingArray count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"No Data Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    [self.tblView reloadData];
    if(isFromPush){
        [self.btnBack setHidden:NO];
    }
    else{
        [self.btnBack setHidden:YES];
    }
}

- (IBAction)backButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addButtonClicked:(id)sender{
    AddMedicineViewController *addMedicineViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        addMedicineViewController = [[AddMedicineViewController alloc] initWithNibName:@"AddMedicineViewController_iPhone" bundle:nil];
    }
    else{
        addMedicineViewController = [[AddMedicineViewController alloc] initWithNibName:@"AddMedicineViewController_iPad" bundle:nil];
    }
    [self.navigationController pushViewController:addMedicineViewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [medicineReadingArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *medicineArray = [[[medicineReadingArray objectAtIndex:[indexPath row]] objectForKey:kMedicine1] componentsSeparatedByString:@","];
    int count  = [medicineArray count] - 5;
    return 289 + count*31+10;
}
- (void) editButtonClicked:(id)sender{
    int index = [sender tag] - 1000;
    NSDictionary *dataDictionary = [medicineReadingArray objectAtIndex:index];
    AddMedicineViewController *addDialysisViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        addDialysisViewController = [[AddMedicineViewController alloc] initWithNibName:@"AddMedicineViewController_iPhone" bundle:nil];
    }
    else{
        addDialysisViewController = [[AddMedicineViewController alloc] initWithNibName:@"AddMedicineViewController_iPad" bundle:nil];
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
        NSDictionary *dataDictionary = [medicineReadingArray objectAtIndex:index];
        int rowId = [[dataDictionary objectForKey:kRowId] intValue];
        if([[DataManager sharedDataManager] deleteMedicineDataForRowId:rowId]){
            medicineReadingArray = [[DataManager sharedDataManager] getMedicineData];
            [self.tblView reloadData];
        }
    }
}

- (void) buttonPhone1Clicked:(id)sender{
    int index = [sender tag] - 1000;
    NSDictionary *dataDictionary = [medicineReadingArray objectAtIndex:index];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[dataDictionary objectForKey:kFirstContactNO]]]];
}

- (void) buttonPhone2Clicked:(id)sender{
    int index = [sender tag] - 1000;
    NSDictionary *dataDictionary = [medicineReadingArray objectAtIndex:index];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[dataDictionary objectForKey:kSecondContactNo]]]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MedicineCell *cell =(MedicineCell*) [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if (cell == nil){
        NSArray *topLevelObjects;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
           topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MedicineCell" owner:self options:nil];
        }
        else{
           topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MedicineCell_iPad" owner:self options:nil];
        }
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (MedicineCell *) currentObject;
                break;
            }
        }
    }
    NSDictionary *dataDictionary = [medicineReadingArray objectAtIndex:indexPath.row];
    cell.lblPharmacyName.text = [dataDictionary objectForKey:kPharmacyName];
    cell.lblLocation.text = [dataDictionary objectForKey:kLocation];
    cell.lblContactOne.text = [dataDictionary objectForKey:kFirstContactNO];
    cell.lblContactTwo.text = [dataDictionary objectForKey:kSecondContactNo];
    
    NSArray *array = [[dataDictionary objectForKey:kMedicine1] componentsSeparatedByString:@","];
    cell.lblMedicine1.text = [array objectAtIndex:0];
    cell.lblMedicine2.text = [array objectAtIndex:1];
    cell.lblMedicine3.text = [array objectAtIndex:2];
    cell.lblMedicine4.text = [array objectAtIndex:3];
    cell.lblMedicine5.text = [array objectAtIndex:4];
    
    int y=285;
    for(int i=5;i<[array count];i++){
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, y,768,1)];
        [imgView setBackgroundColor:[UIColor blackColor]];
        [cell addSubview:imgView];
        y = y + 5;
        UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(9,y,138, 21)];
        [lbl1 setBackgroundColor:[UIColor clearColor]];
        [lbl1 setText:[NSString stringWithFormat:@"Medicine %d:",i+1]];
        [lbl1 setTextColor:[UIColor colorWithRed:160.0/255.0 green:10.0/255.0 blue:0.0 alpha:1.0]];
        [lbl1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.0]];
        [cell addSubview:lbl1];
        
        UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(162,y,138,21)];
        [lbl2 setBackgroundColor:[UIColor clearColor]];
        [lbl2 setText:[array objectAtIndex:i]];
        [lbl2 setTextColor:[UIColor blackColor]];
        [lbl2 setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
        [cell addSubview:lbl2];
        y = y + 5 + 21;
    }
    
    [cell.btnEdit setTag:indexPath.row+1000];
    [cell.btnDelete setTag:indexPath.row+1000];
    [cell.btnPhone1 setTag:indexPath.row+1000];
    [cell.btnPhone2 setTag:indexPath.row+1000];
    [cell.btnEdit addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnDelete addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnPhone1 addTarget:self action:@selector(buttonPhone1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnPhone2 addTarget:self action:@selector(buttonPhone2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


@end
