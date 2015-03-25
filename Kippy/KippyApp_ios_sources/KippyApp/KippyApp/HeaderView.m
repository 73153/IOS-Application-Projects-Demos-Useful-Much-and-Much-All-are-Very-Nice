//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapUtils.h"
#import "HeaderView.h"

@implementation HeaderView

- (id)initWithKippy:(NSDictionary*)dictionary {
  self = [super init];
  if (self) {
    self.backgroundColor = HEXCOLOR(0x243d4b);
    btnSettings = [[UIButton alloc] initWithFrame:CGRectMake(0,0,44,44)];
    [btnSettings setImage:[UIImage imageNamed:@"btn_settings.png"] forState:UIControlStateNormal];
    [btnSettings addTarget:self action:@selector(openSettings) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnSettings];
    btnList = [[UIButton alloc] initWithFrame:CGRectMake(0,0,44,44)];
    [btnList setImage:[UIImage imageNamed:@"btn_list.png"] forState:UIControlStateNormal];
    [btnList addTarget:self action:@selector(openList) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnList];
    [self createLabel:nil];
  }
  return self;
}

- (id)initWithTitle:(NSString*)title {
    self = [super init];
    if (self) {
      btnList = nil;
      self.backgroundColor = HEXCOLOR(0x243d4b);
      btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0,0,44,44)];
      [btnBack setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
      [btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:btnBack];
      [self createLabel:title];
    }
    return self;
}

-(void)createLabel:(NSString*)text {
  label = [[UILabel alloc] init];
  label.backgroundColor = [UIColor clearColor];
  label.textColor = [UIColor whiteColor];
  label.text = text;
  label.textAlignment = NSTextAlignmentCenter;
  label.font = [UIFont fontWithName:@"DINEngschrift" size:22];
  [self addSubview:label];
}

-(void)layoutSubviews {
  CGSize size = self.frame.size;
  label.frame = CGRectMake(0, 0, size.width, size.height);
  if(btnList != nil) {
    btnList.frame = CGRectMake(size.width-btnList.frame.size.width, 0, btnList.frame.size.width, btnList.frame.size.height);
  }
}

-(void)back {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"Back" object:nil];
}

-(void)openSettings {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"ToggleSettings" object:nil];
}

-(void)openList {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"ToggleKippyList" object:nil];
}

@end
