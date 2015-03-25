//
//  EditPersonalInfoViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "EditPersonalInfoViewController.h"
#import "PersonalInformationViewController.h"
#import "DataManager.h"
#import "PersonalInformationCell.h"
#import "AppConstant.h"

@implementation EditPersonalInfoViewController

@synthesize btnBack;
@synthesize btnAdd;
@synthesize tableView;
@synthesize arrayOfInformation;
@synthesize isFromPush;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"tabInfo.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tabInfoSelected.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) getDataAndReloadTable{
    arrayOfInformation = [[DataManager sharedDataManager] getPersonalInformation];
    [self.tableView reloadData];
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDataAndReloadTable];
    if(isFromPush){
        [self.btnBack setHidden:NO];
    }
    else{
        [self.btnBack setHidden:YES];
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
- (IBAction)btnAddClicked:(id)sender{
    PersonalInformationViewController *personalInfoViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        personalInfoViewController = [[PersonalInformationViewController alloc] initWithNibName:@"PersonalInformationViewController_iPhone" bundle:nil];
    }
    else{
       personalInfoViewController = [[PersonalInformationViewController alloc] initWithNibName:@"PersonalInformationViewController_iPad" bundle:nil]; 
    }
    [self.navigationController pushViewController:personalInfoViewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayOfInformation count];
}


- (void) physicianPhoneClicked:(id)sender{
    int index = [sender tag] - 1000;
    NSDictionary *dataDictionary = [arrayOfInformation objectAtIndex:index];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[dataDictionary objectForKey:kPhysicianPhone]]]];
}

- (void) nephrologistPhoneClicked:(id)sender{
    int index = [sender tag] - 1000;
    NSDictionary *dataDictionary = [arrayOfInformation objectAtIndex:index];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[dataDictionary objectForKey:kNephrologistPhone]]]];
}

- (void) surgeonPhoneClicked:(id)sender{
    int index = [sender tag] - 1000;
    NSDictionary *dataDictionary = [arrayOfInformation objectAtIndex:index];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[dataDictionary objectForKey:kSurgenPhone]]]];
}

- (void) editButtonClicked:(id)sender{
    int index = [sender tag] - 1000;
    NSDictionary *dataDictionary = [arrayOfInformation objectAtIndex:index];
    PersonalInformationViewController *personalInfoViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        personalInfoViewController = [[PersonalInformationViewController alloc] initWithNibName:@"PersonalInformationViewController_iPhone" bundle:nil];
    }
    else{
        personalInfoViewController = [[PersonalInformationViewController alloc] initWithNibName:@"PersonalInformationViewController_iPad" bundle:nil];
    }
    personalInfoViewController.oldDictionary = dataDictionary;
    [self.navigationController pushViewController:personalInfoViewController animated:YES];
    
}

- (void) deleteButtonClicked:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Are you sure you want to delete this record?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES", nil];
    [alert setTag:[sender tag]];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        int index = [alertView tag] - 1000;
        NSDictionary *dataDictionary = [arrayOfInformation objectAtIndex:index];
        NSString *strName = [dataDictionary objectForKey:kName];
        if([[DataManager sharedDataManager] deletepersonalInformationforRowId:strName]){
            [self getDataAndReloadTable];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 235;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalInformationCell *cell =(PersonalInformationCell*) [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if (cell == nil){
        NSArray *topLevelObjects;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
           topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PersonalInformationCell" owner:self options:nil];
        }
        else{
           topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PersonalInformationCell_iPad" owner:self options:nil];
        }
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (PersonalInformationCell *) currentObject;
                break;
            }
        }
    }
    
    NSDictionary *dict = [arrayOfInformation objectAtIndex:indexPath.row];
    cell.lblName.text = [dict objectForKey:kName];
    cell.lblPhysicianName.text = [dict objectForKey:kPhysicianName];
    cell.lblPhysicianPhone.text = [dict objectForKey:kPhysicianPhone];
    cell.lblNephrologistName.text = [dict objectForKey:kNephrologistName];
    cell.lblNephrologistPhone.text = [dict objectForKey:kNephrologistPhone];
    cell.lblSurgeonName.text = [dict objectForKey:kSurgenName];
    cell.lblSurgeonPhone.text = [dict objectForKey:kSurgenPhone];
    
    [cell.btnPhone1 setTag:indexPath.row+1000];
    [cell.btnPhone2 setTag:indexPath.row+1000];
    [cell.btnPhone3 setTag:indexPath.row+1000];
    [cell.btnEdit setTag:indexPath.row+1000];
    [cell.btnDelete setTag:indexPath.row+1000];
    
    
    [cell.btnPhone1 addTarget:self action:@selector(physicianPhoneClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnPhone2 addTarget:self action:@selector(nephrologistPhoneClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnPhone3 addTarget:self action:@selector(surgeonPhoneClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnEdit addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnDelete addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

@end
