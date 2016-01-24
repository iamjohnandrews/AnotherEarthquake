//
//  MapViewController.h
//  Earthquake2016
//
//  Created by John Andrews on 1/24/16.
//  Copyright © 2016 John Andrews. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "Earthquake.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (nonatomic, strong) Earthquake *earthquake;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
