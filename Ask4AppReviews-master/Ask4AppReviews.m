/*
 This file is part of Ask4AppReviews (forked from Appirater).
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */
/*
 * Ask4AppReviews.m
 * Ask4AppReviews
 *
 * Created by Luke Durrant on 7/12.
 * Ask4AppReviews (forked from Appirater).
 */

#import "Ask4AppReviews.h"
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netinet/in.h>



NSString *const kAsk4AppReviewsFirstUseDate				= @"kAsk4AppReviewsFirstUseDate";
NSString *const kAsk4AppReviewsUseCount					= @"kAsk4AppReviewsUseCount";
NSString *const kAsk4AppReviewsSignificantEventCount	= @"kAsk4AppReviewsSignificantEventCount";
NSString *const kAsk4AppReviewsCurrentVersion			= @"kAsk4AppReviewsCurrentVersion";
NSString *const kAsk4AppReviewsRatedCurrentVersion		= @"kAsk4AppReviewsRatedCurrentVersion";
NSString *const kAsk4AppReviewsDeclinedToRate			= @"kAsk4AppReviewsDeclinedToRate";
NSString *const kAsk4AppReviewsReminderRequestDate		= @"kAsk4AppReviewsReminderRequestDate";
NSString *const kAsk4AppReviewsAppIdBundleKey           = @"AppStoreId";
NSString *const kAsk4AppReviewsEmailBundleKey           = @"DeveloperEmail";

@interface Ask4AppReviews ()
- (BOOL)connectedToNetwork;
+ (NSString*)appStoreAppID;
+ (NSString*)developerEmail;
+ (Ask4AppReviews*)sharedInstance;
- (void)showRatingAlert;
- (void)showQuestionAlert;
- (BOOL)ratingConditionsHaveBeenMet;
- (void)incrementUseCount;
- (void)hideRatingAlert;
@end

@implementation Ask4AppReviews {
    NSString *templateReviewURL;
}

@synthesize questionAlert;
@synthesize ratingAlert;
@synthesize theViewController;

- (BOOL)connectedToNetwork {
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
	
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
	
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        NSLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
	
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
	
	NSURL *testURL = [NSURL URLWithString:@"http://www.apple.com/"];
	NSURLRequest *testRequest = [NSURLRequest requestWithURL:testURL  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];
	NSURLConnection *testConnection = [[NSURLConnection alloc] initWithRequest:testRequest delegate:self];
	
    return ((isReachable && !needsConnection) || nonWiFi) ? (testConnection ? YES : NO) : NO;
}

+(NSString*)appStoreAppID {
	
    NSString* value = [[[NSBundle mainBundle] infoDictionary] objectForKey:kAsk4AppReviewsAppIdBundleKey];
	
    NSAssert1(value, @"Error - you have not specified %@ property in your info.plist", kAsk4AppReviewsAppIdBundleKey);
	
    return value;
}

+(NSString*)developerEmail {
	
    NSString* value = [[[NSBundle mainBundle] infoDictionary] objectForKey:kAsk4AppReviewsEmailBundleKey];
	
    NSAssert1(value, @"Error - you have not specified %@ property in your info.plist", kAsk4AppReviewsEmailBundleKey);
	
    return value;
}




+ (Ask4AppReviews*)sharedInstance {
	static Ask4AppReviews *ask = nil;
	if (ask == nil)
	{
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            ask = [[Ask4AppReviews alloc] init];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive) name:
             UIApplicationWillResignActiveNotification object:nil];
        });
	}
	
	return ask;
}

- (id)init
{
    self = [super init];
    if (self) {
        if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] == NSOrderedAscending) {
            templateReviewURL = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=APP_ID";
        } else {
            templateReviewURL = @"itms-apps://itunes.apple.com/app/idAPP_ID";
        }
    }
    
    return self;
}

- (void)showRatingAlert {
    
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:Ask4AppReviews_MESSAGE_TITLE
                                                        message:Ask4AppReviews_MESSAGE
                                                       delegate:self
                                              cancelButtonTitle:Ask4AppReviews_CANCEL_BUTTON
                                              otherButtonTitles:Ask4AppReviews_RATE_BUTTON, Ask4AppReviews_RATE_LATER, nil];
    alertView.tag = 2;
	self.ratingAlert = alertView;
	[alertView show];
    
}

