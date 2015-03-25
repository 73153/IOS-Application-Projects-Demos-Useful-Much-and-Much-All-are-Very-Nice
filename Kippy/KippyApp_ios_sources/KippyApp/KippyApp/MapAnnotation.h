//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject<MKAnnotation> {
  CLLocationCoordinate2D coordinate;
  NSDictionary* info;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSDictionary* info;

- (id) initWithDictionary:(NSDictionary*)dictionary;

@end
