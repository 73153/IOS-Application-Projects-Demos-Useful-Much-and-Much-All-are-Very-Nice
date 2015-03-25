//
//  ContactViewController.m
//  Holaout
//
//  Created by Amit Parmar on 10/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "ContactViewController.h"
#import "DataManager.h"
#import "MessageViewController.h"

@implementation ContactViewController
@synthesize searchBar;
@synthesize tblView;
@synthesize friendsOnHolaOut;
@synthesize otherFriends;
@synthesize imagesArray;
@synthesize containerLayer;
@synthesize searchedHolaoutFriend;
@synthesize searchedOtherFriend;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [DataManager sharedDataManager].contactDelegate = self;
    NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredData];
    NSString *userId = [dictionary objectForKey:kUserId];
    [[DataManager sharedDataManager] getHolaoutContactsData:userId];
}

-(void)returnContactArray:(NSArray *)dataArray{
    NSLog(@"%@",dataArray);
    NSMutableArray *holaoutArray  = [[NSMutableArray alloc] init];
    NSMutableArray *otherArray = [[NSMutableArray alloc] init];
    for(int i=0;i<[dataArray count];i++){
        if([[[dataArray objectAtIndex:i] objectForKey:kISBlocked] intValue] != 1){
            if([[[dataArray objectAtIndex:i] objectForKey:kContactIsHolaout] intValue] == 1){
                [holaoutArray addObject:[dataArray objectAtIndex:i]];
            }
            else{
                [otherArray addObject:[dataArray objectAtIndex:i]];
            }
        }
    }
    friendsOnHolaOut = holaoutArray;
    otherFriends = otherArray;
    searchedHolaoutFriend = friendsOnHolaOut;
    searchedOtherFriend = otherFriends;
    [self.tblView reloadData];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    imagesArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonClicked:(id)sender{
        [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if([searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0){
        NSPredicate *preda = [NSPredicate predicateWithFormat:
                              [NSString stringWithFormat:@"%@ contains[c] '%@'",kContactName,searchBar.text]];
        searchedHolaoutFriend  = [friendsOnHolaOut filteredArrayUsingPredicate:preda];
        searchedOtherFriend = [otherFriends filteredArrayUsingPredicate:preda];
    }
    else{
        searchedHolaoutFriend = friendsOnHolaOut;
        searchedOtherFriend = otherFriends;
    }
    [self.tblView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,30)];
        [backView setBackgroundColor:[UIColor colorWithRed:5.0/255.0 green:149.0/255.0 blue:212.0/255.0 alpha:1.0]];
        UILabel *lblText = [[UILabel alloc] initWithFrame:CGRectMake(20,5, 200, 20)];
        [lblText setText:@"Hola out Friends"];
        [lblText setBackgroundColor:[UIColor clearColor]];
        [lblText setTextColor:[UIColor whiteColor]];
        [backView addSubview:lblText];
        return backView;
    }
    else{
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,30)];
        [backView setBackgroundColor:[UIColor colorWithRed:5.0/255.0 green:149.0/255.0 blue:212.0/255.0 alpha:1.0]];
        UILabel *lblText = [[UILabel alloc] initWithFrame:CGRectMake(20,5, 200, 20)];
        [lblText setText:@"Other Friends"];
        [lblText setBackgroundColor:[UIColor clearColor]];
        [lblText setTextColor:[UIColor whiteColor]];
        [backView addSubview:lblText];
        return backView;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return [searchedHolaoutFriend count];
    }
    else{
        return [searchedOtherFriend count];
    }
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Identifier"];
    }
    if(indexPath.section == 0){
        NSDictionary *dictionary = [searchedHolaoutFriend objectAtIndex:indexPath.row];
        cell.textLabel.text = [dictionary objectForKey:kContactName];
        UIImage *image = [UIImage imageWithContentsOfFile:[dictionary objectForKey:kContactImage]];
        if(image){
            cell.imageView.image = [self imageWithImage:image scaledToSize:CGSizeMake(35, 35)];
        }
        else{
            cell.imageView.image = nil;
        }
    }
    else{
        NSDictionary *dictionary = [searchedOtherFriend objectAtIndex:indexPath.row];
        cell.textLabel.text = [dictionary objectForKey:kContactName];
        UIImage *image = [UIImage imageWithContentsOfFile:[dictionary objectForKey:kContactImage]];
        if(image){
            cell.imageView.image = image;
        }
        else{
            cell.imageView.image = nil;
        }
    }
    return cell;
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    if (result) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Message sent successfully" delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
        [alert show];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        NSDictionary *dictionary = [searchedHolaoutFriend objectAtIndex:indexPath.row];
        QBUUser *user = [QBUUser user];
        user.email = [dictionary objectForKey:kContactEmail];
        user.ID = [[dictionary objectForKey:kContactHolaoutId] intValue];
        user.phone = [dictionary objectForKey:KContactPhone];
        user.fullName = [dictionary objectForKey:kContactName];
        
        MessageViewController *messageViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            messageViewController = [[MessageViewController alloc] initWithNibName:@"MessageViewController_iPhone" bundle:nil];
        }
        else{
            messageViewController = [[MessageViewController alloc] initWithNibName:@"MessageViewController_iPad" bundle:nil];
        }
        
        messageViewController.opponent = user;
        messageViewController.selectedFriend = [searchedHolaoutFriend objectAtIndex:indexPath.row];
        [self presentViewController:messageViewController animated:YES completion:nil];
    }
    else{
        if([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *mailComposer = [[MFMessageComposeViewController alloc]init];
        mailComposer.messageComposeDelegate = self;
        NSString *phone = [[searchedOtherFriend objectAtIndex:indexPath.row] objectForKey:KContactPhone];
        [mailComposer setRecipients:[NSArray arrayWithObject:phone]];
        [self presentViewController:mailComposer animated:YES completion:nil];
        }
    }
}
@end
