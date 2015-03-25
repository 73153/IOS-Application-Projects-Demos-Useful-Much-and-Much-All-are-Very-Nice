//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "FormInput.h"
#import "AppLabel.h"
#import "TapUtils.h"

@implementation FormInput

- (id)initWithLabel:(NSString*)s1 placeholder:(NSString*)s2 {
  self = [super init];
  if (self) {
    line = [[UIView alloc] init];
    line.backgroundColor = HEXCOLOR(0xeeeeee);
    [self addSubview:line];
    label = [[AppLabel alloc] initWithStyle:AppLabelStyleBlueLeft];
    [self addSubview:label];
    [label set:s1];
    input = [[UITextField alloc] init];
    input.font = [UIFont fontWithName:@"DINEngschrift" size:18];
    input.textAlignment = UITextAlignmentRight;
    //input.backgroundColor = [UIColor redColor];
    input.placeholder = s2;
    [self addSubview:input];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(standby) name:@"Standby" object:nil];
  }
  return self;
}

-(UITextField*)input {
  return input;
}

-(void)standby {
  [input endEditing:YES];
}

-(void)layoutSubviews {
  line.frame = CGRectMake(0,self.frame.size.height-1,self.frame.size.width,1);
  label.frame = CGRectMake(20,5,self.frame.size.width/2-40,self.frame.size.height);
  input.frame = CGRectMake(self.frame.size.width/2+20,12,self.frame.size.width/2-40,20);
}

@end
