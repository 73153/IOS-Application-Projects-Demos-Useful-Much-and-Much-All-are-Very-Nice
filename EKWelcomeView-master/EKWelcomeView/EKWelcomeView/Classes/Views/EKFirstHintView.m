//
//  EKFirstHintView.m
//  EKWelcomeView
//
//  Created by EvgenyKarkan on 09.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKFirstHintView.h"

@interface EKFirstHintView ()

@property (nonatomic, strong) UILabel *hint;

@end


@implementation EKFirstHintView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2f];
	}
	
	self.hint = [[UILabel alloc] init];
	self.hint.backgroundColor = [UIColor clearColor];
	self.hint.textAlignment = NSTextAlignmentCenter;
	self.hint.text = @"Here is your hints";
	self.hint.textColor = [UIColor whiteColor];
	[self addSubview:self.hint];
	
	return self;
}

- (void)layoutSubviews
{
	self.hint.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.frame.size.width, self.bounds.size.height / 10.0f);
}

@end
