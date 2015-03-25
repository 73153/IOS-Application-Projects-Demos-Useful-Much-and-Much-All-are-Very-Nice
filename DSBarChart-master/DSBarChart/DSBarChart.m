//
//  DSBarChart.m
//  DSBarChart
//
//  Created by DhilipSiva Bijju on 31/10/12.
//  Copyright (c) 2012 Tataatsu IdeaLabs. All rights reserved.
//

#import "DSBarChart.h"

@interface DSBarChartInterestPoint : NSObject

@property (nonatomic) NSInteger column;
@property (nonatomic) CGFloat percentInColumn;
@property (nonatomic) NSString * text;
@end

@implementation DSBarChartInterestPoint


@end

@interface DSBarChart ()

@property (nonatomic) NSMutableArray * interestPoints;

@end

@implementation DSBarChart


-(DSBarChart *)initWithFrame:(CGRect)frame
                       color:(UIColor *)theColor
                  references:(NSArray *)references
                   andValues:(NSArray *)values
{
    self = [super initWithFrame:frame];
    if (self) {
        self.shouldCalculateMaxValue = YES;
        self.color = theColor;
        self.vals = values;
        self.refs = references;
    }
    return self;
}

-(void)calculate{
    if(self.vals && self.refs)
    {
        NSAssert(self.vals.count == self.refs.count, @"expecting refs and vals to be the same size. found %i and %i", self.vals.count, self.refs.count);
    }
    for (NSNumber *val in self.vals) {
        float iLen = [val floatValue];
        if (iLen > self.maxLen) {
            self.maxLen = iLen;
        }
    }
}

- (void) addInterestPointWithText:(NSString *) text inColumn:(NSInteger) column percentageInColumn:(CGFloat ) percentInColumn
{
    if(self.interestPoints == nil)
    {
        self.interestPoints = [NSMutableArray array];
    }
    DSBarChartInterestPoint * interestPoint = [[DSBarChartInterestPoint alloc] init];
    interestPoint.column = column;
    interestPoint.percentInColumn = percentInColumn;
    interestPoint.text = text;
    
    [self.interestPoints addObject:interestPoint];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    /// Drawing code
    if(self.shouldCalculateMaxValue)
    {
        [self calculate];
    }
    for (UIView * subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    NSInteger numberOfBars = self.vals.count;
    float paddingBetweenBars = 0.0f;
    float lineWidth = 1.0f;
    float rectWidth = (float)(rect.size.width - (numberOfBars * paddingBetweenBars )) / (float)numberOfBars;
    CGContextRef context = UIGraphicsGetCurrentContext();
    float LBL_HEIGHT = 20.0f, iLen, x, heightRatio, height, y;
    UIColor * evenColumnsColor = [self.color colorWithAlphaComponent:0.25f];
    UIColor * oddColumnsColor = [self.color colorWithAlphaComponent:0.2f];
    /// Set color and draw the bar
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    CGContextSetFillColorWithColor(context, evenColumnsColor.CGColor);
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGPathMoveToPoint(pathRef, NULL, 0, rect.size.height);

    CGContextSetLineWidth(context, lineWidth/8);
    
    /// Draw Bars
    for (int barCount = 0; barCount < numberOfBars; barCount++) {
        
        /// Calculate dimensions
        NSNumber * value = [self.vals objectAtIndex:barCount];
        iLen = [value floatValue];
        x = barCount * (rectWidth);
        heightRatio = iLen / self.maxLen;
        height = heightRatio * (rect.size.height - lineWidth - LBL_HEIGHT);
        y = rect.size.height - height - LBL_HEIGHT;
        
        UIColor * columnColor = nil;
        if(barCount % 2 == 0)
        {
            columnColor = evenColumnsColor;
        }
        else
        {
            columnColor = oddColumnsColor;
        }
        
        if(self.refs)
        {
            /// Reference Label.
            UILabel *lblRef = [[UILabel alloc] initWithFrame:CGRectMake(x, rect.size.height - LBL_HEIGHT, rectWidth, LBL_HEIGHT)];
            lblRef.text = [self.refs objectAtIndex:barCount];
            lblRef.adjustsFontSizeToFitWidth = TRUE;
            lblRef.adjustsLetterSpacingToFitWidth = TRUE;
            lblRef.textColor = self.color;
            [lblRef setTextAlignment:NSTextAlignmentCenter];
            lblRef.backgroundColor = [UIColor clearColor];
            [self addSubview:lblRef];
        }
        
        if(self.showNumberValues  && ([value integerValue] != 0))
        {
            /// value Label
            CGFloat labelY = y ;
            if(rect.size.height - LBL_HEIGHT * 1.75f < labelY)
            {
                labelY = y - LBL_HEIGHT;
            }
            UILabel * valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, labelY, rectWidth, LBL_HEIGHT)];
            valueLabel.text = [NSString stringWithFormat:@"%@", [self.vals objectAtIndex:barCount]];
            valueLabel.adjustsFontSizeToFitWidth = TRUE;
            valueLabel.adjustsLetterSpacingToFitWidth = TRUE;
            valueLabel.textColor = [self.color colorWithAlphaComponent:.5];
            [valueLabel setTextAlignment:NSTextAlignmentCenter];
            valueLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:valueLabel];
        }
        
        CGPathAddLineToPoint(pathRef, NULL, x, y);
        CGPathAddLineToPoint(pathRef, NULL, x + rectWidth, y);

        CGRect barRect = CGRectMake(paddingBetweenBars + x, y, rectWidth, height);
        CGContextAddRect(context, barRect);
        
        CGContextSetFillColorWithColor(context, columnColor.CGColor);
        CGContextDrawPath(context, kCGPathFillStroke);
        
    }
    
    CGContextSetLineWidth(context, lineWidth);
    CGPathAddLineToPoint(pathRef, NULL, rect.size.width, rect.size.height);
    CGPathCloseSubpath(pathRef);
    CGContextAddPath(context, pathRef);
    CGContextDrawPath(context, kCGPathStroke);
    
