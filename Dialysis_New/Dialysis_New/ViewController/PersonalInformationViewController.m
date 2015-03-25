//
//  PersonalInformationViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "AppConstant.h"
#import "DataManager.h"
#import "FirstViewController.h"

@interface PersonalInformationViewController ()

@end

@implementation PersonalInformationViewController
@synthesize  txtFieldName;
@synthesize  txtPhysicianName;
@synthesize  txtPhysicianPhone;
@synthesize  txtNephrologistName;
@synthesize  txtNephrologistPhone;
@synthesize  txtSurgenName;
@synthesize  txtSurgenPhone;
@synthesize  btnBack;
@synthesize  btnSave;
@synthesize scrollView;

@synthesize tabBarController;
@synthesize firstViewController;
@synthesize graphViewController;
@synthesize editViewController;
@synthesize medicineViewController;

@synthesize oldDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [txtFieldName setReturnKeyType:UIReturnKeyNext];
    [txtPhysicianName setReturnKeyType:UIReturnKeyNext];
    [txtPhysicianPhone setReturnKeyType:UIReturnKeyNext];
    [txtNephrologistName setReturnKeyType:UIReturnKeyNext];
    [txtNephrologistPhone setReturnKeyType:UIReturnKeyNext];
    [txtSurgenName setReturnKeyType:UIReturnKeyNext];
    [txtSurgenPhone setReturnKeyType:UIReturnKeyDone];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,530)];
    }
    
    if(oldDictionary){
        txtFieldName.text =[oldDictionary objectForKey:kName];
        txtPhysicianName.text = [oldDictionary objectForKey:kPhysicianName];
        txtPhysicianPhone.text = [oldDictionary objectForKey:kPhysicianPhone];
        txtNephrologistName.text = [oldDictionary objectForKey:kNephrologistName];
        txtNephrologistPhone.text = [oldDictionary objectForKey:kNephrologistPhone];
        txtSurgenName.text = [oldDictionary objectForKey:kSurgenName];
        txtSurgenPhone.text = [oldDictionary objectForKey:kSurgenPhone];
    }
    else{
        txtFieldName.text =@"";
        txtPhysicianName.text = @"";
        txtPhysicianPhone.text = @"";
        txtNephrologistName.text = @"";
        txtNephrologistPhone.text = @"";
        txtSurgenName.text = @"";
        txtSurgenPhone.text = @"";
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)addTabbarController{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.editViewController = [[EditPersonalInfoViewController alloc] initWithNibName:@"EditPersonalInfoViewController_iPhone" bundle:nil];
        self.firstViewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPhone" bundle:nil];
        self.medicineViewController = [[MedicineViewController alloc] initWithNibName:@"MedicineViewController_iPhone" bundle:nil];
        self.graphViewController = [[GraphViewController alloc] initWithNibName:@"GraphViewController_iPhone" bundle:nil];
    }
    else{
        self.editViewController = [[EditPersonalInfoViewController alloc] initWithNibName:@"EditPersonalInfoViewController_iPad" bundle:nil];
        self.firstViewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPad" bundle:nil];
        self.medicineViewController = [[MedicineViewController alloc] initWithNibName:@"MedicineViewController_iPad" bundle:nil];
        self.graphViewController = [[GraphViewController alloc] initWithNibName:@"GraphViewController_iPad" bundle:nil];
    }

    
    UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:self.editViewController];
    [navController1 setNavigationBarHidden:YES animated:NO];
    
    UINavigationController *navController2 = [[UINavigationController alloc] initWithRootViewController:self.firstViewController];
    [navController2 setNavigationBarHidden:YES animated:NO];
    
    UINavigationController *navController3 = [[UINavigationController alloc] initWithRootViewController:self.medicineViewController];
    [navController3 setNavigationBarHidden:YES animated:NO];
    
    UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:self.graphViewController];
    [navController4 setNavigationBarHidden:YES animated:NO];
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController1,navController2,navController3,navController4, nil];
    self.tabBarController.selectedIndex = 1;
    self.tabBarController.view.autoresizesSubviews = YES;
    self.tabBarController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if([[[UIDevice currentDevice] systemVersion] intValue] >= 7){
       [self.tabBarController.tabBar setBarTintColor:[UIColor colorWithRed:0.4863 green:0.0000 blue:0.0196 alpha:1.0]];
    }
}


- (IBAction)btnBackClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnSaveClicked:(id)sender{
    if(oldDictionary){
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:txtFieldName.text,kName,txtPhysicianName.text,kPhysicianName,txtPhysicianPhone.text,kPhysicianPhone,txtNephrologistName.text,kNephrologistName,txtNephrologistPhone.text,kNephrologistPhone,txtSurgenName.text,kSurgenName,txtSurgenPhone.text,kSurgenPhone, nil];
        [[DataManager sharedDataManager] updatepersonalInformation:dictionary forName:[oldDictionary objectForKey:kName]];
        oldDictionary = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:txtFieldName.text,kName,txtPhysicianName.text,kPhysicianName,txtPhysicianPhone.text,kPhysicianPhone,txtNephrologistName.text,kNephrologistName,txtNephrologistPhone.text,kNephrologistPhone,txtSurgenName.text,kSurgenName,txtSurgenPhone.text,kSurgenPhone, nil];
        [[DataManager sharedDataManager] insertPersonalInformation:dictionary];
        if(![[NSUserDefaults standardUserDefaults] boolForKey:kIsSelected]){
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsSelected];
            [[NSUserDefaults standardUserDefaults] synchronize];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Are you in dialysis?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes",@"No", nil];
            [alert show];
        }
        else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsDialysis];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self addTabbarController];
        [self.navigationController pushViewController:self.tabBarController animated:YES];
    }
    else if(buttonIndex == 1){
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsDialysis];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self addTabbarController];
        [self.navigationController pushViewController:self.tabBarController animated:YES];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == txtFieldName){
        [txtFieldName resignFirstResponder];
        [txtPhysicianName becomeFirstResponder];
    }
    else if(textField == txtPhysicianName){
        [txtPhysicianName resignFirstResponder];
        [txtPhysicianPhone becomeFirstResponder];
    }
    else if(textField == txtPhysicianPhone){
        [txtPhysicianPhone resignFirstResponder];
        [txtNephrologistName becomeFirstResponder];
    }
    else if(textField == txtNephrologistName){
        [txtNephrologistName resignFirstResponder];
        [txtNephrologistPhone becomeFirstResponder];
    }
    else if(textField == txtNephrologistPhone){
        [txtNephrologistPhone resignFirstResponder];
        [txtSurgenName becomeFirstResponder];
    }
    else if(textField == txtSurgenName){
        [txtSurgenName resignFirstResponder];
        [txtSurgenPhone becomeFirstResponder];
    }
    else if(textField == txtSurgenPhone){
        [txtSurgenPhone resignFirstResponder];
         [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,0,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == txtNephrologistPhone){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtNephrologistPhone.frame.origin.y,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtSurgenName){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtSurgenName.frame.origin.y+30,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    else if(textField == txtSurgenPhone){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,txtSurgenPhone.frame.origin.y+30,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    }
    return YES;
}

@end
