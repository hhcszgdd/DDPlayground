//
//  ViewController.m
//  DrawEclipse
//
//  Created by JohnConnor on 2020/3/16.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "DDAnnotation.h"
@interface MapViewController ()
@property (nonatomic) CLLocationCoordinate2D  center;
@property (nonatomic) MKPolyline * line;
@end

@implementation MapViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMapView];
    self.center = CLLocationCoordinate2DMake(39.90960456, 116.39722824);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mapView setRegion:MKCoordinateRegionMake(self.center, MKCoordinateSpanMake(0.01, 0.01)) animated:true];
        [self drawEclipse];
    });
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch   = touches.allObjects.firstObject;
    CGPoint point =  [touch locationInView:self.mapView];
    CLLocationCoordinate2D coornidate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    DDAnnotation * annotation = [[DDAnnotation alloc] init];
    annotation.coordinate  = coornidate;
    [self.mapView addAnnotation:annotation];
    
}
- (MKMapView*)mapView {
    if (_mapView == nil) {
        _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    }
    return _mapView ;
}

- (void)setupMapView {
    [self.view addSubview:self.mapView];
    self.mapView.showsUserLocation = true ;
    self.mapView.showsScale = true;
    self.mapView.delegate = self ;
    if (__builtin_available(iOS 9, *)) {
        self.mapView.showsScale = true;
        self.mapView.showsTraffic = false;
        
        self.mapView.showsCompass = true;
    } else {
        
    }
    self.mapView.mapType = MKMapTypeStandard;
}


/// Mark: drawEclipse
    
- (void)drawEclipse{
    const NSArray * result = [self computeExtentPositions:self.center minorRadius:80 majorRadius:40 heading:0];
    CLLocationCoordinate2D  locations[result.count];
    for (int i = 0 ; i < result.count  ;  i++) {
        locations[i] = CLLocationCoordinate2DMake([result[i] coordinate ].latitude, [result[i] coordinate ].longitude);
    }
   self.line = [MKPolyline polylineWithCoordinates:  &locations  count:result.count  ];
    [self.mapView addOverlay:self.line];
}
  - (NSArray  *)computeExtentPositions:(CLLocationCoordinate2D) center minorRadius:(double) minorRadius majorRadius: (double) majorRadius  heading: (double) heading  {
      double da = (2 * M_PI) / 360 ;
      NSMutableArray   *  array  = [NSMutableArray new];
      for (int i = 0 ; i <= 360 ; i++) {
    
          double angle =  i  * da;
          CLLocationCoordinate2D result = [self computeLocationFor:angle center:center minorRadius:minorRadius majorRadius:majorRadius heading:0];
          CLLocation * location = [[CLLocation alloc] initWithLatitude:result.latitude longitude:result.longitude];
//          location.coordinate.latitude
//          [array addObject:[NSValue valueWithMKCoordinate:result]] ;
          [array addObject:location];
          CLLocation * first = array.firstObject;
          CLLocationDistance dis =  [first distanceFromLocation:array.lastObject];
          NSLog(@"distance%f", dis);
          
        }
      return  array ;
    }
- (CLLocationCoordinate2D)computeLocationFor:(double)angle center: (CLLocationCoordinate2D) center minorRadius: (double) minorRadius majorRadius: (double) majorRadius heading: (double) heading {
    double xLength  = minorRadius * sin(angle);
    double yLength  = majorRadius * cos(angle);
    double distance = sqrt(xLength * xLength + yLength * yLength);
    double singNumyLength  = yLength > 0 ? 1 : (yLength < 0 ? -1 : 0);
    double radians = M_PI / 180 * heading;
    double azimuth = (M_PI / 2) - (acos(xLength / distance) * singNumyLength - radians);
    CLLocationCoordinate2D result = [self greatCircleLocation:center azimuth:[self radiansRevert:azimuth] distance:[self radiansRevert:distance/6378140]];
//    greatCircleLocation(beginLocation: center, azimuth: radiansRevert(value: azimuth), distance: radiansRevert(value: distance / 6378140 ));//
    return result ;
}
    
- (CLLocationCoordinate2D)greatCircleLocation:(CLLocationCoordinate2D) beginLocation  azimuth: (double) azimuth distance: (double) distance {
    double latitude = beginLocation.latitude;
    double longitude = beginLocation.longitude;
        if (distance != 0) {
            double lat1 = [self  radians: latitude];
            double lon1 = [self radians: longitude];
            double a = [self  radians:  azimuth];
            double d = [self  radians: distance];
            double lat2 = asin(sin(lat1) * cos(d) + cos(lat1) * sin(d) * cos(a));
            double lon2 = lon1 + atan2(sin(d) * sin(a), cos(lat1) * cos(d) - sin(lat1) * sin(d) * cos(a));
            if ( !isnan(lat2)  && !isnan(lon2) ) {
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake( [self normalizeDegresLatitude: [self radiansRevert:lat2]],  [self normalizeDegresLongitude: [self radiansRevert:lon2]]);
                return coordinate ;
            }
        }
    return kCLLocationCoordinate2DInvalid ;
    }
    
- (double) radians:(double) value  {
    return M_PI / 180 * value;
}
- (double) radiansRevert:(double)value {
    return 180 * value  / M_PI ;
}
    
- (double) normalizeDegresLatitude:(double) latitude {
    double lat = fmod(latitude, 180);
    return lat > 90 ? 180 - lat : ( lat < -90 ? -180 - lat : lat);
}
- (double) normalizeDegresLongitude:(double) longitude {
    double lon = fmod(longitude, 360) ;
    return lon > 180 ? lon - 360 : (lon < -180 ? 360 + lon: lon);
}
    



/// Mark: delegate
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass: [MKPolyline class]]) {
        MKPolylineRenderer * overlayBeRender =  [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        overlayBeRender.lineWidth = 2;
        overlayBeRender.strokeColor = [UIColor redColor];
        return overlayBeRender ;
    } else if ([overlay isKindOfClass: [MKCircle class]]) {
        MKCircleRenderer * circleBeRender =  [[MKCircleRenderer alloc] initWithOverlay:overlay];
        circleBeRender.lineWidth = 2;
        circleBeRender.strokeColor = [UIColor redColor];
        return circleBeRender ;
    }
    
    return [[MKOverlayRenderer alloc] init];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    return  nil ;
}

@end
