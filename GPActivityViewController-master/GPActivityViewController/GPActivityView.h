//
// Copyright (c) 2013 Gleb Pinigin (https://github.com/gpinigin)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#import "GPActivity.h"

#ifdef __IPHONE_7_0
    #ifdef NSFoundationVersionNumber_iOS_6_1
        #define UI_IS_IOS7() (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
    #endif
#endif

#ifndef UI_IS_IOS7
    #define UI_IS_IOS7() (NO)
#endif



@protocol ActivityViewActionDelegate <NSObject>

@required
- (void)cancelButtonTapped;
- (void)activityTappedAtIndex:(NSUInteger)index;

@end


@interface GPActivityView : UIView

@property (nonatomic, unsafe_unretained) id<ActivityViewActionDelegate> delegate;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIButton *cancelButton;

- (id)initWithFrame:(CGRect)frame activities:(NSArray *)activities;

@end
