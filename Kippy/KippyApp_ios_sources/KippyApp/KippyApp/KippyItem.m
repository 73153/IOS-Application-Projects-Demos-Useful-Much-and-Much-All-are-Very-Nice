//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "KippyItem.h"
#import "TapNetworkImageView.h"
#import "TapUtils.h"
#import "AppDelegate.h"

@implementation KippyItem

@synthesize type;

- (id)initWithDictionary:(NSDictionary *)dictionary type:(KippyItemType)kippyType {
  self = [super initWithDictionary:dictionary];
  if (self) {
    self.type = kippyType;
    if(self.type == KippyItemTypeList) {
      self.backgroundColor = [UIColor whiteColor];
    } else {
      self.backgroundColor = [UIColor whiteColor];
    }
    photo = nil;
    photoMask = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kippy_photo_mask.png"]];
    [self addSubview:photoMask];
    signalBg = [[UIView alloc] init];
    [self addSubview:signalBg];
    batteryBg = [[UIView alloc] init];
    [self addSubview:batteryBg];
    geofenceBg = [[UIView alloc] init];
    [self addSubview:geofenceBg];
    signalIco = [[UIImageView alloc] initWithFrame:CGRectMake((60-26)/2,0,26,26)];
    [signalBg addSubview:signalIco];
    batteryIco = [[UIImageView alloc] initWithFrame:CGRectMake((60-26)/2,0,26,26)];
    [batteryBg addSubview:batteryIco];
    geofenceIco = [[UIImageView alloc] initWithFrame:CGRectMake((60-26)/2,0,26,26)];
    geofenceIco.image = [UIImage imageNamed:@"ico_geofence.png"];
    [geofenceBg addSubview:geofenceIco];
    btn = [[UIButton alloc] init];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(openMe) forControlEvents:UIControlEventTouchUpInside];
    if(self.type == KippyItemTypeMap) {
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(incomingKippyList:) name:@"IncomingKippyList" object:nil];
    }
    if(self.info == nil) {
      addKippy = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add_kippy.png"]];
      [self addSubview:addKippy];
      signalBg.alpha = 0;
      geofenceBg.alpha = 0;
      geofenceIco.alpha = 0;
      batteryBg.alpha = 0;
      [self update];
    } else {
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update:) name:@"KippyDataChanged" object:nil];
    }
  }
  return self;
}

-(void)update:(NSNotification*)notification {
  [self setup];
}

-(void)incomingKippyList:(NSNotification*)notification {
  if(![[notification.object objectForKey:@"data"] isKindOfClass:[NSNull class]]) {
    for(NSDictionary* dictionary in [notification.object objectForKey:@"data"]) {
      if([[dictionary objectForKey:@"id"] longLongValue] == [[self.info objectForKey:@"id"] longLongValue]) {
        self.info = dictionary;
        [self update];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KippyMoved" object:self.info];
      }
    }
  }
  [self setNeedsLayout];
}

