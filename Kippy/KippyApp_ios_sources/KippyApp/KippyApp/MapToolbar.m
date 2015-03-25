//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "MapToolbar.h"
#import "KippyItem.h"

@implementation MapToolbar

- (id)initWithDictionary:(NSDictionary *)dictionary {
  self = [super initWithDictionary:dictionary];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
    bg = [[UIImageView alloc] init];
    [self addSubview:bg];
    bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_toolbar.png"]];

    kippy = [[KippyItem alloc] initWithDictionary:dictionary type:KippyItemTypeMap];
    [kippy setup];
    //kippy.userInteractionEnabled = NO;
    [self addSubview:kippy];

    btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0,0,108,45)];
    [btn1 setImage:[UIImage imageNamed:@"tab1_off.png"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"tab1_on.png"] forState:UIControlStateSelected];
    [btn1 addTarget:self action:@selector(selectTab1) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn1];
    btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0,0,108,45)];
    [btn2 setImage:[UIImage imageNamed:@"tab2_off.png"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"tab2_on.png"] forState:UIControlStateSelected];
    [btn2 addTarget:self action:@selector(selectTab2) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn2];
    btn3 = [[UIButton alloc] initWithFrame:CGRectMake(0,0,108,45)];
    [btn3 setImage:[UIImage imageNamed:@"tab3_off.png"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"tab3_on.png"] forState:UIControlStateSelected];
    [btn3 addTarget:self action:@selector(selectTab3) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn3];
    btn1.selected = YES;
    if(self.info == nil) {
      btn2.alpha = btn3.alpha = 0.2;
      btn2.userInteractionEnabled = btn3.userInteractionEnabled = NO;
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityOn) name:@"ProximityOn" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityOff) name:@"proximityOff" object:nil];
  }
  return self;
}

-(void)proximityOff {
  btn2.alpha = 0.2;
  btn2.userInteractionEnabled = NO;
}

-(void)proximityOn {
  btn2.alpha = 1;
  btn2.userInteractionEnabled = YES;
}

-(void)selectTab1 {
  btn1.selected = YES;
  btn2.selected = NO;
  btn3.selected = NO;
  [[NSNotificationCenter defaultCenter] postNotificationName:@"TabChanged" object:@"1"];
}

-(void)selectTab2 {
  btn1.selected = NO;
  btn2.selected = YES;
  btn3.selected = NO;
  [[NSNotificationCenter defaultCenter] postNotificationName:@"TabChanged" object:@"2"];
}

-(void)selectTab3 {
  btn1.selected = NO;
  btn2.selected = NO;
  btn3.selected = YES;
  [[NSNotificationCenter defaultCenter] postNotificationName:@"TabChanged" object:@"3"];
}

-(void)layoutSubviews {
  CGSize size = self.frame.size;
  bg.frame = CGRectMake(0,size.height-45,size.width,45);
  kippy.frame = CGRectMake(0,0,size.width,80);
  btn1.frame = CGRectMake((size.width-320)/2-2,size.height-45,108,45);
  btn2.frame = CGRectMake((size.width-320)/2-2+108,size.height-45,108,45);
  btn3.frame = CGRectMake((size.width-320)/2-2+108*2,size.height-45,108,45);
}

@end
