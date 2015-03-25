//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "AppView.h"

@class TapNetworkImageView;

typedef NS_ENUM(NSInteger, KippyItemType) {
  KippyItemTypeList,
  KippyItemTypeMap
};

@interface KippyItem : AppView {
  UIImageView* photoMask;
  UIView* signalBg;
  UIView* batteryBg;
  UIView* geofenceBg;
  UIImageView* signalIco;
  UIImageView* batteryIco;
  UIImageView* geofenceIco;
  UIImageView* addKippy;

  UIButton* btn;

  KippyItemType type;

  TapNetworkImageView* photo;
}

@property KippyItemType type;

- (id)initWithDictionary:(NSDictionary *)dictionary type:(KippyItemType)kippyType;
-(void)setup;

@end
