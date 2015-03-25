//
//  ViewController.h
//  AutoGrowingTextInput
//
//  Created by Marat Alekperov (m.alekperov@gmail.com) on 18.11.12.
//  Copyright (c) 2012 Me and Myself. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THChatInput.h"


@interface ViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextView *textView;

@property (retain, nonatomic) IBOutlet THChatInput *chatInput;
@property (retain, nonatomic) IBOutlet UIView *emojiInputView;

@end
