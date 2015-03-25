//
//  JSONExampleAppDelegate.m
//  JSONExample
//
//  Created by Christopher Burnett on 12/17/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "JSONExampleAppDelegate.h"
#import "JSONExampleViewController.h"
#import "CJSONDeserializer.h"

@implementation JSONExampleAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize jsonData;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[self getJSONFeed];
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}

-(void)getJSONFeed {
	// Create the URL & Request
	NSURL *feedURL = [NSURL URLWithString:@"http://missionzero.org/widgets/feed.js"];
	NSURLRequest *request = [NSURLRequest requestWithURL:feedURL];
	// Example connection only. Add Timeouts, cachingPolicy in production
	[NSURLConnection connectionWithRequest:request delegate:self ];
	// init the jsonData Property
	jsonData = [[NSMutableData data] retain];
}

- (NSDictionary *)parseJSON:(NSMutableData *)data {
	NSLog(@"Parsing JSON");
	NSError *error = nil;
	NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:data error:&error];
	return dictionary;
}

// NSURLConnection Delegate Methods. You would want to include more for error handling //
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSMutableData *)data {
	NSLog(@"Recieving Data...");
	// Append the incomming data as it is received
	[jsonData appendData:data];
	NSLog(@"%@",jsonData);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSLog(@"Fininshed Loading...");
	NSDictionary * feedDictionary = [self parseJSON:jsonData];
	NSLog(@"JSON as NSDictionary:: %@", feedDictionary);
}
// ----------------------------- //

- (void)dealloc {
	[jsonData release];
    [viewController release];
    [window release];
    [super dealloc];
}


@end
