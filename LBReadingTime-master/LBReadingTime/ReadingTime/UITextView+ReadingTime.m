//
//  UITextView+WordCount.m
//  MinutesLeft
//
//  Created by Luca Bernardi on 17/02/13.
//  Copyright (c) 2013 Luca Bernardi. All rights reserved.
//

#import "UITextView+ReadingTime.h"
#import <objc/runtime.h>

static const char * const WordsPerMinuteKey     = "WordsPerMinuteKey";
static const char * const NumberOfWordsKey      = "NumberOfWordsKey";
static const char * const EnableReadingTime     = "EnableReadingTime";

static NSUInteger const defaultWordsPerMinute   = 200;

@implementation UITextView (ReadingTime)

#pragma mark - Accessor

- (NSUInteger)wordsPerMinute
{
    id associateObj = objc_getAssociatedObject(self, WordsPerMinuteKey);
    if (associateObj == nil) {
        return defaultWordsPerMinute;
    }
    return [associateObj unsignedIntegerValue];
}

- (void)setWordsPerMinute:(NSUInteger)wordsPerMinute
{
    objc_setAssociatedObject(self, WordsPerMinuteKey, @(wordsPerMinute), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSUInteger)numberOfWords
{
    id associateObj = objc_getAssociatedObject(self, NumberOfWordsKey);
    return [associateObj unsignedIntegerValue];
}

- (void)setNumberOfWords:(NSUInteger)numberOfWords
{
    objc_setAssociatedObject(self, NumberOfWordsKey, @(numberOfWords), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)enableReadingTime
{
    id associateObj = objc_getAssociatedObject(self, EnableReadingTime);
    if (associateObj) {
        return [associateObj boolValue];
    }
    return YES;
}

- (void)setEnableReadingTime:(BOOL)enableReadingTime
{
    objc_setAssociatedObject(self, EnableReadingTime, @(enableReadingTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (enableReadingTime) {
        self.numberOfWords = [self computeNumberOfWords];
    }
}

#pragma mark - Toggle Reading Time

static Method originalSetText;
static Method mySetText;

+ (void)load
{
    originalSetText = class_getInstanceMethod([self class], @selector(setText:));
    mySetText       = class_getInstanceMethod([self class], @selector(readingTime_setText:));
    method_exchangeImplementations(originalSetText, mySetText);
}

- (void)readingTime_setText:(NSString *)text
{
    /* 
     Note: if the method implementation has been exchanged 
     by the swizzling (ensured by the _cmd == @selector(setText:)
     i can safely call this and execute the orinal setText: implementation
     */
    NSParameterAssert(_cmd == @selector(setText:));
    [self readingTime_setText:text];
    
    if (self.enableReadingTime) {
        self.numberOfWords = [self computeNumberOfWords];
    }
}

#pragma mark - Reading Time

- (NSUInteger)computeNumberOfWords
{
    __block NSUInteger wordCount = 0;

    [self.text enumerateSubstringsInRange:NSMakeRange(0, self.text.length)
                                  options:NSStringEnumerationByWords
                               usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                   wordCount++;
                               }];
    return wordCount;
}

- (NSUInteger)readingTime
{
    if ((self.wordsPerMinute == 0)
        || (self.numberOfWords == 0)) {
        return 0;
    }
    
    float readingTime = self.numberOfWords / (float)self.wordsPerMinute;
    NSUInteger readingTimeInMinute = (int)ceilf(readingTime);
    return readingTimeInMinute;
}

- (NSUInteger)remainingReadingTime
{
    CGRect bounds = self.bounds;
    
    UITextPosition *start = [self characterRangeAtPoint:bounds.origin].start;
    NSInteger offset      = [self offsetFromPosition:self.beginningOfDocument
                                          toPosition:start];
    
    float readingPercentage  = (float)offset / self.text.length;
    NSUInteger readingTime   = [self readingTime];
    NSUInteger remainingTime = (NSUInteger)ceilf(readingTime - (readingTime * readingPercentage));
    
    return remainingTime;
}

@end
