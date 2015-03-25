//
//  LeftMenuViewController.m
//  Holaout
//
//  Created by Amit Parmar on 06/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "ChatViewController.h"
#import "FirstViewCell.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "TermsOfServiceViewController.h"
#import "PrivacyPolicyViewController.h"
#import "SettingsViewController.h"
#import "AddFriendViewController.h"
#import "ContactViewController.h"
#import "FriendsViewController.h"
#import "DataManager.h"

@implementation LeftMenuViewController

@synthesize tblView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FirstViewCell *cell =(FirstViewCell*) [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if (cell == nil){
        NSArray *topLevelObjects;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FirstViewCell_iPhone" owner:self options:nil];
        }
        else{
            topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FirstViewCell_iPhone" owner:self options:nil];
        }
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (FirstViewCell *) currentObject;
                break;
            }
        }
    }
    switch (indexPath.row) {
        case 0:
            cell.imgView.image = [UIImage imageNamed:@"holaout.png"];
            cell.lblName.text = @"HOLA OUT CHAT";
            break;
        case 1:
            cell.imgView.image = [UIImage imageNamed:@"setting.png"];
            cell.lblName.text = @"SETTINGS";
            break;
        case 2:
            cell.imgView.image = [UIImage imageNamed:@"search.png"];
            cell.lblName.text = @"FIND AND\nADD FRIENDS";
            break;
        case 3:
            cell.imgView.image = [UIImage imageNamed:@"contact.png"];
            cell.lblName.text = @"CONTACTS";
            break;
        case 4:
            cell.imgView.image = [UIImage imageNamed:@"privacyPolicy.png"];
            cell.lblName.text = @"PRIVACY\nPOLICY";
            break;
        case 5:
            cell.imgView.image = [UIImage imageNamed:@"help.png"];
            cell.lblName.text = @"GET HELP";
            break;
        case 6:
            cell.imgView.image = [UIImage imageNamed:@"logout.png"];
            cell.lblName.text = @"LOGOUT";
            break;
        default:
            break;
    }
    [cell setSelectionStyle:UITableViewCellSeparatorStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}

-(void)sendMail{
   MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setSubject:@"Hola out support"];
    [mailComposer setToRecipients:[NSArray arrayWithObjects:@"support.holaout@gmail.com", nil]];
    [self presentViewController:mailComposer animated:YES completion:nil];
}
     
#pragma mark - mail compose delegate
-(void)mailComposeController:(MFMailComposeViewController *)controller
             didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (result) {
        NSLog(@"Result : %d",result);
    }
    if (error) {
        NSLog(@"Error : %@",error);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        NSLog(@"Closed");
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            [self leftSideMenuButtonPressed:nil];
        }
        break;
        case 1:{
            SettingsViewController *settingsViewController;
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
                settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPhone" bundle:nil];
            }
            else{
                 settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPad" bundle:nil];
            }
            [self presentViewController:settingsViewController animated:YES completion:nil];
        }
        break;
        case 2:{
            AddFriendViewController *addFriendViewController;
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
                addFriendViewController = [[AddFriendViewController alloc] initWithNibName:@"AddFriendViewController_iPhone" bundle:nil];
            }
            else{
               addFriendViewController = [[AddFriendViewController alloc] initWithNibName:@"AddFriendViewController_iPad" bundle:nil];
            }
            [self presentViewController:addFriendViewController animated:YES completion:nil];
        }
        break;
        case 3:{
            ContactViewController *contactViewController;
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
                contactViewController = [[ContactViewController alloc] initWithNibName:@"ContactViewController_iPhone" bundle:nil];
            }
            else{
                contactViewController = [[ContactViewController alloc] initWithNibName:@"ContactViewController_iPad" bundle:nil];
            }
            [self presentViewController:contactViewController animated:YES completion:nil];
        }
        break;
        case 4:{
            PrivacyPolicyViewController *privacyPolicyViewController;
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
                privacyPolicyViewController = [[PrivacyPolicyViewController alloc] initWithNibName:@"PrivacyPolicyViewController_iPhone" bundle:nil];
            }
            else{
                 privacyPolicyViewController = [[PrivacyPolicyViewController alloc] initWithNibName:@"PrivacyPolicyViewController_iPad" bundle:nil];
            }
            [self presentViewController:privacyPolicyViewController animated:YES completion:nil];
        }
        break;
        case 5:
            [self sendMail];
            break;
        case 6:
           [QBUsers logOutWithDelegate:self];
           [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kStoredData];
           [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kISLoggedIn];
           [[NSUserDefaults standardUserDefaults] synchronize];
            [[DataManager sharedDataManager] deleteAllContacts];
            break;
        default:
            break;
    }
}

-(void)completedWithResult:(Result*)result{
	if([result isKindOfClass:[QBUUserLogOutResult class]]){
		QBUUserLogOutResult *res = (QBUUserLogOutResult *)result;
		if(res.success){
            LoginViewController *loginViewController;
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
                loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPhone" bundle:nil];
            }
            else{
                loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPad" bundle:nil];
            }
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
            [navController setNavigationBarHidden:YES animated:NO];
            [[AppDelegate appdelegate].window setRootViewController:navController];
            [[AppDelegate appdelegate].window makeKeyAndVisible];
		}else{
            NSLog(@"errors=%@", result.errors);
		}
	}
}
@end
