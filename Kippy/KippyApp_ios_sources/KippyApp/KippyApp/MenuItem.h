//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "AppView.h"

@interface MenuItem : AppView {
  UIImageView* icon;
  UILabel* label;
  NSString* notifcationName;
}

@property (nonatomic, copy) NSString* notificationName;

- (id)initWithIcon:(NSString*)icon label:(NSString*)label notificationName:(NSString*)name;

@end
