//
//  ShareLinkedinHelper.h
//  OAuthStarterKit
//
//  Created by Pedro Milanez on 27/09/12.
//  Copyright (c) 2012 self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAuthLoginView.h"
#import "JSONKit.h"
#import "OAConsumer.h"
#import "OAMutableURLRequest.h"
#import "OADataFetcher.h"
#import "OATokenManager.h"

#define kLinkedinApiKey @"YOUR LINKEDIN KEY"
#define kLinkedinSecretKey @"YOUR LINKEDIN SECRETKEY"

@interface MISLinkedinShare : NSObject

@property (nonatomic, strong) OAuthLoginView *oAuthLoginView;
@property (nonatomic, strong) NSString *postTitle;
@property (nonatomic, strong) NSString *postDescription;
@property (nonatomic, strong) NSString *postURL;
@property (nonatomic, strong) NSString *postImageURL;

+ (MISLinkedinShare *)sharedInstance;

- (void) shareContent:(UIViewController *)viewController postTitle:(NSString*)aPostTitle postDescription:(NSString*)aPostDescription postURL:(NSString*)aPostURL postImageURL:(NSString*)aPostImageURL;



@end
