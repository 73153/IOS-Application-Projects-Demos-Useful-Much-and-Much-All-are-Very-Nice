//
//  FirstViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "FirstViewController.h"
#import "AppConstant.h"
#import "EditPersonalInfoViewController.h"
#import "DialysisViewController.h"
#import "GFRInfoViewController.h"
#import "BallonViewController.h"
#import "GraphViewController.h"
#import "PicturesViewController.h"
#import "BloodPressureViewController.h"
#import "LabViewController.h"
#import "MedicineViewController.h"
#import "GFRCalculatorViewController.h"
#import "GFRViewController.h"

@implementation FirstViewController
@synthesize tableview;
@synthesize Cell;
@synthesize ArrayData;
@synthesize btnSwitchToDialysis;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"tabHome.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tabHomeSelected.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fillArrayAndReloadTable{
    NSString *personalInfoImage;
    NSString *dialysisImage;
    NSString *ballonImage;
    NSString *graphImage;
    NSString *medicineImage;
    NSString *pictureImage;
    NSString *gfrInfoImage;
    NSString *labImage;
    NSString *gfrCalculatorImage;
    NSString *bloodPressureImage;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        personalInfoImage = @"presonal_information-icon.png";
        dialysisImage = @"bloodPressure.png";
        ballonImage = @"baloon_angi.png";
        graphImage = @"graph.png";
        medicineImage = @"add_medicine.png";
        pictureImage = @"picture.png";
        gfrInfoImage = @"gfrInfo.png";
        labImage = @"labicon.png";
        gfrCalculatorImage = @"gfrcalculatoricon.png";
        bloodPressureImage = @"bloodPressure.png";
    }
    else{
        personalInfoImage = @"presonalInfo_iPad.png";
        dialysisImage = @"bloodPressure_iPad.png";
        ballonImage = @"baloon_iPad.png";
        graphImage = @"graph_iPad.png";
        medicineImage = @"medicine_iPad.png";
        pictureImage = @"picture_iPad.png";
        gfrInfoImage = @"gfrInfo_iPad.png";
        labImage = @"lab_iPad.png";
        gfrCalculatorImage = @"calculator_iPad.png";
        bloodPressureImage = @"bloodPressure_iPad.png";
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsDialysis]){
        ArrayData=[[NSMutableArray alloc] initWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"Personal Information",@"title",personalInfoImage,@"image",@"Add/Edit your Personal information",@"text", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"Dialysis Reading",@"title",dialysisImage,@"image",@"Add/Edit your blood pressure and other reading",@"text", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"Balloon angioplasty",@"title",ballonImage,@"image",@"Add/Edit your Balloon angioplasty",@"text", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"Graph",@"title",graphImage,@"image",@"View different graph of reading taken",@"text", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"Add medicine",@"title",medicineImage,@"image",@"Add/Edit Medicine",@"text", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"Picture",@"title",pictureImage,@"image",@"Take / View picture",@"text", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"GFR Info",@"title",gfrInfoImage,@"image",@"View GFR info",@"text", nil], nil];
         [btnSwitchToDialysis setTitle:@"Switch To Non Dialysis" forState:UIControlStateNormal];
    }
    else
    {
        ArrayData=[[NSMutableArray alloc] initWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"Personal Information",@"title",personalInfoImage,@"image",@"Add/Edit your Personal information",@"text", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"Blood Pressure",@"title",bloodPressureImage,@"image",@"Add/Edit your Blood pressure reading",@"text", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"Graph",@"title",graphImage,@"image",@"View different graph of reading taken",@"text", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"Labs",@"title",ballonImage,@"image",@"Add/Edit your Labs reading",@"text", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"GFR Calculator",@"title",gfrCalculatorImage,@"image",@"Calculate GFR",@"text", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"Add medicine",@"title",medicineImage,@"image",@"Add/Edit Medicine",@"text", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"GFR Info",@"title",gfrInfoImage,@"image",@"View GFR info",@"text", nil], nil];
        [btnSwitchToDialysis setTitle:@"Switch To Dialysis" forState:UIControlStateNormal];
    }
    
    [tableview reloadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [self fillArrayAndReloadTable];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        return 70;
    }
    else{
        return 111;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ArrayData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    Cell =(InfoCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (Cell == nil){
        NSArray *topLevelObjects;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
           topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"InfoCell" owner:self options:nil];
        }
        else{
           topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"InfoCell_iPad" owner:self options:nil];
        }
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                Cell =  (InfoCell *) currentObject;
                break;
            }
        }
    }
    
    Cell.lbldescription.numberOfLines = 0;
    [Cell.lbldescription sizeToFit];
    Cell.IMGView.image=[UIImage imageNamed:[[ArrayData objectAtIndex:indexPath.row] valueForKey:@"image"]];
    Cell.lblTitle.text=[[ArrayData objectAtIndex:indexPath.row] valueForKey:@"title"];
    Cell.lbldescription.text=[[ArrayData objectAtIndex:indexPath.row] valueForKey:@"text"];
    
    Cell.btnNext.tag=indexPath.row;
    Cell.accessibilityValue=[[ArrayData objectAtIndex:indexPath.row] valueForKey:@"title"];
    [Cell.btnNext addTarget:self action:@selector(ButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    return Cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexPath];
    if ([cell.accessibilityValue isEqualToString:@"Personal Information"]){
        EditPersonalInfoViewController *editView;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            editView = [[EditPersonalInfoViewController alloc] initWithNibName:@"EditPersonalInfoViewController_iPhone" bundle:nil];
        }
        else{
            editView = [[EditPersonalInfoViewController alloc] initWithNibName:@"EditPersonalInfoViewController_iPad" bundle:nil];
        }
        editView.isFromPush = YES;
        [self.navigationController pushViewController:editView animated:YES];
    }
    else if ([cell.accessibilityValue isEqualToString:@"Dialysis Reading"]){
        DialysisViewController *dialysisView;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            dialysisView = [[DialysisViewController alloc] initWithNibName:@"DialysisViewController_iPhone" bundle:nil];
        }
        else{
            dialysisView = [[DialysisViewController alloc] initWithNibName:@"DialysisViewController_iPad" bundle:nil];
        }
        [self.navigationController pushViewController:dialysisView animated:YES];
    }
    else if ([cell.accessibilityValue isEqualToString:@"Balloon angioplasty"]){
        BallonViewController *ballonViewController;
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            ballonViewController = [[BallonViewController alloc] initWithNibName:@"BallonViewController_iPhone" bundle:nil];
        }
        else{
           ballonViewController = [[BallonViewController alloc] initWithNibName:@"BallonViewController_iPad" bundle:nil];
        }
        [self.navigationController pushViewController:ballonViewController animated:YES];
    }
    else if ([cell.accessibilityValue isEqualToString:@"Graph"]){
        GraphViewController *graphViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            graphViewController = [[GraphViewController alloc] initWithNibName:@"GraphViewController_iPhone" bundle:nil];
        }
        else{
            graphViewController = [[GraphViewController alloc] initWithNibName:@"GraphViewController_iPad" bundle:nil];
        }
        graphViewController.isFromPush = YES;
        [self.navigationController pushViewController:graphViewController animated:YES];
    }
    else if ([cell.accessibilityValue isEqualToString:@"Add medicine"]){
        MedicineViewController *medicineViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            medicineViewController = [[MedicineViewController alloc] initWithNibName:@"MedicineViewController_iPhone" bundle:nil];
        }
        else{
            medicineViewController = [[MedicineViewController alloc] initWithNibName:@"MedicineViewController_iPad" bundle:nil];
        }
        medicineViewController.isFromPush = YES;
        [self.navigationController pushViewController:medicineViewController animated:YES];
    }
    else if ([cell.accessibilityValue isEqualToString:@"Picture"]){
        PicturesViewController *picturesViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            picturesViewController = [[PicturesViewController alloc] initWithNibName:@"PicturesViewController_iPhone" bundle:nil];
        }
        else{
            picturesViewController = [[PicturesViewController alloc] initWithNibName:@"PicturesViewController_iPad" bundle:nil];
        }
        [self.navigationController pushViewController:picturesViewController animated:YES];
    }
    else if ([cell.accessibilityValue isEqualToString:@"Blood Pressure"]){
        BloodPressureViewController *bloodPressureViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            bloodPressureViewController = [[BloodPressureViewController alloc] initWithNibName:@"BloodPressureViewController_iPhone" bundle:nil];
        }
        else{
            bloodPressureViewController = [[BloodPressureViewController alloc] initWithNibName:@"BloodPressureViewController_iPad" bundle:nil];
        }
        [self.navigationController pushViewController:bloodPressureViewController animated:YES];
    }
    else if ([cell.accessibilityValue isEqualToString:@"Labs"]){
        LabViewController *labViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            labViewController = [[LabViewController alloc] initWithNibName:@"LabViewController_iPhone" bundle:nil];
        }
        else{
            labViewController = [[LabViewController alloc] initWithNibName:@"LabViewController_iPad" bundle:nil];
        }
        [self.navigationController pushViewController:labViewController animated:YES];
    }
    else if ([cell.accessibilityValue isEqualToString:@"GFR Calculator"]){
        GFRViewController *gfrViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            gfrViewController = [[GFRViewController alloc] initWithNibName:@"GFRViewController_iPhone" bundle:nil];
        }
        else{
            gfrViewController = [[GFRViewController alloc] initWithNibName:@"GFRViewController_iPad" bundle:nil];
        }
        [self.navigationController pushViewController:gfrViewController animated:YES];
    }
    else if ([cell.accessibilityValue isEqualToString:@"GFR Info"]){
        GFRInfoViewController *gfrInfoViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            gfrInfoViewController = [[GFRInfoViewController alloc] initWithNibName:@"GFRInfoViewController_iPhone" bundle:nil];
        }
        else{
            gfrInfoViewController = [[GFRInfoViewController alloc] initWithNibName:@"GFRInfoViewController_iPad" bundle:nil];
        }
        [self.navigationController pushViewController:gfrInfoViewController animated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1 && [alertView tag] == 10001){
        if([[NSUserDefaults standardUserDefaults] boolForKey:kIsDialysis]){
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsDialysis];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else{
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsDialysis];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [self fillArrayAndReloadTable];
    }
}
- (IBAction)dialysisNonDialysisButtonClicked:(id)sender{
    NSString *strMsg = @"";
    if([[NSUserDefaults standardUserDefaults] boolForKey:kIsDialysis]){
        strMsg = @"Are you sure you want to switch to Non-Dialysis?";
    }
    else{
        strMsg = @"Are you sure you want to switch to Dialysis?";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:strMsg delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES", nil];
    [alert setTag:10001];
    [alert show];
}
@end
