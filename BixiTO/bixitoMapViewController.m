//
//  bixitoSecondViewController.m
//  BixiTO
//
//  Created by Andrew Laffin on 2013-03-16.
//  Copyright (c) 2013 BixiTO. All rights reserved.
//

#import "bixitoMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Station/BikeStation.h"
#import "bixitoAppDelegate.h"

@interface bixitoSecondViewController ()

@end

@implementation bixitoSecondViewController
 {
    GMSMapView *mapView_;
}

// You don't need to modify the default initWithNibName:bundle: method.

- (void)loadView {
    
    bixitoAppDelegate* delegate = (bixitoAppDelegate*) [[UIApplication sharedApplication] delegate];
    self.stationList = delegate.stationList;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:43.65
                                                            longitude:-79.40
                                                                 zoom:11];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;

    //GMSMarkerOptions *options = [[GMSMarkerOptions alloc] init];
    
    
    GMSMarkerOptions *currentMarker;
    self.markerList = [[NSMutableArray alloc] init];
    
    for(BikeStation *currentStation in self.stationList){
        currentMarker = [[GMSMarkerOptions alloc] init];
        
        currentMarker.position = CLLocationCoordinate2DMake([currentStation latitude], [currentStation longitude]);
        currentMarker.title = [currentStation stationName];
        currentMarker.snippet = [NSString stringWithFormat:@"Bikes Available: %d, Empty Docks: %d", [currentStation nbBikes], [currentStation nbEmptyBikes]];
        [mapView_ addMarkerWithOptions:currentMarker];
        [self.markerList addObject:currentMarker];
    }
    
    //options.position = CLLocationCoordinate2DMake(-33.8683, 151.2086);
    //options.title = @"Ontario";
    //options.snippet = @"Canada";
    //[mapView_ addMarkerWithOptions:options];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


