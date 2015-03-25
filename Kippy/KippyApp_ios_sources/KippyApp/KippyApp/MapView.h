//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "TapView.h"
#import <MapKit/MapKit.h>

@class HeaderView;
@class MapToolbar;
@class Proximity;
@class GeofenceData;
@class AppLabel;

@interface MapView : TapView<MKMapViewDelegate> {
  HeaderView* headerView;
  MKMapView* map;
  MapToolbar* toolbar;
  UIButton* btnMe;
  UIButton* btnKippy;
  UIButton* ftBtn;
  UIButton* geofenceBtn;
  UIButton* geofenceAddBtn;
  UIView* petDirection;
  AppLabel* petDirectionLabel;
  AppLabel* petDistanceLabel;
  Proximity* proximity;
  GeofenceData* geofenceData;
  int n;
}

- (id)initWithKippy:(NSDictionary*)dictionary;
- (void)idle;

@end
