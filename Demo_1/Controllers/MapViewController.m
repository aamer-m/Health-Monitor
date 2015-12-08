//
//  MapViewController.m
//  Demo_1
//
//  Created by mohammed aamer on 12/4/15.
//  Copyright © 2015 mohammed aamer. All rights reserved.
//

#import "MapViewController.h"
#import "LogoutObject.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [LogoutObject addLogoutIconInViewController:self];
    
    self.mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(39.1397491, -84.5214432)];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(39.1397491, -84.5214432);
    
    float spanX = 0.00725;
    float spanY = 0.00725;
    MKCoordinateRegion region;
    region.center.latitude = coordinate.latitude;
    region.center.longitude = coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    [self.mapView setRegion:region];
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coordinate;
    point.title = @"Good Samaritan Hospital";
    [self.mapView addAnnotation:point];
    [self.mapView selectAnnotation:point animated:TRUE];

}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    [mapView selectAnnotation:view.annotation animated:FALSE];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
