//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface GeofenceVertexAnnotation : NSObject<MKAnnotation> {
  CLLocationCoordinate2D coordinate;
  NSDictionary* info;
  int vertexIndex;
}

@property (nonatomic,readwrite,assign) CLLocationCoordinate2D   coordinate;
@property (nonatomic, copy) NSDictionary* info;

- (id) initWithIndex:(int)index;

@end
