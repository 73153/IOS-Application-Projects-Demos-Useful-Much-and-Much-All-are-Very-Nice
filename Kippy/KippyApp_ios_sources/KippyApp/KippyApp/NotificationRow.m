//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "NotificationRow.h"
#import "TapNetworkImageView.h"
#import "AppLabel.h"

@implementation NotificationRow

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
      self.backgroundColor = [UIColor whiteColor];
      TapNetworkImageView* icon = [[TapNetworkImageView alloc] initWithFrame:CGRectMake(10, (88-24)/2, 24, 24) url:[NSString stringWithFormat:@"%@%@", SERVER_URL, [dictionary objectForKey:@"img_src"]]];
      [self addSubview:icon];
      AppLabel* row1 = [[AppLabel alloc] initWithStyle:AppLabelStyleBlueLeft];
      row1.frame = CGRectMake(44, 5, 320-44, 22);
      [self addSubview:row1];
      [row1 set:[NSString stringWithFormat:@"%@ - %@",  [dictionary objectForKey:@"date"],  [dictionary objectForKey:@"time"]]];
      AppLabel* row2 = [[AppLabel alloc] initWithStyle:AppLabelStyleBlueLeft];
      row2.frame = CGRectMake(44, 22, 320-44, 44);
      [self addSubview:row2];
      [row2 set:[NSString stringWithFormat:@"%@",  [dictionary objectForKey:@"text"]]];
    }
    return self;
}

@end
