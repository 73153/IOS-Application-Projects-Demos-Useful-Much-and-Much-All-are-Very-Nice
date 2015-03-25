//
//  Copyright (c) 2013 Click'nTap SRL. All rights reserved.
//

#import "MapView.h"
#import "HeaderView.h"
#import "MapToolbar.h"
#import "MapAnnotation.h"
#import "Proximity.h"
#import "TapUtils.h"
#import "AppDelegate.h"
#import "GeofenceVertexAnnotation.h"
#import "GeofenceData.h"
#import "AppLabel.h"

@implementation MapView

- (id)initWithKippy:(NSDictionary*)dictionary {
  self = [super initWithDictionary:dictionary];
  if (self) {
    // NSLog(@"%@", info);

    geofenceData = [[GeofenceData alloc] init];

    [self app].selectedKippy = dictionary;
    headerView = [[HeaderView alloc] initWithKippy:dictionary];
    [self addSubview:headerView];

    petDirection = [[UIView alloc] initWithFrame:CGRectMake(44,0,120,44)];
    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pet_direction.png"]];
    [petDirection addSubview:img];
    [self addSubview:petDirection];
    petDirection.alpha = 0;

    petDirectionLabel = [[AppLabel alloc] initWithStyle:AppLabelStyleGreen];
    petDirectionLabel.frame = CGRectMake(32,22,120,22);
    [petDirectionLabel set:@""];
    [petDirection addSubview:petDirectionLabel];

    ftBtn = [[UIButton alloc] initWithFrame:CGRectMake(44,0,120,44)];
    [ftBtn setImage:[UIImage imageNamed:@"ft_off.png"] forState:UIControlStateNormal];
    [ftBtn setImage:[UIImage imageNamed:@"ft_on.png"] forState:UIControlStateSelected];
    [ftBtn addTarget:self action:@selector(toggleFt) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ftBtn];

    [self updateStatus];

    map = [[MKMapView alloc] init];
    map.showsUserLocation = YES;
    map.delegate = self;
    [self addSubview:map];
    toolbar = [[MapToolbar alloc] initWithDictionary:dictionary];
    [self addSubview:toolbar];
    btnMe = [[UIButton alloc] initWithFrame:CGRectMake(0,0,50,50)];
    [btnMe setImage:[UIImage imageNamed:@"btn-map-2.png"] forState:UIControlStateNormal];
    [btnMe addTarget:self action:@selector(changeMapType) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnMe];
    btnKippy = [[UIButton alloc] initWithFrame:CGRectMake(0,0,50,50)];
    [btnKippy setImage:[UIImage imageNamed:@"kippy_on_map.png"] forState:UIControlStateNormal];
    [btnKippy addTarget:self action:@selector(showOnMap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnKippy];
    btnKippy.alpha = 0;
    btnMe.alpha = 0;

    proximity = [[Proximity alloc] init];
    [self addSubview:proximity];
    n = 1;
    self.clipsToBounds = YES;
    proximity.alpha = 0;
    geofenceBtn = [[UIButton alloc] initWithFrame:CGRectMake(44,0,120,44)];
    [geofenceBtn setImage:[UIImage imageNamed:@"geofence_off.png"] forState:UIControlStateNormal];
    [geofenceBtn setImage:[UIImage imageNamed:@"geofence_on.png"] forState:UIControlStateSelected];
    [geofenceBtn addTarget:self action:@selector(toggleGeofence) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:geofenceBtn];

    geofenceAddBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,160,36)];
    [geofenceAddBtn setImage:[UIImage imageNamed:@"new_geofence.png"] forState:UIControlStateNormal];
    [geofenceAddBtn setImage:[UIImage imageNamed:@"delete_geofence.png"] forState:UIControlStateSelected];
    [geofenceAddBtn addTarget:self action:@selector(toggleAddGeofence) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:geofenceAddBtn];

    geofenceBtn.alpha = 0;
    geofenceAddBtn.alpha = 0;

    petDistanceLabel = [[AppLabel alloc] initWithStyle:AppLabelStyleBlueLeft];
    [petDistanceLabel set:@"Distance: --"];
    [self addSubview:petDistanceLabel];
    petDistanceLabel.alpha = 0;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(petDistance:) name:@"PetDistance" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(petDirection:) name:@"PetDirection" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabChanged:) name:@"TabChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kippyMoved:) name:@"KippyMoved" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAnnotation) name:@"GeofenceChanged" object:nil];
  }
  return self;
}

