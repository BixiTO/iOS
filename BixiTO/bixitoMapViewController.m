//
//  bixitoSecondViewController.m
//  BixiTO
//
//  Created by Andrew Laffin on 2013-03-16.
//  Copyright (c) 2013 BixiTO. All rights reserved.
//

#import "bixitoMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>


@interface bixitoSecondViewController ()

@end

@implementation bixitoSecondViewController
 {
    GMSMapView *mapView_;
}

// You don't need to modify the default initWithNibName:bundle: method.

- (void)loadView {
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:43.65
                                                            longitude:-79.40
                                                                 zoom:11];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    GMSMarkerOptions *options = [[GMSMarkerOptions alloc] init];
    
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


