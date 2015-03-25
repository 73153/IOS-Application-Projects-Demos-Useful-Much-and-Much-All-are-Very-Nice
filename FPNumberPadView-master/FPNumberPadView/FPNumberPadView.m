//
//  FPNumberPadView.m
//  FPNumberPadView
//
//  Created by Fabrizio Prosperi on 5/11/12.
//  Copyright (c) 2012 Absolutely iOS. All rights reserved.
//

// Permission is hereby granted, free of charge, to any person obtaining a copy of this
// software and associated documentation files (the "Software"), to deal in the Software
// without restriction, including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
// to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
// PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
// FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.

/*
 This is heavily inspired by the following post on Stack Overflow
 http://stackoverflow.com/questions/13205160/how-do-i-retrieve-keystrokes-from-a-custom-keyboard-on-an-ios-app
 */


#import "FPNumberPadView.h"

@interface FPNumberPadView () <UIInputViewAudioFeedback> {
    UITextField *_textField;
}
@property (nonatomic,assign) id<UITextInput>delegate;
@end

@implementation FPNumberPadView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadWithNIB];
    }
    return self;
}

- (UIView *)loadWithNIB {
    NSArray *aNib = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    UIView *view = [aNib objectAtIndex:0];
    [self addSubview:view];
    return view;
}

- (id<UITextInput>)delegate {
    return _textField;
}

- (UITextField *)textField {
    return _textField;
}

- (void)setTextField:(UITextField *)textField {
    _textField = textField;
    _textField.inputView = self;
}

- (IBAction)clicked:(UIButton *)sender {
    // search for an existing dot
    NSRange dot = [_textField.text rangeOfString:@"."];
    
    switch (sender.tag) {
        case 10:
            if (dot.location == NSNotFound) {
                // only 1 decimal dot allowed
                [self.delegate insertText:@"."];
                [[UIDevice currentDevice] playInputClick];
            }
            break;
        case 11:
            [self.delegate deleteBackward];
            [[UIDevice currentDevice] playInputClick];
            break;
        default:
            // max 2 decimals
            if (dot.location == NSNotFound || _textField.text.length <= dot.location + 2) {
                [self.delegate insertText:[NSString stringWithFormat:@"%d", sender.tag]];
                [[UIDevice currentDevice] playInputClick];
            }
            break;
    }
}

- (IBAction)done:(UIButton *)sender {
    // we are done with the field, let's dismiss the keyboard
    [_textField resignFirstResponder];
}

#pragma mark - UIInputViewAudioFeedback delegate

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}

@end
