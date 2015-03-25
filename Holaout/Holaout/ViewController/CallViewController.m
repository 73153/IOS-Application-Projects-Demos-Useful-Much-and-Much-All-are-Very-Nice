//
//  CallViewController.m
//  Holaout
//
//  Created by Amit Parmar on 28/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "CallViewController.h"
#import "SettingsViewController.h"
#import "AppDelegate.h"
#import "MessageViewController.h"
#import "AcceptCallViewController.h"

@implementation CallViewController

@synthesize lblUserName;
@synthesize lblTime;
@synthesize lblDay;
@synthesize userImageView;
@synthesize selectedFriend;
@synthesize timer;
@synthesize count;
@synthesize dateFormatter;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)populateLabel:(UILabel *)label withTimeInterval:(NSTimeInterval)timeInterval {
    uint seconds = fabs(timeInterval);
    uint minutes = seconds / 60;
    uint hours = minutes / 60;
    
    seconds -= minutes * 60;
    minutes -= hours * 60;
    
    [label setText:[NSString stringWithFormat:@"%@%02uh:%02um:%02us", (timeInterval<0?@"-":@""), hours, minutes, seconds]];
}

- (void) showTime{
    count++;
    [self populateLabel:lblTime withTimeInterval:count];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    userImageView.image = [UIImage imageWithContentsOfFile:[selectedFriend objectForKey:kContactImage]];
    lblUserName.text = [selectedFriend objectForKey:kContactName];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    int weekday = [comps weekday];
    if(weekday == 1){
       lblDay.text = @"Sunday";
    }
    else if (weekday == 2){
       lblDay.text = @"Monday";
    }
    else if (weekday == 3){
       lblDay.text = @"Tuesday";
    }
    else if (weekday == 4){
       lblDay.text = @"Wednesday";
    }
    else if (weekday == 5){
       lblDay.text = @"Thursday";
    }
    else if (weekday == 6){
       lblDay.text = @"Friday";
    }
    else if (weekday == 7){
       lblDay.text = @"Saturday";
    }
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle: NSDateFormatterShortStyle];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(showTime)
                                   userInfo:nil
                                    repeats:YES];
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (IBAction)btnSpeakerClicked:(id)sender{
    if([sender tag] == 101){
       [AppDelegate appdelegate].videoChat.useHeadphone = NO;
        [sender setTag:102];
    }
    else{
        [AppDelegate appdelegate].videoChat.useHeadphone = YES;
        [sender setTag:101];
    }
}
- (IBAction)btnMuteClicked:(id)sender{
    if([sender tag] == 201){
        [AppDelegate appdelegate].videoChat.microphoneEnabled = NO;
        [sender setTag:202];
    }
    else{
        [AppDelegate appdelegate].videoChat.microphoneEnabled = YES;
        [sender setTag:201];
    }
    
}
- (IBAction)btnChatClicked:(id)sender{
    QBUUser *user = [QBUUser user];
    user.email = [selectedFriend objectForKey:kContactEmail];
    user.ID = [[selectedFriend objectForKey:kContactHolaoutId] intValue];
    user.phone = [selectedFriend objectForKey:KContactPhone];
    user.fullName = [selectedFriend objectForKey:kContactName];
    
    MessageViewController *messageViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        messageViewController = [[MessageViewController alloc] initWithNibName:@"MessageViewController_iPhone" bundle:nil];
    }
    else{
        messageViewController = [[MessageViewController alloc] initWithNibName:@"MessageViewController_iPad" bundle:nil];
    }
    messageViewController.opponent = user;
    messageViewController.selectedFriend = selectedFriend;
    [self presentViewController:messageViewController animated:YES completion:nil];
}
- (IBAction)btnCallEndClicked:(id)sender{
    if(timer){
        [timer invalidate];
        timer = nil;
    }
    [[AppDelegate appdelegate].videoChat finishCall];
    [[QBChat instance] unregisterVideoChatInstance:[AppDelegate appdelegate].videoChat];
    [AppDelegate appdelegate].videoChat = nil;
}

- (IBAction)btnBackClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnSettingsClicked:(id)sender{
    SettingsViewController *settingsViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPhone" bundle:nil];
    }
    else{
        settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPad" bundle:nil];
    }
    [self presentViewController:settingsViewController animated:YES completion:nil];
}
@end
