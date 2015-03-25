//
//  DSBarChart.h
//  DSBarChart
//
//  Created by DhilipSiva Bijju on 31/10/12.
//  Copyright (c) 2012 Tataatsu IdeaLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSBarChart : UIView

-(DSBarChart * )initWithFrame:(CGRect)frame
                        color:(UIColor*)theColor
                   references:(NSArray *)references
                    andValues:(NSArray *)values;

- (void) addInterestPointWithText:(NSString *) text inColumn:(NSInteger) column percentageInColumn:(CGFloat ) percentInColumn;

+ (NSInteger) maxValue:(NSArray *) sourceData;
+ (NSArray *) histogramData:(NSArray *) sourceData intoBuckets:(NSUInteger) bucketSize;

@property (nonatomic) float maxLen;
@property (nonatomic) BOOL shouldCalculateMaxValue;
@property (nonatomic) UIColor *color;
@property (nonatomic) NSArray* vals;
@property (nonatomic) NSArray* refs;
@property (nonatomic) BOOL showNumberValues;
@end
