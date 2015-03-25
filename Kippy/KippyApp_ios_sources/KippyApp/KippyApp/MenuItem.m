//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "MenuItem.h"
#import "TapButton.h"
#import "TapUtils.h"

@implementation MenuItem

@synthesize notificationName;

- (id)initWithIcon:(NSString*)iconCode label:(NSString*)labelText notificationName:(NSString*)name {
    self = [super initWithFrame:CGRectMake(0, 0, 44, 276)];
    if (self) {
      icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconCode]];
      [self addSubview:icon];
      icon.frame = CGRectMake(0, 0, 44, 44);
      label = [[UILabel alloc] init];
      label.backgroundColor = [UIColor clearColor];
      label.textColor = [UIColor whiteColor];
      label.text = labelText;
      label.textAlignment = NSTextAlignmentLeft;
      label.font = [UIFont fontWithName:@"DINEngschrift" size:22];
      [self addSubview:label];
      label.frame = CGRectMake(44, 0, 276-44, 44);
      UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 276, 44)];
      [btn addTarget:self action:@selector(tapMe) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:btn];
      self.notificationName = name;
      UIView* line = [[UIView alloc] initWithFrame:CGRectMake(10,43, 256, 1)];
      [self addSubview:line];
      line.backgroundColor = HEXACOLOR(0xffffff, 0.1);
    }
    return self;
}

-(void)tapMe {
  [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
}

@end
