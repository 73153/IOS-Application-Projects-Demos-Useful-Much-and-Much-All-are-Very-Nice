//
//  NBUKit.m
//  NBUKit
//
//  Created by Ernesto Rivera on 2012/07/11.
//  Copyright (c) 2012-2013 CyberAgent Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "NBUKit.h"

@implementation NBUKit

+ (NSString *)version
{
    return @"2.1.0";
}

+ (NSBundle *)bundle
{
    static NSBundle * _resourcesBundle;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        NSString * bundlePath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"NBUKit.bundle"];
        _resourcesBundle = [NSBundle bundleWithPath:bundlePath];
    });
    
    return _resourcesBundle;
}

@end

