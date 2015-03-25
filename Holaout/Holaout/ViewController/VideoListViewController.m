//
//  VideoListViewController.m
//  Holaout
//
//  Created by Amit Parmar on 16/01/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import "VideoListViewController.h"
#import "WebVideoViewController.h"

@implementation VideoListViewController
@synthesize scroller;
@synthesize searchBox;
@synthesize videos;
@synthesize selectedFriend;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    scroller.contentLayoutMode = MGLayoutGridStyle;
    scroller.bottomPadding = 8;
    scroller.backgroundColor = [UIColor colorWithWhite:0.25 alpha:1];
    searchBox = [MGBox boxWithSize:CGSizeMake(self.view.frame.size.width,44)];
    searchBox.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    
    UITextField* fldSearch = [[UITextField alloc] initWithFrame:CGRectMake(4,4,self.view.frame.size.width-8,35)];
    fldSearch.borderStyle = UITextBorderStyleRoundedRect;
    fldSearch.backgroundColor = [UIColor whiteColor];
    fldSearch.font = [UIFont systemFontOfSize:17];
    fldSearch.delegate = self;
    fldSearch.placeholder = @"Search YouTube...";
    fldSearch.clearButtonMode = UITextFieldViewModeAlways;
    fldSearch.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [fldSearch setReturnKeyType:UIReturnKeySearch];
    [searchBox addSubview: fldSearch];
    
    [scroller.boxes addObject: searchBox];
    
    [self searchYoutubeVideosForTerm: fldSearch.text];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self searchYoutubeVideosForTerm:textField.text];
    return YES;
}

-(void)searchYoutubeVideosForTerm:(NSString*)term{
    NSLog(@"Searching for '%@' ...", term);
    term = [term stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* searchCall = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?q=%@&max-results=50&alt=json", term];
    [JSONHTTPClient getJSONFromURLWithString: searchCall
                                  completion:^(NSDictionary *json, JSONModelError *err) {
                                      NSLog(@"Got JSON from web: %@", json);
                                      
                                      if (err) {
                                          [[[UIAlertView alloc] initWithTitle:@"Error"
                                                                      message:[err localizedDescription]
                                                                     delegate:nil
                                                            cancelButtonTitle:@"Close"
                                                            otherButtonTitles: nil] show];
                                          return;
                                      }
                                      videos = [VideoModel arrayOfModelsFromDictionaries:
                                                json[@"feed"][@"entry"]
                                                ];
                                      
                                      if (videos) NSLog(@"Loaded successfully models");
                                      [self showVideos];
                                      
                                  }];
}

- (void) openVideoView:(id)sender{
    WebVideoViewController *webVideoViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        webVideoViewController = [[WebVideoViewController alloc] initWithNibName:@"WebVideoViewController_iPhone" bundle:nil];
    }
    else{
         webVideoViewController = [[WebVideoViewController alloc] initWithNibName:@"WebVideoViewController_iPad" bundle:nil];
    }
    webVideoViewController.video = sender;
    webVideoViewController.seledtedFriend = selectedFriend;
    [self presentViewController:webVideoViewController animated:YES completion:nil];
}
-(void)showVideos{
    [scroller.boxes removeObjectsInRange:NSMakeRange(1, scroller.boxes.count-1)];
    for (int i=0;i<videos.count;i++) {
        VideoModel* video = videos[i];
        MediaThumbnail* thumb = video.thumbnail[0];
        PhotoBox *box = [PhotoBox photoBoxForURL:thumb.url title:video.title];
        box.onTap = ^{
            [self openVideoView:video];
        };
        [scroller.boxes addObject:box];
    }
    [scroller layoutWithSpeed:0.3 completion:nil];
}

- (IBAction)backButtonClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
