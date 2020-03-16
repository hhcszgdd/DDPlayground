//
//  ViewController.h
//  DrawEclipse
//
//  Created by JohnConnor on 2020/3/16.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) MKMapView * mapView;


@end

