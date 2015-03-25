//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "NotificationsView.h"
#import "NotificationRow.h"
#import "AppDelegate.h"

@implementation NotificationsView

- (id)initWithTitle:(NSString *)title {
  self = [super initWithTitle:title];
  if (self) {
    container = [[UIScrollView alloc] init];
    [self addSubview:container];
  }
  return self;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  CGSize size = self.frame.size;
  container.frame = CGRectMake(0, 44, size.width, size.height-44);
}

-(void)setup:(NSDictionary*)dictionary {
  [spinner startAnimating];
  for(NotificationRow* row in [container subviews]) {
    if([row isKindOfClass:[NotificationRow class]]) {
      [row removeFromSuperview];
    }
  }
  container.contentOffset = CGPointMake(0,0);
  //NSLog(@"-----%@-----", [dictionary objectForKey:@"id"]);
  [[self app] downloadResource:[NSString stringWithFormat:@"%@kippymap_getNotificationsList.php?app_code=%@&app_verification_code=%@&kippy_id=%@", SERVER_URL, [self app].appCode, [self app].appVerificationCode, [dictionary objectForKey:@"id"]] sender:self];
}

-(void)downloadResourceSuccess:(ASIHTTPRequest*)request {
  [spinner stopAnimating];
  NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[request responseData] options: NSJSONReadingMutableContainers error: nil];
  int i=0;
  for(NSDictionary* dict in [dictionary objectForKey:@"notification_list"]) {
    NotificationRow* row = [[NotificationRow alloc] initWithDictionary:dict];
    row.frame = CGRectMake(0, 88*i, 320, 87);
    [container addSubview:row];
    i++;
  }
  container.contentSize = CGSizeMake(320,i*88);
}


-(void)downloadResourceFailed:(ASIHTTPRequest*)request {
  [spinner stopAnimating];
}

@end
