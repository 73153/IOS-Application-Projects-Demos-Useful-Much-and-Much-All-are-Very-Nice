//
//  AddFriendViewController.m
//  Holaout
//
//  Created by Amit Parmar on 09/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "AddFriendViewController.h"
#import "InvitationViewController.h"
#import "ContactPickerViewController.h"
#import "DataManager.h"

@implementation AddFriendViewController
@synthesize searchBar;
@synthesize btnContactList;
@synthesize btnFacebook;
@synthesize btnByEmail;
@synthesize btnSyncAddressBook;
@synthesize btnSyncFacebook;
@synthesize friendPickerController;
@synthesize activityIndicator;
@synthesize contactArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if (granted) {
        }
    });
}


- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.activityIndicator startAnimating];
    [self performSelector:@selector(getPersonOutOfAddressBook) withObject:nil afterDelay:0.5];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)getPersonOutOfAddressBook{
    @try {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        CFErrorRef error = NULL;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
        if (addressBook != nil) {
            NSArray *allContacts = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
            NSUInteger i = 0; for (i = 0; i < [allContacts count]; i++){
                ABRecordRef contactPerson = (__bridge ABRecordRef)allContacts[i];
                NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(contactPerson,kABPersonFirstNameProperty);
                NSString *lastName = (__bridge_transfer NSString *)ABRecordCopyValue(contactPerson, kABPersonLastNameProperty);
                NSString *fullName;
                if(lastName){
                    fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
                }
                else{
                    fullName = firstName;
                }
                ABMultiValueRef multiPhones = ABRecordCopyValue(contactPerson,kABPersonPhoneProperty);
                CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(multiPhones, 0);
                NSString *phoneNumber = (__bridge_transfer NSString *) phoneNumberRef;
                ABMultiValueRef emails = ABRecordCopyValue(contactPerson, kABPersonEmailProperty);
                NSString *emailAddress;
                NSUInteger j = 0;
                for (j = 0; j < ABMultiValueGetCount(emails); j++) {
                    NSString *email = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(emails, j);
                    if (j == 0) {
                        emailAddress = email;
                    }
                }
                NSData *imageData = (__bridge NSData*)ABPersonCopyImageDataWithFormat(contactPerson, kABPersonImageFormatThumbnail);
                NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:fullName,kPersonName,emailAddress,kPersonEmail,phoneNumber,kPersonPhone, imageData,kPersonImage,nil];
                [tempArray addObject:dictionary];
            }
            CFRelease(addressBook);
        } else {
            NSLog(@"Error reading Address Book");
            
        }
        contactArray = tempArray;
        [self.activityIndicator stopAnimating];
    }
    @catch (NSException *exception) {
        [self.activityIndicator stopAnimating];
    }
    
}

- (IBAction)btnContactListClicked:(id)sender{
    if(!contactArray){
        [self performSelector:@selector(getPersonOutOfAddressBook) withObject:nil afterDelay:0.5];
    }
    ContactPickerViewController *contactPicker;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        contactPicker = [[ContactPickerViewController alloc] initWithNibName:@"ContactPickerViewController_iPhone" bundle:nil];
    }
    else{
       contactPicker = [[ContactPickerViewController alloc] initWithNibName:@"ContactPickerViewController_iPad" bundle:nil];
    }
    contactPicker.contactArray = contactArray;
    [self presentViewController:contactPicker animated:YES completion:nil];
}

-(void)sendMail{
    NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredData];
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setSubject:@"would like to invite you to join Hola out!"];
    [mailComposer setMessageBody:[NSString stringWithFormat:@"hey,\nI just downloaded Hola out on my phone.Its an app that lets you decide how long the message you send exist before disappearing forever.\nYou can chat off the record, so no trace of a conversation is left behind;send self-destructing photos and videos,and take back the messages you already sent with synced deletion. In other words,we can finally chat without worrying about other people seeing what we say!\nHola out is available for iPhone and Android. Download it now, then add me with username %@.\nChat Soon!",[dictionary objectForKey:kUserName]] isHTML:NO];
    [self presentViewController:mailComposer animated:YES completion:nil];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (result) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Invitation sent successfully" delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
        [alert show];
    }
    if (error) {
        NSLog(@"Error : %@",error);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnFacebookClicked:(id)sender{
    NSString *fbidSelection;
    if (FBSession.activeSession.isOpen) {
        NSDictionary *parameters = fbidSelection ? @{@"to":fbidSelection} : nil;
        [FBWebDialogs presentRequestsDialogModallyWithSession:nil
                                                      message:@"I just downloaded Hola out on my phone.Its an app that lets you decide how long the message you send exist before disappearing forever.Download it now, then add me with username %@.\nChat Soon!"
                                                        title:@"I would like to invite you to join Hola out!"
                                                   parameters:parameters
                                                      handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                          if (result == FBWebDialogResultDialogCompleted) {
                                                              NSLog(@"Web dialog complete: %@", resultURL);
                                                          } else {
                                                              NSLog(@"Web dialog not complete, error: %@", error.description);
                                                          }
                                                      }
                                                  friendCache:nil];
    }
}

