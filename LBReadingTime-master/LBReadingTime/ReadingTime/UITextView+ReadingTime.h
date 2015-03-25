//
//  UITextView+WordCount.h
//  MinutesLeft
//
//  Created by Luca Bernardi on 17/02/13.
//  Copyright (c) 2013 Luca Bernardi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (ReadingTime)

@property (nonatomic) BOOL enableReadingTime;
@property (nonatomic) NSUInteger wordsPerMinute;
@property (nonatomic, readonly) NSUInteger numberOfWords;

- (NSUInteger)readingTime;
- (NSUInteger)remainingReadingTime;

@end
