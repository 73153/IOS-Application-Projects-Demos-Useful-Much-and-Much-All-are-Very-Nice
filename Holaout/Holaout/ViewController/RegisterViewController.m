//
//  RegisterViewController.m
//  Holaout
//
//  Created by Amit Parmar on 05/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "RegisterViewController.h"
#import "LeftMenuViewController.h"
#import "FriendsViewController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"

@implementation RegisterViewController

@synthesize txtFieldUserName;
@synthesize txtFieldEmail;
@synthesize txtFieldPassword;
@synthesize txtFieldReEnterPassword;
@synthesize btnRegister;
@synthesize activityIndicator;
@synthesize txtPhone;
@synthesize btnChoose;
@synthesize userID;
@synthesize choosenImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [txtFieldUserName setReturnKeyType:UIReturnKeyNext];
    [txtFieldEmail setReturnKeyType:UIReturnKeyNext];
    [txtFieldPassword setReturnKeyType:UIReturnKeyNext];
    [txtFieldReEnterPassword setReturnKeyType:UIReturnKeyNext];
    [txtPhone setReturnKeyType:UIReturnKeyDone];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)btnRegisterClicked:(id)sender{
    if([txtFieldUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kAppTitle message:kEnterUserName delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if([txtFieldEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kAppTitle message:kEnterEmail delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if([txtFieldPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kAppTitle message:kEnterPassword delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if([txtFieldReEnterPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kAppTitle message:kReEnterPassword delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if(![txtFieldPassword.text isEqualToString:txtFieldReEnterPassword.text]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kAppTitle message:kPasswordNotMatch delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if([txtPhone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kAppTitle message:kEnterPhone delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        [activityIndicator startAnimating];
        QBUUser *user = [QBUUser user];
        user.login = txtFieldUserName.text;
        user.password = txtFieldPassword.text;
        user.email = txtFieldEmail.text;
        user.phone = txtPhone.text;
        [QBUsers signUp:user delegate:self];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == txtFieldPassword && [UIScreen mainScreen].bounds.size.height == 480){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [self.view setFrame:CGRectMake(self.view.frame.origin.x,-50, self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
    }
    else if(textField == txtFieldReEnterPassword && [UIScreen mainScreen].bounds.size.height == 480){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [self.view setFrame:CGRectMake(self.view.frame.origin.x,-100, self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
    }
    if(textField == txtPhone && [UIScreen mainScreen].bounds.size.height == 480){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [self.view setFrame:CGRectMake(self.view.frame.origin.x,-150, self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == txtFieldUserName){
        [txtFieldUserName resignFirstResponder];
        [txtFieldEmail becomeFirstResponder];
    }
    else if(textField == txtFieldEmail){
        [txtFieldEmail resignFirstResponder];
        [txtFieldPassword becomeFirstResponder];
    }
    else if(textField == txtFieldPassword){
        [txtFieldPassword resignFirstResponder];
        [txtFieldReEnterPassword becomeFirstResponder];
    }
    else if(textField == txtFieldReEnterPassword){
        [txtFieldReEnterPassword resignFirstResponder];
        [txtPhone becomeFirstResponder];
    }
    else if(textField == txtPhone){
        if([UIScreen mainScreen].bounds.size.height == 480){
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [self.view setFrame:CGRectMake(self.view.frame.origin.x,0, self.view.frame.size.width, self.view.frame.size.height)];
            [UIView commitAnimations];
        }
        [txtPhone resignFirstResponder];
    }
    return true;
}

- (void)completedWithResult:(Result *)result{
    [activityIndicator stopAnimating];
     if(result.success && [result isKindOfClass:QBUUserLogInResult.class]){
        QBUUserLogInResult *loginResult = (QBUUserLogInResult *)result;
        QBUUser *user = loginResult.user;
        NSString *fullName = user.fullName;
        NSString *email = user.email;
        NSString *username = user.login;
        NSString *phone = user.phone;
        NSString *website = user.website;
        user.password = txtFieldPassword.text;
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
         if(choosenImage){
             NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
             NSError *error = nil;
             if (![[NSFileManager defaultManager] fileExistsAtPath:stringPath])
                 [[NSFileManager defaultManager] createDirectoryAtPath:stringPath withIntermediateDirectories:NO attributes:nil error:&error];
             
             NSString *fileName = [stringPath stringByAppendingFormat:@"/profile.png"];
             NSData *data = UIImagePNGRepresentation(choosenImage);
             [data writeToFile:fileName atomically:YES];
             [QBContent TUploadFile:UIImagePNGRepresentation(choosenImage) fileName:@"image.png" contentType:@"image/png" isPublic:YES delegate:[AppDelegate appdelegate]];
         }
        [LocalStorageService shared].currentUser = user;
        NSString *userId = [NSString stringWithFormat:@"%d",user.ID];
        [AppDelegate appdelegate].userID = user.ID;
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
    else if(result.success && [result isKindOfClass:QBUUserResult.class]){
        [QBUsers logInWithUserLogin:txtFieldUserName.text password:txtFieldPassword.text  delegate:self];
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    choosenImage = info[UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnChooseClicked:(id)sender{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
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
