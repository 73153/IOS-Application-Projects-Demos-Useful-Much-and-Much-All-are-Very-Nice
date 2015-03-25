//
//  NLImageShowCaseCell.h
//  ImageShowcase
//
// Copyright © 2012, Mirza Bilal (bilal@mirzabilal.com)
// All rights reserved.
//  Permission is hereby granted, free of charge, to any person obtaining a copy
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
// 1.	Redistributions of source code must retain the above copyright notice,
//       this list of conditions and the following disclaimer.
// 2.	Redistributions in binary form must reproduce the above copyright notice,
//       this list of conditions and the following disclaimer in the documentation
//       and/or other materials provided with the distribution.
// 3.	Neither the name of Mirza Bilal nor the names of its contributors may be used
//       to endorse or promote products derived from this software without specific
//       prior written permission.
// THIS SOFTWARE IS PROVIDED BY MIRZA BILAL "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL MIRZA BILAL BE LIABLE FOR
// ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
// IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
// ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <Foundation/Foundation.h>
#import "NLImageShowcaseCellDelegate.h"
@interface NLImageShowCaseCell : UIView
{
    @private
    id<NLImageShowcaseCellDelegate> __unsafe_unretained _cellDelegate;
    UIImage* _image;
    UIButton* _deleteButton;
    UIButton* _mainImage;
    NSTimer* _timer;
    NSInteger _index;
    BOOL _deleteMode;
}
@property (nonatomic, readonly) UIImage* image;
@property (nonatomic, unsafe_unretained) id<NLImageShowcaseCellDelegate> cellDelegate;
@property (nonatomic, readwrite) NSInteger index;
@property (nonatomic, readwrite) BOOL deleteMode;
- (id)initWithImage:(UIImage*)image;
- (id)setMainImage:(UIImage*)image;
- (IBAction)buttonClicked;
- (IBAction) deleteImage;
- (IBAction)touchCancel;
- (IBAction)touchDown;
- (IBAction)imagePushedLonger;

@end