- (void)showQuestionAlert
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:Ask4AppReviews_QUESTION_MESSAGE_TITLE
                                                        message:Ask4AppReviews_QUESTION
                                                       delegate:self
                                              cancelButtonTitle:Ask4AppReviews_RATE_LATER
                                              otherButtonTitles:Ask4AppReviews_NO, Ask4AppReviews_YES, nil];
    alertView.tag = 1;
	self.questionAlert = alertView;
	[alertView show];
    
}

- (BOOL)ratingConditionsHaveBeenMet {
	if (Ask4AppReviews_DEBUG)
		return YES;
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	
	NSDate *dateOfFirstLaunch = [NSDate dateWithTimeIntervalSince1970:[userDefaults doubleForKey:kAsk4AppReviewsFirstUseDate]];
	NSTimeInterval timeSinceFirstLaunch = [[NSDate date] timeIntervalSinceDate:dateOfFirstLaunch];
	NSTimeInterval timeUntilRate = 60 * 60 * 24 * Ask4AppReviews_DAYS_UNTIL_PROMPT;
	if (timeSinceFirstLaunch < timeUntilRate)
		return NO;
	
	// check if the app has been used enough
	int useCount = [userDefaults integerForKey:kAsk4AppReviewsUseCount];
	if (useCount <= Ask4AppReviews_USES_UNTIL_PROMPT)
		return NO;
	
	// check if the user has done enough significant events
	int sigEventCount = [userDefaults integerForKey:kAsk4AppReviewsSignificantEventCount];
	if (sigEventCount <= Ask4AppReviews_SIG_EVENTS_UNTIL_PROMPT)
		return NO;
	
	// has the user previously declined to rate this version of the app?
	if ([userDefaults boolForKey:kAsk4AppReviewsDeclinedToRate])
		return NO;
	
	// has the user already rated the app?
	if ([userDefaults boolForKey:kAsk4AppReviewsRatedCurrentVersion])
		return NO;
	
	// if the user wanted to be reminded later, has enough time passed?
	NSDate *reminderRequestDate = [NSDate dateWithTimeIntervalSince1970:[userDefaults doubleForKey:kAsk4AppReviewsReminderRequestDate]];
	NSTimeInterval timeSinceReminderRequest = [[NSDate date] timeIntervalSinceDate:reminderRequestDate];
	NSTimeInterval timeUntilReminder = 60 * 60 * 24 * Ask4AppReviews_TIME_BEFORE_REMINDING;
	if (timeSinceReminderRequest < timeUntilReminder)
		return NO;
	
	return YES;
    
}

- (void)incrementUseCount {
	// get the app's version
	NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
	
	// get the version number that we've been tracking
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *trackingVersion = [userDefaults stringForKey:kAsk4AppReviewsCurrentVersion];
	if (trackingVersion == nil)
	{
		trackingVersion = version;
		[userDefaults setObject:version forKey:kAsk4AppReviewsCurrentVersion];
	}
	
	if (Ask4AppReviews_DEBUG)
		NSLog(@"Ask4AppReviews Tracking version: %@", trackingVersion);
	
	if ([trackingVersion isEqualToString:version])
	{
		// check if the first use date has been set. if not, set it.
		NSTimeInterval timeInterval = [userDefaults doubleForKey:kAsk4AppReviewsFirstUseDate];
		if (timeInterval == 0)
		{
			timeInterval = [[NSDate date] timeIntervalSince1970];
			[userDefaults setDouble:timeInterval forKey:kAsk4AppReviewsFirstUseDate];
		}
		
		// increment the use count
		int useCount = [userDefaults integerForKey:kAsk4AppReviewsUseCount];
		useCount++;
		[userDefaults setInteger:useCount forKey:kAsk4AppReviewsUseCount];
		if (Ask4AppReviews_DEBUG)
			NSLog(@"Ask4AppReviews Use count: %d", useCount);
	}
	else
	{
		// it's a new version of the app, so restart tracking
		[userDefaults setObject:version forKey:kAsk4AppReviewsCurrentVersion];
		[userDefaults setDouble:[[NSDate date] timeIntervalSince1970] forKey:kAsk4AppReviewsFirstUseDate];
		[userDefaults setInteger:1 forKey:kAsk4AppReviewsUseCount];
		[userDefaults setInteger:0 forKey:kAsk4AppReviewsSignificantEventCount];
		[userDefaults setBool:NO forKey:kAsk4AppReviewsRatedCurrentVersion];
		[userDefaults setBool:NO forKey:kAsk4AppReviewsDeclinedToRate];
		[userDefaults setDouble:0 forKey:kAsk4AppReviewsReminderRequestDate];
        
	}
	
	[userDefaults synchronize];
}

