//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

@synthesize coordinate, info;

- (id) initWithDictionary:(NSDictionary*)dictionary {
  self = [super init];
  if (self) {
    self.info = dictionary;
    coordinate.latitude =  [[dictionary objectForKey:@"lat"] floatValue];
    coordinate.longitude = [[dictionary objectForKey:@"lng"] floatValue];
  }
  return self;
}

- (NSString *)title {
  return [NSString stringWithFormat:@"%@", [self.info objectForKey:@"title"]];
}

- (NSString *)subtitle {
  return [NSString stringWithFormat:@"%@", [self.info objectForKey:@"description"]];
}

@end
