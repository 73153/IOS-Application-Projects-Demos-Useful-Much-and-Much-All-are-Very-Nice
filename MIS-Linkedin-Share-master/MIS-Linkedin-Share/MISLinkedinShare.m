//
//  ShareLinkedinHelper.m
//  OAuthStarterKit
//
//  Created by Pedro Milanez on 27/09/12.
//  Copyright (c) 2012 self. All rights reserved.
//


#import "MISLinkedinShare.h"
#import "OAMutableURLRequest.h"

@implementation MISLinkedinShare
@synthesize oAuthLoginView = _oAuthLoginView;
@synthesize postTitle = _postTitle;
@synthesize postDescription = _postDescription;
@synthesize postURL = _postURL;
@synthesize postImageURL = _postImageURL;

+ (MISLinkedinShare *)sharedInstance
{
    static dispatch_once_t once;
    static MISLinkedinShare *instance;
    dispatch_once(&once, ^ { instance = [[MISLinkedinShare alloc] init]; });
    return instance;
}


# pragma mark - Public Methods
- (void) shareContent:(UIViewController *)viewController postTitle:(NSString*)aPostTitle postDescription:(NSString*)aPostDescription postURL:(NSString*)aPostURL postImageURL:(NSString*)aPostImageURL {
	
	_postTitle = aPostTitle;
	_postDescription = aPostDescription;
	_postURL = aPostURL;
	_postImageURL = aPostImageURL;
	
	_oAuthLoginView = [[OAuthLoginView alloc] initWithNibName:nil bundle:nil apiKey:kLinkedinApiKey secretKey:kLinkedinSecretKey];
	
    // register to be told when the login is finished
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginViewDidFinish:)
                                                 name:@"loginViewDidFinish"
                                               object:_oAuthLoginView];
    
    [viewController presentViewController:_oAuthLoginView animated:YES completion:^{}];
}


#pragma mark - Private Methods

-(void) loginViewDidFinish:(NSNotification*)notification
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	// Login failed
	if (![_oAuthLoginView.accessToken isValid]) {
		return;
	}
	
    [self shareContentWithData];
}

#pragma mark - OADataFetcher return Methods
- (void) shareContentWithData
{
    NSURL *url = [NSURL URLWithString:@"http://api.linkedin.com/v1/people/~/shares"];
    OAMutableURLRequest *request =
    [[OAMutableURLRequest alloc] initWithURL:url
                                    consumer:_oAuthLoginView.consumer
                                       token:_oAuthLoginView.accessToken
                                    callback:nil
                           signatureProvider:nil];
    
    NSDictionary *update = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [[NSDictionary alloc]
                             initWithObjectsAndKeys:
                             @"anyone",@"code",nil], @"visibility",
							
							[[NSDictionary alloc]
                             initWithObjectsAndKeys:
                             _postTitle,@"title",
							 _postDescription,@"description",
							 _postURL,@"submitted-url",
							 _postImageURL,@"submitted-image-url",
							 nil], @"content",
							
							
                            _postTitle, @"comment", nil];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *updateString = [update JSONString];
    
    [request setHTTPBodyWithString:updateString];
	[request setHTTPMethod:@"POST"];
    
    OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:request
                         delegate:self
                didFinishSelector:@selector(postUpdateApiCallResult:didFinish:)
                  didFailSelector:@selector(postUpdateApiCallResult:didFail:)];
}

- (void)postUpdateApiCallResult:(OAServiceTicket *)ticket didFinish:(NSData *)data
{
    // The next thing we want to do is call the network updates
    NSLog(@"Sucess! %@",[data description]);
    
}

- (void)postUpdateApiCallResult:(OAServiceTicket *)ticket didFail:(NSData *)error
{
    NSLog(@"%@",[error description]);
}

@end
