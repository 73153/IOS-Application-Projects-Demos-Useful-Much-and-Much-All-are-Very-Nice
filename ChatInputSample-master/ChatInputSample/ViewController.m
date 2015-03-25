//
//  ViewController.m
//  AutoGrowingTextInput
//
//  Created by Marat Alekperov (m.alekperov@gmail.com) on 18.11.12.
//  Copyright (c) 2012 Me and Myself. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end


@implementation ViewController


- (void) viewDidLoad {
   
   [super viewDidLoad];
	
   _chatInput.backgroundColor = [UIColor clearColor];
   _chatInput.inputBackgroundView.image = [[UIImage imageNamed:@"Chat_Footer_BG.png"] stretchableImageWithLeftCapWidth:80 topCapHeight:25];
   
	[_chatInput.attachButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_ArrowUp.png"] forState:UIControlStateNormal];
	[_chatInput.attachButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_ArrowUp_Pressed.png"] forState:UIControlStateHighlighted];
	[_chatInput.attachButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_ArrowUp_Pressed.png"] forState:UIControlStateSelected];
   
	[_chatInput.emojiButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_Smiley_Icon.png"] forState:UIControlStateNormal];
	[_chatInput.emojiButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_Smiley_Icon_Pressed.png"] forState:UIControlStateHighlighted];
	[_chatInput.emojiButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_Smiley_Icon_Pressed.png"] forState:UIControlStateSelected];

   [_chatInput.sendButton setBackgroundImage:[UIImage imageNamed:@"Chat_Send_Button.png"] forState:UIControlStateNormal];
	[_chatInput.sendButton setBackgroundImage:[UIImage imageNamed:@"Chat_Send_Button_Pressed.png"] forState:UIControlStateHighlighted];
	[_chatInput.sendButton setBackgroundImage:[UIImage imageNamed:@"Chat_Send_Button_Pressed.png"] forState:UIControlStateSelected];
	[_chatInput.sendButton setTitle:@"Send" forState:UIControlStateNormal];
}

- (void) didReceiveMemoryWarning {
   
   [super didReceiveMemoryWarning];
}

- (void) dealloc {
   
   [_textView release];
   [_chatInput release];
   [_emojiInputView release];
   [super dealloc];
}

- (void) viewDidUnload {
   
   [self setTextView:nil];
   [self setChatInput:nil];
   [self setEmojiInputView:nil];
   [super viewDidUnload];
}

- (void) sendButtonPressed:(id)sender {
   
   _textView.text = _chatInput.textView.text;
   
   _chatInput.textView.text = @"";
   [_chatInput fitText];
}


- (void) showEmojiInput:(id)sender {
   
   _chatInput.textView.inputView = _chatInput.textView.inputView == nil ? _emojiInputView : nil;
   
   [_chatInput.textView reloadInputViews];
}

- (void) returnButtonPressed:(id)sender {
   
   _textView.text = [sender text];
   
   _chatInput.textView.text = @"";
   [_chatInput fitText];
}

@end
