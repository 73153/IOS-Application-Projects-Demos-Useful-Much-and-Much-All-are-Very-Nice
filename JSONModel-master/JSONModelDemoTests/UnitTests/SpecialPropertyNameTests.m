//
//  SpeicalPropertyNameTest.m
//  JSONModelDemo_OSX
//
//  Created by BB9z on 13-4-26.
//  Copyright (c) 2013年 Underplot ltd. All rights reserved.
//

#import "SpecialPropertyNameTests.h"
#import "SpecialPropertyModel.h"

@implementation SpecialPropertyNameTests

- (void)testSpecialPropertyName
{
    NSString* filePath = [[NSBundle bundleForClass:[JSONModel class]].resourcePath stringByAppendingPathComponent:@"specialPropertyName.json"];
    NSString* jsonContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    STAssertNotNil(jsonContents, @"Can't fetch test data file contents.");
    
    NSError* err;
    SpecialPropertyModel *p = [[SpecialPropertyModel alloc] initWithString: jsonContents error:&err];
    JMLog(@"%@", p);
    STAssertNotNil(p, @"Could not initialize model.");
    STAssertNil(err, [err localizedDescription]);
}
@end
