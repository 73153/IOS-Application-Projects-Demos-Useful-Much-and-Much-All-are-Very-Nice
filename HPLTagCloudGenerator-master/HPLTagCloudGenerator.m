//
//  HPLTagCloudGenerator.m
//  Awkward
//
//  Created by Matthew Conlen on 5/8/13.
//  Copyright (c) 2013 Huffington Post Labs. All rights reserved.
//

#import "HPLTagCloudGenerator.h"
#import <math.h>

@interface HPLTagCloudGenerator () {
    int spiralCount;
}

@end

@implementation HPLTagCloudGenerator

- (id) init {
    self = [super init];
    spiralCount = 0;
    self.spiralStep = 0.35;
    self.a = 5;
    self.b = 6;
    return self;
}

- (CGPoint) getNextPosition {

    float angle = self.spiralStep * spiralCount++;

    float offsetX = self.size.width/2;
    float offsetY = self.size.height/2;
    int x = (self.a + self.b*angle)*cos(angle);
    int y = (self.a + self.b*angle)*sin(angle);

    return CGPointMake(x+offsetX,y+offsetY);
}

- (BOOL) checkIntersectionWithView:(UIView *)checkView viewArray:(NSArray*)viewArray {
    for (UIView *view in viewArray) {
        if(CGRectIntersectsRect(checkView.frame, view.frame)) {
            return YES;
        }
    }
    return NO;
}


- (NSArray *)generateTagViews {
    float maxFontsize = 60.0;

    NSMutableDictionary *smoothedTagDict = [NSMutableDictionary dictionaryWithDictionary:self.tagDict];

    NSMutableArray *tagViews = [[NSMutableArray alloc] init];

    NSArray *sortedTags = [self.tagDict keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        int v1 = [obj1 intValue];
        int v2 = [obj2 intValue];
        if (v1 > v2)
            return NSOrderedAscending;
        else if (v1 < v2)
            return NSOrderedDescending;
        else
            return NSOrderedSame;
    }];

    // Smooth the Values
    // Artifically ensure that the count of any tags is always distinct...
    //
    //
    // e.g.
    //      tag1 ~> 1
    //      tag2 ~> 1
    //      tag3 ~> 1
    //      tag4 ~> 1
    //
    // becomes
    //      tag1 ~> 1
    //      tag2 ~> 2
    //      tag3 ~> 3
    //      tag4 ~> 4
    //
    // so that things look nicer

    for(int i=[sortedTags count]-1; i>0; i--) {
        int curVal = [(NSNumber *) [smoothedTagDict objectForKey:[sortedTags objectAtIndex:i]] intValue];
        int nextVal = [(NSNumber *) [smoothedTagDict objectForKey:[sortedTags objectAtIndex:i-1]] intValue];

        if(nextVal <= curVal) {
            nextVal = curVal+1;
            [smoothedTagDict setValue:[NSNumber numberWithInt:nextVal] forKey:[sortedTags objectAtIndex:i-1]];
        }
    }

    int max = [(NSNumber *) [smoothedTagDict objectForKey:[sortedTags objectAtIndex:0]] intValue];
    int min = [(NSNumber *) [smoothedTagDict objectForKey:[sortedTags objectAtIndex:[sortedTags count]-1]] intValue];
    min--;

    CGFloat maxWidth = [[UIScreen mainScreen] bounds].size.width - 30;

    for (NSString *tag in sortedTags) {

        int count = [(NSNumber *) [smoothedTagDict objectForKey:tag] intValue];
        float fontSize = ceilf(maxFontsize * (count - min) / (max - min)) + 5;

        UIFont *tagFont = [UIFont systemFontOfSize:fontSize];
        CGSize size = [tag sizeWithFont:tagFont];

        while (size.width >= maxWidth) {
            maxFontsize-=2;
            fontSize = ceilf(maxFontsize * (count - min) / (max - min)) + 5;

            tagFont = [UIFont systemFontOfSize:fontSize];
            size = [tag sizeWithFont:tagFont];
        }

        // check intersections
        CGPoint center = [self getNextPosition];
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(center.x - size.width/2, center.y - size.height/2, size.width, size.height)];


        tagLabel.text = tag;
        tagLabel.font = tagFont;

        while([self checkIntersectionWithView:tagLabel viewArray:tagViews]) {
            CGPoint center = [self getNextPosition];
            tagLabel.frame = CGRectMake(center.x - size.width/2, center.y - size.height/2, size.width, size.height);
        }

        [tagViews addObject:tagLabel];
    }

    return tagViews;
}



@end
