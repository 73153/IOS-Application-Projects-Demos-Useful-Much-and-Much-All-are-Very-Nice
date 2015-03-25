//
//  LoginViewController.m
//  Holaout
//
//  Created by Amit Parmar on 05/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "LoginViewController.h"
#import "FriendsViewController.h"
#import "LeftMenuViewController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"


@implementation LoginViewController


@synthesize txtUserName;
@synthesize txtPassword;
@synthesize btnLogin;
@synthesize btnForgotPassword;
@synthesize activityIndicator;
@synthesize locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [txtUserName setReturnKeyType:UIReturnKeyNext];
    [txtPassword setReturnKeyType:UIReturnKeyDone];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)getAddressFromCurruntLocation:(CLLocation *)location{
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
         {
             if(placemarks && placemarks.count > 0)
             {
                 CLPlacemark *placemark= [placemarks objectAtIndex:0];
                 NSArray *array = [placemark.addressDictionary valueForKey:@"FormattedAddressLines"];
                 NSArray *finalArray;
                 if([array count] >= 3){
                     finalArray = [NSArray arrayWithObjects:[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2], nil];
                 }
                 NSString *locatedAt = [finalArray objectAtIndex:0];
                 if(locatedAt == nil) {
                     locatedAt = @"Unknown";
                 }
                 QBLGeoData *geodata = [QBLGeoData geoData];
                 geodata.latitude = location.coordinate.latitude;
                 geodata.longitude = location.coordinate.longitude;
                 geodata.status = locatedAt;
                 [QBLocation createGeoData:geodata delegate:self];
             }
         }];
}


- (void) checkinUserLocation{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    //CLLocation *location = [locationManager location];
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self getAddressFromCurruntLocation:newLocation];
    [locationManager stopUpdatingLocation];
}
- (IBAction)btnLoginClicked:(id)sender{
    if([txtUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kAppTitle message:kEnterUserName delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if([txtUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kAppTitle message:kEnterPassword delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        [activityIndicator startAnimating];
       [QBUsers logInWithUserLogin:txtUserName.text password:txtPassword.text  delegate:self];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([alertView tag] == 10001 && buttonIndex == 0){
        [QBUsers resetUserPasswordWithEmail:[alertView textFieldAtIndex:0].text delegate:self];
    }
}
- (IBAction)btnForgotPasswordClicked:(id)sender{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Enter your Email Address" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",@"Cancel", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView setTag:10001];
    [alertView show];
}

- (void)completedWithResult:(Result *)result{
    [activityIndicator stopAnimating];
    if(result.success && [result isKindOfClass:QBLGeoDataResult.class]){
        NSLog(@"Checkin Done");
    }
    else if(result.success && [result isKindOfClass:QBUUserLogInResult.class]){
        QBUUserLogInResult *loginResult = (QBUUserLogInResult *)result;
        [self checkinUserLocation];
        QBUUser *user = loginResult.user;
        NSString *fullName = user.fullName;
        NSString *email = user.email;
        NSString *username = user.login;
        NSString *phone = user.phone;
        NSString *website = user.website;
        user.password = txtPassword.text;
        int blobId = user.blobID;
        
        if(!fullName){
            fullName = @"";
        }
        if(!email){
            email = @"";
        }
        if(!username){
            username = @"";
        }
        if(!phone){
            phone = @"";
        }
        if(!website){
            website = @"";
        }
        [QBMessages TRegisterSubscriptionWithDelegate:self];
        [[ChatService instance] loginWithUser:user completionBlock:nil];
        [LocalStorageService shared].currentUser = user;
        NSString *userId = [NSString stringWithFormat:@"%d",user.ID];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:userId,kUserId,fullName,kFullName,email,kEmail,username,kUserName,phone,kPhone,website,kWebSite,user.password,kPassword,[NSString stringWithFormat:@"%d",blobId],kUserBlobId, nil];
        [[NSUserDefaults standardUserDefaults] setObject:dictionary forKey:kStoredData];
        [[NSUserDefaults standardUserDefaults] synchronize];
        LeftMenuViewController *leftMenu;
        FriendsViewController *friendsViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            leftMenu = [[LeftMenuViewController alloc] initWithNibName:@"LeftMenuViewController_iPhone" bundle:nil];
            friendsViewController = [[FriendsViewController alloc] initWithNibName:@"FriendsViewController_iPhone" bundle:nil];
        }
        else{
            leftMenu = [[LeftMenuViewController alloc] initWithNibName:@"LeftMenuViewController_iPad" bundle:nil];
            friendsViewController = [[FriendsViewController alloc] initWithNibName:@"FriendsViewController_iPad" bundle:nil];
        }
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kISLoggedIn];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:friendsViewController];
        UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:leftMenu];
        [navController1 setNavigationBarHidden:YES animated:YES];
        MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                        containerWithCenterViewController:navController
                                                        leftMenuViewController:navController1
                                                        rightMenuViewController:nil];
        [AppDelegate appdelegate].window.rootViewController = container;
        [[AppDelegate appdelegate].window makeKeyAndVisible];
    }
    else if(result.success && [result isKindOfClass:Result.class]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please check your email to reset password" delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        NSString *strError = [[result errors] objectAtIndex:0];
        if([strError isEqualToString:kUnauthorized]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:kWrongUserNamePassword delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:strError delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == txtUserName){
        [txtUserName resignFirstResponder];
        [txtPassword becomeFirstResponder];
    }
    else{
        [txtPassword resignFirstResponder];
    }
    return true;
}

- (IBAction)backButtonClicked:(id)sender{
    BOOL isPresent=NO;
    UIViewController *controller;
    for (controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[HomeViewController class]]){
            isPresent=YES;
            break;
        }
    }
    
    if(isPresent){
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        HomeViewController *homeViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController_iPhone" bundle:nil];
        }
        else{
             homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController_iPad" bundle:nil];
        }
        [self.navigationController pushViewController:homeViewController animated:YES];
    }
}

@end
