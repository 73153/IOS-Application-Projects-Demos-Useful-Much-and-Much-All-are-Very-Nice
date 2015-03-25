//
//  ABCalendarPickerDefaultSeasonedMonthProvider.h
//  ABCalendarPicker
//
//  Created by Anton Bukov on 28.06.12.
//  Copyright (c) 2013 Anton Bukov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABCalendarPickerDateProviderProtocol.h"

@interface ABCalendarPickerDefaultSeasonedMonthsProvider : NSObject<ABCalendarPickerDateProviderProtocol>

@property (weak,nonatomic) id<ABCalendarPickerDateOwner> dateOwner;

- (NSInteger)canDiffuse;

- (ABCalendarPickerAnimation)animationForPrev;
- (ABCalendarPickerAnimation)animationForNext;
- (ABCalendarPickerAnimation)animationForZoomInToProvider:(id<ABCalendarPickerDateProviderProtocol>)provider;
- (ABCalendarPickerAnimation)animationForZoomOutToProvider:(id<ABCalendarPickerDateProviderProtocol>)provider;

- (NSDate*)dateForPrevAnimation;
- (NSDate*)dateForNextAnimation;

- (NSInteger)rowsCount;
- (NSInteger)columnsCount;
- (NSString*)columnName:(NSInteger)column;
- (NSString*)titleText;

- (NSDate*)dateForRow:(NSInteger)row andColumn:(NSInteger)column;
- (NSString*)labelForDate:(NSDate*)date;
- (UIControlState)controlStateForDate:(NSDate*)date;
- (NSString*)labelForRow:(NSInteger)row andColumn:(NSInteger)column;
- (UIControlState)controlStateForRow:(NSInteger)row andColumn:(NSInteger)column;

@property (strong,nonatomic) NSCalendar * calendar;

@property (strong,nonatomic) NSString * winterLabel;
@property (strong,nonatomic) NSString * springLabel;
@property (strong,nonatomic) NSString * summerLabel;
@property (strong,nonatomic) NSString * autumnLabel;

@end