//    /// pivot
//    UIColor * pivotColor = [UIColor redColor];
//    CGRect frame = CGRectZero;
//    frame.origin.x = rect.origin.x;
//    frame.origin.y = rect.origin.y - LBL_HEIGHT;
//    frame.size.height = LBL_HEIGHT;
//    frame.size.width = rect.size.width;
//    UILabel *pivotLabel = [[UILabel alloc] initWithFrame:frame];
//    pivotLabel.text = [NSString stringWithFormat:@"%d", (int)self.maxLen];
//    pivotLabel.backgroundColor = [UIColor clearColor];
//    pivotLabel.textColor = pivotColor;
//    [self addSubview:pivotLabel];
//    
//    /// A line
//    frame = rect;
//    frame.size.height = 0.25f;
//    CGContextSetFillColorWithColor(context, pivotColor.CGColor);
//    CGContextFillRect(context, frame);
    
    ///draw interest points
    CGContextSetLineWidth(context, lineWidth);
    for (DSBarChartInterestPoint * interestPoint in self.interestPoints) {
        CGFloat xPosition = paddingBetweenBars + (interestPoint.column + interestPoint.percentInColumn) * rectWidth;
        CGContextMoveToPoint(context, xPosition, 0);
        CGContextAddLineToPoint(context, xPosition, rect.size.height - LBL_HEIGHT);
        CGContextDrawPath(context, kCGPathStroke);
        
        
        /// value Label
        UILabel * valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPosition - 100, - LBL_HEIGHT, 200, LBL_HEIGHT)];
        valueLabel.text = [NSString stringWithFormat:@"%@", interestPoint.text];
        valueLabel.adjustsFontSizeToFitWidth = TRUE;
        valueLabel.adjustsLetterSpacingToFitWidth = TRUE;
        valueLabel.textColor = self.color;
        [valueLabel setTextAlignment:NSTextAlignmentCenter];
        valueLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:valueLabel];
    }
}

+ (NSInteger) maxValue:(NSArray *) sourceData
{
    NSInteger maxValue = NSIntegerMin;
    for (NSNumber * value in sourceData) {
        if(maxValue < [value integerValue])
        {
            maxValue = [value integerValue];
        }
    }
    return maxValue;
}

+ (NSArray *) histogramData:(NSArray *) rawData intoBuckets:(NSUInteger) bucketSize
{
    NSMutableArray * histogram = [NSMutableArray arrayWithCapacity:bucketSize];
    for (NSNumber * value in rawData) {
        NSInteger bucket = [value integerValue]/bucketSize;
        for(int ii = histogram.count; ii < bucket + 1; ii++)
        {
            [histogram addObject:@0];
        }
        NSNumber * exisitingCount = [histogram objectAtIndex:bucket];
        [histogram replaceObjectAtIndex:bucket withObject:[NSNumber numberWithInteger:[exisitingCount integerValue] + 1]];
    }
    
    return histogram;
}



@end
