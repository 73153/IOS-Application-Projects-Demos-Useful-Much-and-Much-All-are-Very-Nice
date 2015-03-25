//
//  UIScrollView+NBUAdditions.m
//  NBUKit
//
//  Created by Ernesto Rivera on 2012/10/17.
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

#import "UIScrollView+NBUAdditions.h"
#import "NBUKitPrivate.h"

@implementation UIScrollView (NBUAdditions)

#pragma mark - Scroll to edges

- (void)scrollToTopAnimated:(BOOL)animated
{
    [self scrollRectToVisible:CGRectMake(self.contentOffset.x,
                                         0.0,
                                         1.0,
                                         1.0)
                     animated:animated];
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
    [self scrollRectToVisible:CGRectMake(self.contentOffset.x,
                                         self.contentSize.height - 1.0,
                                         1.0,
                                         1.0)
                     animated:animated];
}

- (void)scrollToLeftAnimated:(BOOL)animated
{
    [self scrollRectToVisible:CGRectMake(0.0,
                                         self.contentOffset.y,
                                         1.0,
                                         1.0)
                     animated:animated];
}

- (void)scrollToRightAnimated:(BOOL)animated
{
    [self scrollRectToVisible:CGRectMake(self.contentSize.width - 1.0,
                                         self.contentOffset.y,
                                         1.0,
                                         1.0)
                     animated:animated];
}

@end

