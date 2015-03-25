//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapUtils.h"
#import "MenuView.h"
#import "MenuItem.h"
#import "UserPhoto.h"

@implementation MenuView

- (id)init {
  self = [super init];
  if (self) {
    self.backgroundColor = HEXCOLOR(0x243d4b);
    photo = [[UserPhoto alloc] initWithWhiteMask:NO];
    [self addSubview:photo];
    logoIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_icon.png"]];
    [self addSubview:logoIcon];
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(10,100, 256, 1)];
    [self addSubview:line];
    line.backgroundColor = HEXACOLOR(0xffffff, 0.1);
    {
      MenuItem* item = [[MenuItem alloc] initWithIcon:@"ico_profile.png" label:@"Profile" notificationName:@"Profile"];
      [self addSubview:item];
    }
    {
      MenuItem* item = [[MenuItem alloc] initWithIcon:@"ico_notifications.png" label:@"Notification History" notificationName:@"Notifications"];
      [self addSubview:item];
    }
    {
      MenuItem* item = [[MenuItem alloc] initWithIcon:@"ico_tutorial.png" label:@"Tutorial" notificationName:@"Tutorial"];
      [self addSubview:item];
    }
    {
      MenuItem* item = [[MenuItem alloc] initWithIcon:@"ico_info.png" label:@"Help" notificationName:@"Info"];
      [self addSubview:item];
    }
    {
      MenuItem* item = [[MenuItem alloc] initWithIcon:@"ico_profile.png" label:@"Sign out" notificationName:@"Signout"];
      [self addSubview:item];
    }
  }
  return self;
}

-(void)layoutSubviews {
  CGSize size = self.frame.size;
  photo.frame = CGRectMake(10,10,80,80);
  logoIcon.frame = CGRectMake(0,0,logoIcon.frame.size.width,logoIcon.frame.size.height);
  logoIcon.center = CGPointMake(size.width/2,size.height-(size.height-44*4-100)/2);
  int i=0;
  for(MenuItem* item in [self subviews]) {
    if([item isKindOfClass:[MenuItem class]]) {
      item.frame = CGRectMake(0, 100+i*44, 276, 44);
      i++;
    }
  }
}

@end