-(void)petDistance:(NSNotification*)notification {
  [petDistanceLabel set:[NSString stringWithFormat:@"Distance: %@ km", notification.object]];
}

-(void)petDirection:(NSNotification*)notification {
  [petDirectionLabel set:[NSString stringWithFormat:@"%@°", notification.object]];
}

-(void)updateStatus {
  [geofenceData loadData];
  ftBtn.selected = false;
  geofenceBtn.selected = false;
  if([[self.info objectForKey:@"operating_status"] intValue] == 2) {
    ftBtn.selected = true;
  }
  if(![[info objectForKey:@"geofence_id"] isKindOfClass:[NSNull class]]) {
    if([[self.info objectForKey:@"geofence_id"] intValue] != 0) {
      geofenceBtn.selected = true;
    }
  }
}

-(void)toggleFt {
  ftBtn.selected = !ftBtn.selected;
  if(ftBtn.selected) {
    [[self app] setStatus:2 kippyId:[self.info objectForKey:@"id"]];
  } else {
    [[self app] setStatus:1 kippyId:[self.info objectForKey:@"id"]];
  }
}

-(void)toggleGeofence {
  geofenceBtn.selected = !geofenceBtn.selected;
  if(geofenceBtn.selected) {
    [[self app] setGeofenceStatus:1 kippyId:[self.info objectForKey:@"id"]];
  } else {
    [[self app] setGeofenceStatus:0 kippyId:[self.info objectForKey:@"id"]];
  }
}

-(void)toggleAddGeofence {
  NSLog(@"toggleAddGeofence");
  geofenceAddBtn.selected = !geofenceAddBtn.selected;
  if(geofenceAddBtn.selected) {
    [self setGeofence];
    [geofenceData saveData];
    NSLog(@"toggleAddGeofence ON");
  } else {
    [self app].geofence_v1 = CLLocationCoordinate2DMake(0,0);
    [geofenceData deleteData];
    [self updateAnnotation];
    NSLog(@"toggleAddGeofence OFF");
  }
}

-(void)tabChanged:(NSNotification*)notification {
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.5];
  petDistanceLabel.alpha = petDirection.alpha = 0;
  ftBtn.alpha = 0;
  geofenceBtn.alpha = 0;
  geofenceAddBtn.alpha = 0;
  if([notification.object intValue] == 1) {
    [[self app] setStatus:(ftBtn.selected?1:2) kippyId:[self.info objectForKey:@"id"]];
    ftBtn.alpha = 1;
  }
  if([notification.object intValue] == 2) {
    petDistanceLabel.alpha = petDirection.alpha = 1;
    [[self app] setStatus:4 kippyId:[self.info objectForKey:@"id"]];
    proximity.alpha = 1;
  } else {
    proximity.alpha = 0;
  }
  if([notification.object intValue] == 3) {
    geofenceBtn.alpha = 1;
    geofenceAddBtn.alpha = 0.6;
    [[self app] setStatus:3 kippyId:[self.info objectForKey:@"id"]];
  }
  [UIView commitAnimations];
  [self updateAnnotation];
}

-(void)showOnMap {
  btnKippy.selected = !btnKippy.selected;
  if(btnKippy.selected) {
    [self showMeOnMap];
    [btnKippy setImage:[UIImage imageNamed:@"btn-map-1.png"] forState:UIControlStateNormal];
  } else {
    [self showKippyOnMap];
    [btnKippy setImage:[UIImage imageNamed:@"kippy_on_map.png"] forState:UIControlStateNormal];
  }
}

-(void)changeMapType {
  btnMe.selected = !btnMe.selected;
  if(btnMe.selected) {
    map.mapType = MKMapTypeSatellite;
  } else {
    map.mapType = MKMapTypeStandard;
  }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
  if (newState == MKAnnotationViewDragStateEnding)
  {
    [mapView removeAnnotation:annotationView.annotation];
  }
}

-(void)showMeOnMap {
  MKCoordinateRegion region;
  region.center.latitude = map.userLocation.location.coordinate.latitude;
  region.center.longitude = map.userLocation.location.coordinate.longitude;
  region.span.latitudeDelta = 0.05;
  region.span.longitudeDelta = 0.05;
  [map setRegion:region animated:YES];
}