- (void)incrementSignificantEventCount {
	// get the app's version
	NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
	
	// get the version number that we've been tracking
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *trackingVersion = [userDefaults stringForKey:kAsk4AppReviewsCurrentVersion];
	if (trackingVersion == nil)
	{
		trackingVersion = version;
		[userDefaults setObject:version forKey:kAsk4AppReviewsCurrentVersion];
	}
	
	if (Ask4AppReviews_DEBUG)
		NSLog(@"Ask4AppReviews Tracking version: %@", trackingVersion);
	
	if ([trackingVersion isEqualToString:version])
	{
		// check if the first use date has been set. if not, set it.
		NSTimeInterval timeInterval = [userDefaults doubleForKey:kAsk4AppReviewsFirstUseDate];
		if (timeInterval == 0)
		{
			timeInterval = [[NSDate date] timeIntervalSince1970];
			[userDefaults setDouble:timeInterval forKey:kAsk4AppReviewsFirstUseDate];
		}
		
		// increment the significant event count
		int sigEventCount = [userDefaults integerForKey:kAsk4AppReviewsSignificantEventCount];
		sigEventCount++;
		[userDefaults setInteger:sigEventCount forKey:kAsk4AppReviewsSignificantEventCount];
		if (Ask4AppReviews_DEBUG)
			NSLog(@"Ask4AppReviews Significant event count: %d", sigEventCount);
	}
	else
	{
		// it's a new version of the app, so restart tracking
		[userDefaults setObject:version forKey:kAsk4AppReviewsCurrentVersion];
		[userDefaults setDouble:0 forKey:kAsk4AppReviewsFirstUseDate];
		[userDefaults setInteger:0 forKey:kAsk4AppReviewsUseCount];
		[userDefaults setInteger:1 forKey:kAsk4AppReviewsSignificantEventCount];
		[userDefaults setBool:NO forKey:kAsk4AppReviewsRatedCurrentVersion];
		[userDefaults setBool:NO forKey:kAsk4AppReviewsDeclinedToRate];
		[userDefaults setDouble:0 forKey:kAsk4AppReviewsReminderRequestDate];
	}
	
	[userDefaults synchronize];
}

- (void)incrementAndRate:(BOOL)canPromptForRating {
	[self incrementUseCount];
	
	if (canPromptForRating &&
		[self ratingConditionsHaveBeenMet] &&
		[self connectedToNetwork])
	{
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           //If they have been asked before and said remind me take them straight to the rating alert
                           
                           NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                           double kAsk4AppReviewsReminder = [userDefaults doubleForKey:kAsk4AppReviewsReminderRequestDate];
                           
                           if(kAsk4AppReviewsReminder == 0 || Ask4AppReviews_DEBUG)
                           {
                               [self showQuestionAlert];
                           }else{
                               [self showRatingAlert];
                           }
                       });
	}
}

- (void)incrementSignificantEventAndRate:(BOOL)canPromptForRating {
	[self incrementSignificantEventCount];
	
	if (canPromptForRating &&
		[self ratingConditionsHaveBeenMet] &&
		[self connectedToNetwork])
	{
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                           double kAsk4AppReviewsReminder = [userDefaults doubleForKey:kAsk4AppReviewsReminderRequestDate];
                           
                           if(kAsk4AppReviewsReminder == 0 || Ask4AppReviews_DEBUG)
                           {
                               [self showQuestionAlert];
                           }else{
                               [self showRatingAlert];
                           }
                       });
	}
}

+ (void)appLaunched {
	[Ask4AppReviews appLaunched:YES];
}

+ (void)appLaunched:(BOOL)canPromptForRating  {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),
                   ^{
                       [[Ask4AppReviews sharedInstance] incrementAndRate:canPromptForRating];
                   });
}


+ (void)appLaunched:(BOOL)canPromptForRating viewController:(UINavigationController*)viewController {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),
                   ^{
                       [[Ask4AppReviews sharedInstance] setTheViewController:viewController];
                       
                       [[Ask4AppReviews sharedInstance] incrementAndRate:canPromptForRating];
                       
                   });
}