- (void)facebookViewControllerDoneWasPressed:(id)sender {
    // we pick up the users from the selection, and create a string that we use to update the text view
    // at the bottom of the display; note that self.selection is a property inherited from our base class
    for (id<FBGraphUser> user in self.friendPickerController.selection) {
        NSLog(@"%@",user.id);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)facebookViewControllerCancelWasPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnEmailClicked:(id)sender{
    [self sendMail];
}

- (void) insertContactToDB{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"0",kContactIsHolaout,nil];
    [QBCustomObjects objectsWithClassName:KCustomClassName extendedRequest:(NSMutableDictionary *)dictionary delegate:self];
    NSArray *dataArray =  contactArray;
    for(int i=0;i<[dataArray count];i++){
        NSDictionary *dataDictionary = [dataArray objectAtIndex:i];
        NSString *strPhoneNumber = [dataDictionary objectForKey:kPersonPhone];
        NSString *strPersonEmail = [dataDictionary objectForKey:kPersonEmail];
        if(!strPhoneNumber)
            strPhoneNumber = @"";
        if(!strPersonEmail)
            strPersonEmail = @"";
        NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
        [mutableDictionary setObject:[dataDictionary objectForKey:kPersonName] forKey:kContactName];
        [mutableDictionary setObject:strPhoneNumber forKey:KContactPhone];
        [mutableDictionary setObject:strPersonEmail forKey:kContactEmail];
        [mutableDictionary setObject:@"0" forKey:kContactIsHolaout];
        [mutableDictionary setObject:@"" forKey:kContactHolaoutId];
        if([dataDictionary objectForKey:kPersonImage])
            [mutableDictionary setObject:[dataDictionary objectForKey:kPersonImage] forKey:kContactImage];
        [[DataManager sharedDataManager] insertContactsData:mutableDictionary];
    }
    [activityIndicator stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Contact Sync Successfully" delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
    [alert show];
}
- (IBAction)btnSyncAddressBookClicked:(id)sender{
    [activityIndicator startAnimating];
        if(!contactArray){
            [self performSelector:@selector(getPersonOutOfAddressBook) withObject:nil afterDelay:0.5];
        }
        [self performSelector:@selector(insertContactToDB) withObject:nil afterDelay:0.5];
}
- (IBAction)btnSyncFacebookClicked:(id)sender{
    if (!FBSession.activeSession.isOpen) {
        [FBSession openActiveSessionWithAllowLoginUI: YES];
    }
    
//    NSString *message = @"Test Request";
//    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:message, @"message",nil];
//    [FBRequestConnection startWithGraphPath:@"100001341904951/feed" parameters:params HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//        if (!error){
//            NSLog(@"array=%@",[result data]);
//        } else {
//        }
//    }];
    
//    NSMutableDictionary *params =
//    [NSMutableDictionary dictionaryWithObjectsAndKeys:
//     @"An example parameter", @"message",@"100001341904951",@"to",
//     nil];
//    
//    [FBWebDialogs presentFeedDialogModallyWithSession:nil
//                                           parameters:params
//                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {}
//     ];
//    [FBRequestConnection startWithGraphPath:@"/me/friends?fields=picture,id,name,link,gender,last_name,first_name"
//                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//                              if (!error){
//                                  NSLog(@"array=%@",[result data]);
//                              } else {
//                              }
//                          }];
}

- (void)completedWithResult:(Result *)result{
    // Get User result
    [activityIndicator stopAnimating];
    if(result.success && [result isKindOfClass:QBCOCustomObjectPagedResult.class]){
        QBCOCustomObjectPagedResult *getObjectsResult = (QBCOCustomObjectPagedResult *)result;
        NSLog(@"Objects: %@, count: %d", getObjectsResult.objects, getObjectsResult.count);
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(int i=0;i<[getObjectsResult.objects count];i++){
            QBCOCustomObject *objectDict = [getObjectsResult.objects objectAtIndex:i];
            NSString *ID = objectDict.ID;
            [array addObject:ID];
        }
        [[DataManager sharedDataManager] deleteotherContacts:array];
    } else if(result.success && [result isKindOfClass:[QBUUserResult class]]){
        QBUUserResult *userResult = (QBUUserResult *)result;
        if([userResult.errors count] == 0){
            NSLog(@"user=%@",userResult.user);
            InvitationViewController *invitationViewController;
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
                invitationViewController = [[InvitationViewController alloc] initWithNibName:@"InvitationViewController_iPhone" bundle:nil];
            }
            else{
                invitationViewController = [[InvitationViewController alloc] initWithNibName:@"InvitationViewController_iPad" bundle:nil];
            }
            invitationViewController.user = userResult.user;
            [self presentViewController:invitationViewController animated:YES completion:nil];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Contact not found" delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Contact not found" delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *searchBarText = searchBar.text;
    NSString *word = @"@";
    [activityIndicator startAnimating];
    if ([searchBarText rangeOfString:word].location != NSNotFound) {
        [QBUsers userWithEmail:searchBarText delegate:self];
    }
    else{
        [QBUsers userWithLogin:searchBarText delegate:self];
    }
    [searchBar resignFirstResponder];
}

- (IBAction)backButtonClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