-(void)openMe {
  if(self.info == nil) {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KippyAdd" object:nil];
  } else {
    if(self.type == KippyItemTypeMap) {
      [[NSNotificationCenter defaultCenter] postNotificationName:@"KippyProfile" object:self.info];
    } else {
      [[NSUserDefaults standardUserDefaults]  setObject:[NSNumber numberWithInt:self.tag] forKey:@"lastKippy"];
      [[NSUserDefaults standardUserDefaults] synchronize];
      [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectKippy" object:self.info];
    }
  }
}

-(void)layoutSubviews {
  CGSize size = self.frame.size;
  btn.frame = CGRectMake(0,0,size.width,size.height);
  signalBg.frame = CGRectMake(size.width-60,0,60,26);
  batteryBg.frame = CGRectMake(size.width-60,27,60,27);
  geofenceBg.frame = CGRectMake(size.width-60,1+27*2,60,26);
  for(UIView* view in [self subviews]) {
    if([view isKindOfClass:[UIWebView class]]) {
      view.frame = CGRectMake(90,4,size.width-160,72);
    }
  }
}

-(void)setup {
  if(photo != nil) {
    [photo removeFromSuperview];
  }
  photo = [[TapNetworkImageView alloc] initWithFrame:CGRectMake(0,0,80,80) url:[NSString stringWithFormat:@"%@/%@", SERVER_URL, [info objectForKey:@"img_src"]]];
  [self addSubview:photo];
  [photo sendSubviewToBack:photo];
  [self update];
}

-(void)update {
  int green = 0x8dc63f;
  int red = 0xff0000;
  int gray = 0x919ea5;
  for(UIView* view in [self subviews]) {
    if([view isKindOfClass:[UIWebView class]]) {
      [view removeFromSuperview];
    }
  }
  signalBg.backgroundColor = HEXCOLOR(green);
  batteryBg.backgroundColor = HEXCOLOR(green);
  geofenceBg.backgroundColor = HEXCOLOR(green);
  if([info objectForKey:@"geofence_id"] == nil || [[info objectForKey:@"geofence_id"] isKindOfClass:[NSNull class]]) {
    geofenceBg.backgroundColor = HEXCOLOR(gray);
  }
  int signal = 0;
  if(![[info objectForKey:@"signal_strength"] isKindOfClass:[NSNull class]]) {
    signal = ([[info objectForKey:@"signal_strength"] intValue]+115)*100/(115+52);
  }
  if(signal < 25) {
    signalBg.backgroundColor = HEXCOLOR(red);
  }
  int battery = 0;
  if(![[info objectForKey:@"battery"] isKindOfClass:[NSNull class]]) {
    battery = [[info objectForKey:@"battery"] intValue];
  }
  if(battery < 25) {
    batteryBg.backgroundColor = HEXCOLOR(red);
  }
  signalIco.image = [UIImage imageNamed:[NSString stringWithFormat:@"ico_signal%d.png", signal/25+1]];
  batteryIco.image = [UIImage imageNamed:[NSString stringWithFormat:@"ico_battery%d.png", battery/25+1]];

  NSString* time = @"Unknown";
  if(![[info objectForKey:@"last_update"] isKindOfClass:[NSNull class]]) {
    NSDate* date1 = [NSDate date];
    NSDate* date2 = [TapUtils string2date:[info objectForKey:@"last_update"] format:@"dd/MM/yyyy HH:mm:ss" locale:@"it"];
    NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
    int value = distanceBetweenDates/60;
    if(value < 60) {
      time = [NSString stringWithFormat:@"%d minutes ago", value];
    } else {
      value = value/60;
      if(value < 60) {
        time = [NSString stringWithFormat:@"%d hours ago", value];
      } else {
        value = value/24;
        time = [NSString stringWithFormat:@"%d days ago", value];
      }
    }
  }
  double lat = 0;
  double lng = 0;
  if(![[info objectForKey:@"lat"] isKindOfClass:[NSNull class]]) {
    lat = [[info objectForKey:@"lat"] doubleValue];
  }
  if(![[info objectForKey:@"lng"] isKindOfClass:[NSNull class]]) {
    lng = [[info objectForKey:@"lng"] doubleValue];
  }
  if(lat != 0 && lng != 0 && type == KippyItemTypeMap) {
    CLLocation* location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    [[[self app] geoCoder] reverseGeocodeLocation: location completionHandler:
     ^(NSArray *placemarks, NSError *error) {
       CLPlacemark *placemark = [placemarks objectAtIndex:0];
       NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
       if(locatedAt == nil) {
         locatedAt = @"Unknown";
       }
       UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,160,72)];
       webView.userInteractionEnabled = NO;
       NSString* html = @"<html><body style='font-family:DINEngschrift;background-color:white;color:black;margin:0px'>";
       html = [html stringByAppendingFormat:@"<div style='font-size:16px'>%@</div>", [info objectForKey:@"name"]];
       html = [html stringByAppendingFormat:@"<div style='font-size:12px'>%@</div>", locatedAt];
       html = [html stringByAppendingFormat:@"<div style='font-size:12px'><span style='font-family:FontAwesome'>&#xF017;</span> %@</div>", [info objectForKey:@"last_update"]];
       html = [html stringByAppendingString:@"</body></html>"];
       [webView loadHTMLString:html baseURL:nil];
       [self addSubview:webView];
       [self setNeedsLayout];
     }];
  } else {
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,160,72)];
    webView.userInteractionEnabled = NO;
    NSString* html = @"<html><body style='font-family:DINEngschrift;background-color:white;color:black;margin:0px'>";
    if(self.info != nil) {
      html = [html stringByAppendingFormat:@"<div style='font-size:16px'>%@</div>", [info objectForKey:@"name"]];
      html = [html stringByAppendingFormat:@"<div style='font-size:12px'><span style='font-family:FontAwesome'>&#xF017;</span> %@</div>", [info objectForKey:@"last_update"]];
    } else {
      html = [html stringByAppendingFormat:@"<div style='font-size:16px'><br>%@</div>", @"ADD A NEW KIPPY PET"];
      html = [html stringByAppendingFormat:@"<div style='font-size:12px'>%@</div>", @"Add a new device to track"];
    }
    html = [html stringByAppendingString:@"</body></html>"];
    [webView loadHTMLString:html baseURL:nil];
    [self addSubview:webView];
    [self setNeedsLayout];
  }
  [self sendSubviewToBack:photo];
  [self layoutSubviews];
}

@end