-(void)kippyMoved:(NSNotification*)notification {
  self.info = notification.object;
  [self updateAnnotation];
  [self updateStatus];
}

-(void)showKippyOnMap {
  double lat = 0;
  double lng = 0;
  if(![[info objectForKey:@"lat"] isKindOfClass:[NSNull class]]) {
    lat = [[info objectForKey:@"lat"] doubleValue];
  }
  if(![[info objectForKey:@"lng"] isKindOfClass:[NSNull class]]) {
    lng = [[info objectForKey:@"lng"] doubleValue];
  }
  MKCoordinateRegion region;
  region.center.latitude = lat;
  region.center.longitude = lng;
  region.span.latitudeDelta = 0.05;
  region.span.longitudeDelta = 0.05;
  if(lat != 0 && lng != 0 && fabs(region.center.latitude) < 90 && fabs(region.center.longitude) < 180) {
    [map setRegion:region animated:YES];
  } else {
    [self shakeView:btnKippy];
  }
}

-(void)layoutSubviews {
  CGSize size = self.frame.size;
  headerView.frame = CGRectMake(0, 0, size.width, 44);
  btnMe.frame = CGRectMake(0, size.height-126-70, 50, 50);
  btnKippy.frame = CGRectMake(size.width-50, size.height-126-70,50, 50);
  geofenceAddBtn.frame = CGRectMake((size.width-160)/2, size.height-126-63,160, 36);
  toolbar.frame = CGRectMake(0, size.height-126, size.width, 126);
  map.frame = CGRectMake(0, 44, size.width, size.height-44-126);
  proximity.frame = CGRectMake(0, 44, size.width, size.height-44-126);
  petDistanceLabel.frame = CGRectMake(20, size.height-126-70, size.width-40, 50);
}


-(void)setGeofence {
  double lat = map.region.center.latitude;
  double lng = map.region.center.longitude;
  [self app].geofence_v1 = CLLocationCoordinate2DMake(lat+0.014,lng+0.01);
  [self app].geofence_v2 = CLLocationCoordinate2DMake(lat,lng+0.022);
  [self app].geofence_v3 = CLLocationCoordinate2DMake(lat-0.014,lng+0.01);
  [self app].geofence_v4 = CLLocationCoordinate2DMake(lat-0.014,lng-0.01);
  [self app].geofence_v5 = CLLocationCoordinate2DMake(lat,lng-0.022);
  [self app].geofence_v6 = CLLocationCoordinate2DMake(lat+0.014,lng-0.01);
  [self updateAnnotation];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[MapAnnotation class]]) {
		static NSString* key = @"MapAnnotation";
		MKAnnotationView* annotationView = nil;
		if (!annotationView)
		{
			annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:key];
      annotationView.canShowCallout = NO;
      //annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeInfoDark];
		}
    annotationView.image = [UIImage imageNamed:@"pin.png"];
 		return annotationView;
	}
	if ([annotation isKindOfClass:[GeofenceVertexAnnotation class]]) {
		static NSString* key = @"GeofenceVertexAnnotation";
		MKAnnotationView* annotationView = nil;
		if (!annotationView)
		{
			annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:key];
 		}
    annotationView.canShowCallout = NO;
    annotationView.draggable = YES;
    annotationView.image = [UIImage imageNamed:@"geofence_pin.png"];
    annotationView.frame = CGRectMake(0, 0, 32, 32);
    [annotationView setSelected:YES animated:YES];
    annotationView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.01];
 		return annotationView;
	}
	return nil;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {

}

