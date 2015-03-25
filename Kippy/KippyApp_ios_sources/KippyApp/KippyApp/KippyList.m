//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "KippyList.h"
#import "KippyItem.h"
#import "TapUtils.h"
#import "HeaderView.h"

@implementation KippyList

- (id)init {
  self = [super init];
  if (self) {
    self.backgroundColor = HEXCOLOR(0xeeeeee);
    headerView = [[HeaderView alloc] initWithTitle:@"Kippy List"];
    [self addSubview:headerView];
    container = [[UIScrollView alloc] init];
    [self addSubview:container];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(incomingKippyList:) name:@"IncomingKippyList" object:nil];
  }
  return self;
}

-(void)incomingKippyList:(NSNotification*)notification {
  for(KippyItem* item in [container subviews]) {
    if([item isKindOfClass:[KippyItem class]]) {
      [item removeFromSuperview];
    }
  }
  int i = 0;
  if(![[notification.object objectForKey:@"data"] isKindOfClass:[NSNull class]]) {
    for(NSDictionary* dictionary in [notification.object objectForKey:@"data"]) {
      KippyItem* item = [[KippyItem alloc] initWithDictionary:dictionary type:KippyItemTypeList];
      item.tag = i;
      [item setup];
      [container addSubview:item];
      i++;
    }
  }
  KippyItem* item = [[KippyItem alloc] initWithDictionary:nil type:KippyItemTypeList];
  item.tag = i;
  [item setup];
  [container addSubview:item];
  [self setNeedsLayout];
}

-(void)layoutSubviews {
  CGSize size = self.frame.size;
  headerView.frame = CGRectMake(0, 0, size.width, 44);
  container.frame = CGRectMake(0, 44, size.width, size.height-44);
  int i = 0;
  for(KippyItem* item in [container subviews]) {
    if([item isKindOfClass:[KippyItem class]]) {
      item.frame = CGRectMake(0, 10+i*90, size.width, 80);
      i++;
    }
  }
  container.contentSize = CGSizeMake(size.width,i*90+10);
}

@end
