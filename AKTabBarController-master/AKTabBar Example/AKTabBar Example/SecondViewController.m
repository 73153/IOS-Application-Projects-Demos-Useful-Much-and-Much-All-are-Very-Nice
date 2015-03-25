//
//  SecondViewController.m
//  AKTabBar Example
//
//  Created by Ali KARAGOZ on 04/05/12.
//  Copyright (c) 2012 Ali Karagoz. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Tag";
    }
    return self;
}

- (NSString *)tabImageName
{
	return @"image-2";
}

@end