-(void)updateAnnotation {
  double lat = 0;
  double lng = 0;
  if(![[info objectForKey:@"lat"] isKindOfClass:[NSNull class]]) {
    lat = [[info objectForKey:@"lat"] doubleValue];
  }
  if(![[info objectForKey:@"lng"] isKindOfClass:[NSNull class]]) {
    lng = [[info objectForKey:@"lng"] doubleValue];
  }
  [map removeAnnotations:[map annotations]];
  [map removeOverlays:[map overlays]];
  if(lat != 0 && lng != 0) {
    MapAnnotation* annotation = [[MapAnnotation alloc] initWithDictionary:info];
    [map addAnnotation:annotation];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = lat;
    coordinate.longitude = lng;
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:coordinate radius:[[info objectForKey:@"radius"] doubleValue]];
    [map addOverlay:circle];
    if([self app].geofence_v1.latitude != 0 && geofenceBtn.alpha == 1) {
      geofenceAddBtn.selected = YES;
      CLLocationCoordinate2D commuterLotCoords[6]={
        [self app].geofence_v1,
        [self app].geofence_v2,
        [self app].geofence_v3,
        [self app].geofence_v4,
        [self app].geofence_v5,
        [self app].geofence_v6
      };
      MKPolygon *commuterParkingPolygon=[MKPolygon polygonWithCoordinates:commuterLotCoords count:6];
      [map addOverlay:commuterParkingPolygon];
      GeofenceVertexAnnotation* v1 = [[GeofenceVertexAnnotation alloc] initWithIndex:1];
      [map addAnnotation:v1];
      GeofenceVertexAnnotation* v2 = [[GeofenceVertexAnnotation alloc] initWithIndex:2];
      [map addAnnotation:v2];
      GeofenceVertexAnnotation* v3 = [[GeofenceVertexAnnotation alloc] initWithIndex:3];
      [map addAnnotation:v3];
      GeofenceVertexAnnotation* v4 = [[GeofenceVertexAnnotation alloc] initWithIndex:4];
      [map addAnnotation:v4];
      GeofenceVertexAnnotation* v5 = [[GeofenceVertexAnnotation alloc] initWithIndex:5];
      [map addAnnotation:v5];
      GeofenceVertexAnnotation* v6 = [[GeofenceVertexAnnotation alloc] initWithIndex:6];
      [map addAnnotation:v6];
    } else {
      geofenceAddBtn.selected = NO;
    }
  }
}

- (MKOverlayView *)mapView:(MKMapView *)map viewForOverlay:(id <MKOverlay>)overlay
{
	if([overlay isKindOfClass:[MKPolygon class]]){
		MKPolygonView *view = [[MKPolygonView alloc] initWithOverlay:overlay];
		view.lineWidth=1;
		view.strokeColor=HEXCOLOR(0xcccc66);
		view.fillColor=[view.strokeColor colorWithAlphaComponent:0.2];
		return view;
	}
	if([overlay isKindOfClass:[MKCircle class]]){
    MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
    circleView.strokeColor = HEXACOLOR(0x8dc63f, 0.75);
    circleView.fillColor = HEXACOLOR(0x8dc63f, 0.25);
    return circleView;
	}
  return nil;
}

-(void)idle {
  [proximity idle];
  if(n%100 == 0) {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if(self.info == nil) {
      btnKippy.alpha = 0;
      btnKippy.userInteractionEnabled = NO;
    } else {
      if(btnKippy.alpha == 0) {
        [self showKippyOnMap];
        [self updateAnnotation];
      }
      btnKippy.alpha = 1.0;
      btnKippy.userInteractionEnabled = YES;
    }
    if(map.userLocation.location.coordinate.latitude == 0 || map.userLocation.location.coordinate.longitude == 0) {
      btnMe.alpha = 0;
      btnMe.userInteractionEnabled = NO;
    } else {
      btnMe.alpha = 1.0;
      btnMe.userInteractionEnabled = YES;
    }
    double lat = 0;
    double lng = 0;
    if(![[info objectForKey:@"lat"] isKindOfClass:[NSNull class]]) {
      lat = [[info objectForKey:@"lat"] doubleValue];
    }
    if(![[info objectForKey:@"lng"] isKindOfClass:[NSNull class]]) {
      lng = [[info objectForKey:@"lng"] doubleValue];
    }
    BOOL proximityOn = NO;
    if(map.userLocation.location.coordinate.latitude != 0 && map.userLocation.location.coordinate.longitude != 0) {
      if(lat != 0 && lng != 0) {
        CLLocationCoordinate2D kippyPos = CLLocationCoordinate2DMake(lat, lng);
        [proximity setHeadingForDirectionFromCoordinate:map.userLocation.coordinate toCoordinate:kippyPos];
        proximityOn = YES;
      }
    }
    if(proximityOn) {
      [[NSNotificationCenter defaultCenter]postNotificationName:@"ProximityOn" object:nil];
    } else {
      [[NSNotificationCenter defaultCenter]postNotificationName:@"ProximityOff" object:nil];
    }
    n = 1;
    [UIView commitAnimations];
  }
  
  n++;
}

@end
