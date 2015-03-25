//
//  JSONModel+networking.m
//
//  @version 0.8.3
//  @author Marin Todorov, http://www.touch-code-magazine.com
//

// Copyright (c) 2012 Marin Todorov, Underplot ltd.
// This code is distributed under the terms and conditions of the MIT license.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// The MIT License in plain English: http://www.touch-code-magazine.com/JSONModel/MITLicense

#import "JSONModel+networking.h"
#import "JSONHTTPClient.h"

BOOL _isLoading;

@implementation JSONModel(Networking)

@dynamic isLoading;

-(BOOL)isLoading
{
    return _isLoading;
}

-(void)setIsLoading:(BOOL)isLoading
{
    _isLoading = isLoading;
}

-(id)initFromURLWithString:(NSString*)urlString error:(JSONModelError**)err
{
    id jsonObject = [JSONHTTPClient getJSONFromURLWithString:urlString];
    JSONModelError* initError = nil;
    id objModel = [self initWithDictionary:jsonObject error:&initError];
    if (err) {
        *err = initError;
    }
    return objModel;
}

-(id)initFromURLWithString:(NSString *)urlString completion:(JSONModelBlock)completeBlock
{
    self = [super init];
    __block id blockSelf = self;
    
    if (self) {
        //initialization
        self.isLoading = YES;
        
        [JSONHTTPClient getJSONFromURLWithString:urlString
                                      completion:^(NSDictionary *json, JSONModelError* e) {
                                          
                                          JSONModelError* initError = nil;
                                          blockSelf = [self initWithDictionary:json error:&initError];
                                          
                                          if (completeBlock) {
                                              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
                                                  completeBlock(blockSelf, e?e:initError );
                                              });
                                          }
                                          
                                          self.isLoading = NO;
                                          
                                      }];
    }
    return self;
}

@end
