// OPPopularProvider.m
// 
// Copyright (c) 2013 Say Goodnight Software
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "OPPopularProvider.h"
#import "OPImageItem.h"
#import "OPBackend.h"
#import "TMCache.h"

NSString * const OPProviderTypePopular = @"com.saygoodnight.Popular";

@implementation OPPopularProvider

- (id) initWithProviderType:(NSString*) providerType {
    self = [super initWithProviderType:providerType];
    if (self) {
        self.providerName = @"Currently Popular Images";
        self.supportsInitialSearching = YES;
    }
    return self;
}

- (void) getItemsWithQuery:(NSString*) queryString
            withPageNumber:(NSNumber*) pageNumber
                   success:(void (^)(NSArray* items, BOOL canLoadMore))success
                   failure:(void (^)(NSError* error))failure {
    [[OPBackend shared] getItemsWithQuery:queryString
                           withPageNumber:pageNumber
                                  success:success
                                  failure:failure];
}

- (void) doInitialSearchWithSuccess:(void (^)(NSArray* items, BOOL canLoadMore))success
                            failure:(void (^)(NSError* error))failure {
    
    NSDictionary* cachedQuery = [[TMCache sharedCache] objectForKey:@"initial_popular_query"];
    
    if (cachedQuery) {
        if (success) {
            success(cachedQuery[@"items"],[cachedQuery[@"canLoadMore"] boolValue]);
        }
    }
    
    [self getItemsWithQuery:nil
             withPageNumber:@1
                    success:^(NSArray *items, BOOL canLoadMore) {

                        if (cachedQuery && [cachedQuery[@"items"] isEqualToArray:items]) {
                            return;
                        }
                        
                        NSDictionary* newCachedQuery = @{@"items": items, @"canLoadMore":[NSNumber numberWithBool:canLoadMore]};
                        [[TMCache sharedCache] setObject:newCachedQuery forKey:@"initial_popular_query"];
                        if (success) {
                            success(items,canLoadMore);
                        }
                    }
                    failure:failure];
}

@end
