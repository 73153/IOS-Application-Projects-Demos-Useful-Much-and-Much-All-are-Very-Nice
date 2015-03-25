//
//  GSViewController.m
//  GSDropboxDemoApp
//
//  Created by Simon Whitaker on 25/11/2012.
//  Copyright (c) 2012 Goo Software Ltd. All rights reserved.
//

#import "GSViewController.h"
#import "GSDropboxActivity.h"
#import "GSDropboxUploader.h"

@interface GSViewController ()

@property (nonatomic, retain) UIPopoverController *activityPopoverController;

@end

@implementation GSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.progressView.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDropboxFileProgressNotification:)
                                                 name:GSDropboxUploaderDidGetProgressUpdateNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDropboxUploadDidStartNotification:)
                                                 name:GSDropboxUploaderDidStartUploadingFileNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDropboxUploadDidFinishNotification:)
                                                 name:GSDropboxUploaderDidFinishUploadingFileNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDropboxUploadDidFailNotification:)
                                                 name:GSDropboxUploaderDidFailNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)shareKitten:(id)sender
{
    NSURL *kittenFileURL = [[NSBundle mainBundle] URLForResource:@"kitten.jpg" withExtension:nil];
    NSArray *objectsToShare = @[
        kittenFileURL
    ];
    NSArray *activities = @[
        [[GSDropboxActivity alloc] init]
    ];
    
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare
                                                                     applicationActivities:activities];
    
    // Exclude some default activity types to keep this demo clean and simple.
    vc.excludedActivityTypes = @[
        UIActivityTypeAssignToContact,
        UIActivityTypeCopyToPasteboard,
        UIActivityTypePostToFacebook,
        UIActivityTypePostToTwitter,
        UIActivityTypePostToWeibo,
        UIActivityTypePrint,
    ];
    
    if (isIpad) {
        if (self.activityPopoverController.isPopoverVisible) {
            // If the popover's visible, hide it
            [self.activityPopoverController dismissPopoverAnimated:YES];
        } else {
            if (self.activityPopoverController == nil) {
                self.activityPopoverController = [[UIPopoverController alloc] initWithContentViewController:vc];
            } else {
                self.activityPopoverController.contentViewController = vc;
            }
            
            // Set a completion handler to dismiss the popover
            [vc setCompletionHandler:^(NSString *activityType, BOOL completed){
                [self.activityPopoverController dismissPopoverAnimated:YES];
            }];
            
            [[self activityPopoverController] presentPopoverFromRect:[((UIControl*)sender) frame] inView:[self view] permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    } else {
        [self presentViewController:vc animated:YES completion:NULL];
    }
}

- (void)handleDropboxFileProgressNotification:(NSNotification *)notification
{
    NSURL *fileURL = notification.userInfo[GSDropboxUploaderFileURLKey];
    float progress = [notification.userInfo[GSDropboxUploaderProgressKey] floatValue];
    NSLog(@"Upload of %@ now at %.0f%%", fileURL.absoluteString, progress * 100);
    
    self.progressView.progress = progress;
}

- (void)handleDropboxUploadDidStartNotification:(NSNotification *)notification
{
    NSURL *fileURL = notification.userInfo[GSDropboxUploaderFileURLKey];
    NSLog(@"Started uploading %@", fileURL.absoluteString);

    self.progressView.progress = 0.0;
    self.progressView.hidden = NO;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)handleDropboxUploadDidFinishNotification:(NSNotification *)notification
{
    NSURL *fileURL = notification.userInfo[GSDropboxUploaderFileURLKey];
    NSLog(@"Finished uploading %@", fileURL.absoluteString);
    
    self.progressView.hidden = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)handleDropboxUploadDidFailNotification:(NSNotification *)notification
{
    NSURL *fileURL = notification.userInfo[GSDropboxUploaderFileURLKey];
    NSLog(@"Failed to upload %@", fileURL.absoluteString);

    self.progressView.hidden = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
