//
//  ABCalendarPickerDefaultMonthsProvider.h
//  ABCalendarPicker
//
//  Created by Anton Bukov on 27.06.12.
//  Copyright (c) 2013 Anton Bukov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABCalendarPickerDateProviderProtocol.h"

@interface ABCalendarPickerDefaultMonthsProvider : NSObject<ABCalendarPickerDateProviderProtocol>

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

@end
