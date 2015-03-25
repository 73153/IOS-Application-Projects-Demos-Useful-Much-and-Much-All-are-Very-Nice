//
//  NBULog+NBUKit.m
//  NBUKit
//
//  Created by Ernesto Rivera on 2012/12/12.
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

#ifdef COCOAPODS_POD_AVAILABLE_NBULog

#import "NBULog+NBUKit.h"
#import <NBULog/NBULogContextDescription.h>

static int _kitLogLevel;

@implementation NBULog (NBUKit)

+ (void)load
{
    // Default levels
    [self setKitLogLevel:LOG_LEVEL_DEFAULT];
    
    // Register the NBUKit log context
    [NBULog registerContextDescription:[NBULogContextDescription descriptionWithName:@"NBUKit"
                                                                             context:NBUKIT_LOG_CONTEXT
                                                                     modulesAndNames:nil
                                                                   contextLevelBlock:^{ return [NBULog kitLogLevel]; }
                                                                setContextLevelBlock:^(int level) { [NBULog setKitLogLevel:level]; }
                                                          contextLevelForModuleBlock:NULL
                                                       setContextLevelForModuleBlock:NULL]];
}

+ (int)kitLogLevel
{
    return _kitLogLevel;
}

+ (void)setKitLogLevel:(int)LOG_LEVEL_XXX
{
#ifdef DEBUG
    _kitLogLevel = LOG_LEVEL_XXX == LOG_LEVEL_DEFAULT ? LOG_LEVEL_INFO : LOG_LEVEL_XXX;
#else
    _kitLogLevel = LOG_LEVEL_XXX == LOG_LEVEL_DEFAULT ? LOG_LEVEL_WARN : LOG_LEVEL_XXX;
#endif
}

@end

#endif