- (void)hideRatingAlert {
	if (self.ratingAlert.visible) {
		if (Ask4AppReviews_DEBUG)
			NSLog(@"Ask4AppReviews Hiding Alert");
        
		[self.ratingAlert dismissWithClickedButtonIndex:-1 animated:NO];
        
	}
    if (self.questionAlert.visible) {
		if (Ask4AppReviews_DEBUG)
			NSLog(@"Ask4AppReviews questionAlert Alert");
        
		[self.questionAlert dismissWithClickedButtonIndex:-1 animated:NO];
        
	}
}

+ (void)appWillResignActive {
	if (Ask4AppReviews_DEBUG)
		NSLog(@"Ask4AppReviews appWillResignActive");
	[[Ask4AppReviews sharedInstance] hideRatingAlert];
}

+ (void)appEnteredForeground:(BOOL)canPromptForRating {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),
                   ^{
                       [[Ask4AppReviews sharedInstance] incrementAndRate:canPromptForRating];
                   });
}

+ (void)userDidSignificantEvent:(BOOL)canPromptForRating {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),
                   ^{
                       [[Ask4AppReviews sharedInstance] incrementSignificantEventAndRate:canPromptForRating];
                   });
}

+ (void)rateApp {
#if TARGET_IPHONE_SIMULATOR
	NSLog(@"Ask4AppReviews NOTE: iTunes App Store is not supported on the iOS simulator. Unable to open App Store page.");
#else
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *reviewURL = [[Ask4AppReviews sharedInstance]->templateReviewURL stringByReplacingOccurrencesOfString:@"APP_ID" withString:[self appStoreAppID]];
    
	[userDefaults setBool:YES forKey:kAsk4AppReviewsRatedCurrentVersion];
	[userDefaults synchronize];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURL]];
#endif
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [theViewController dismissModalViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //NSLog(@"tag %i buttonIndex %i  ", alertView.tag, buttonIndex);
    if(alertView.tag == 1)
    {
        
        //we are asking to rate, remind, or no thanks
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        switch (buttonIndex) {
            case 0:
            {
                // remind them later
                [userDefaults setDouble:[[NSDate date] timeIntervalSince1970] forKey:kAsk4AppReviewsReminderRequestDate];
                [userDefaults synchronize];
                
                break;
            }
            case 1:
            {
                //No
                [self showRatingAlert];
                break;
            }
            case 2:
                //They have issues ask them to fill in a email question
                //You need to include UIMessage Framework
                if ([MFMailComposeViewController canSendMail])
                {
                    MFMailComposeViewController *mPicker = [[MFMailComposeViewController alloc] init];
                    mPicker.mailComposeDelegate = self;
                    
                    [mPicker setSubject:Ask4AppReviews_EMAIL_SUBJECT];
                    
                    NSArray *toRecipients = [NSArray arrayWithObject:[Ask4AppReviews developerEmail]];
                    
                    [mPicker setToRecipients:toRecipients];
                    [mPicker setMessageBody:Ask4AppReviews_EMAIL_BODY isHTML:NO];
                    
                    [theViewController presentModalViewController:mPicker animated:YES];
                    
                }else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                                    message:Ask4AppReviews_DEVELOPER_EMAIL_ALERT
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles: nil];
                    [alert show];
                }
                //We dont want them to rate it
                [userDefaults setBool:YES forKey:kAsk4AppReviewsDeclinedToRate];
                [userDefaults synchronize];
                
                
                
                break;
            default:
                break;
        }
        
        
    }else if(alertView.tag == 2)
    {
        
        //we are asking if the have any issues using app no, yes or remind me later
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        switch (buttonIndex) {
            case 0:
            {
                // they don't want to rate it
                [userDefaults setBool:YES forKey:kAsk4AppReviewsDeclinedToRate];
                [userDefaults synchronize];
                
                break;
            }
            case 1:
            {
                // they want to rate it
                [Ask4AppReviews rateApp];
                break;
            }
            case 2:
                // remind them later
                [userDefaults setDouble:[[NSDate date] timeIntervalSince1970] forKey:kAsk4AppReviewsReminderRequestDate];
                [userDefaults synchronize];
                break;
            default:
                break;
        }
        
        
    }
    
}

@end