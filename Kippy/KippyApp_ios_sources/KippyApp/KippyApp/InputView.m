//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapUtils.h"
#import "InputView.h"

@implementation InputView

- (id)initWithLabel:(NSString*)title placeholder:(NSString*)placeholder  frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      label = [[UILabel alloc] init];
      label.backgroundColor = [UIColor clearColor];
      label.textColor = HEXCOLOR(0x005a84);
      label.text = title;
      label.textAlignment = NSTextAlignmentLeft;
      label.font = [UIFont boldSystemFontOfSize:14];
      [self addSubview:label];
      label.frame = CGRectMake(10, 0, frame.size.width/3-10, frame.size.height);

      input = [[UITextField alloc] init];
      input.autocorrectionType = UITextAutocorrectionTypeNo;
      input.placeholder = placeholder;
      [self addSubview:input];
      input.textAlignment = NSTextAlignmentRight;
      input.font = [UIFont systemFontOfSize:14];
      input.frame = CGRectMake(10+frame.size.width/3, 0, frame.size.width-frame.size.width/3-20, frame.size.height);

      input.delegate = self;

      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(standby) name:@"Standby" object:nil];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [input endEditing:YES];
  return NO;
}

-(void)standby {
  [input endEditing:YES];
}

-(UITextField*)input {
  return input;
}

@end
