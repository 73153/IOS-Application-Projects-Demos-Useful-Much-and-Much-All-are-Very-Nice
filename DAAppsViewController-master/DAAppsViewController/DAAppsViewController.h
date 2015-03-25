//
//  DAAppsViewController.h
//  DAAppsViewController
//
//  Created by Daniel Amitay on 4/3/13.
//  Copyright (c) 2013 Daniel Amitay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAAppsViewController : UITableViewController

@property (nonatomic, copy) void(^didViewAppBlock)(NSInteger appId);

// Customized title of the view controller.
// It should be set before calling loadAppsWithXXX methods.
// If it is nil, the title will be the artist/company name or 'Results'.
@property (nonatomic, strong) NSString *pageTitle;

- (void)loadAppsWithArtistId:(NSInteger)artistId completionBlock:(void(^)(BOOL result, NSError *error))block;
- (void)loadAllAppsWithArtistId:(NSInteger)artistId completionBlock:(void(^)(BOOL result, NSError *error))block;
- (void)loadAppsWithAppIds:(NSArray *)appIds completionBlock:(void(^)(BOOL result, NSError *error))block;
- (void)loadAppsWithBundleIds:(NSArray *)bundleIds completionBlock:(void(^)(BOOL result, NSError *error))block;
- (void)loadAppsWithSearchTerm:(NSString *)searchTerm completionBlock:(void(^)(BOOL result, NSError *error))block;

@end
