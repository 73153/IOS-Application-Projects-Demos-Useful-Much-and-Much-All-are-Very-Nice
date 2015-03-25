//
//  MyAnnotation.h
//  kingpin
//
//  Created by Bryan Bonczek on 1/17/13.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

@end
