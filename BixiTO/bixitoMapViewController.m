//
//  bixitoSecondViewController.m
//  BixiTO
//
//  Created by Andrew Laffin on 2013-03-16.
//  Copyright (c) 2013 BixiTO. All rights reserved.
//

#import "bixitoMapViewController.h"
#import "Station/BikeStation.h"

@interface bixitoMapViewController ()

@end

@implementation bixitoMapViewController
 {
    GMSMapView *mapView_;
}

// You don't need to modify the default initWithNibName:bundle: method.

- (void)loadView {
    NSLog(@"Map loadview called");
    delegate = (bixitoAppDelegate*) [[UIApplication sharedApplication] delegate];
    self.stationList = delegate.stationList;
    
    camera = [GMSCameraPosition cameraWithLatitude:43.65
                                                            longitude:-79.40
                                                                 zoom:13];
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
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    if([delegate.selectedStationName length] == 0){
        //do nothing
    }
    else{
        int objectIndex = 0;
        int stationListIndex = 0;
        
        for(int i = 0; i < [[mapView_ markers] count]; i++){
            if([[[[mapView_ markers] objectAtIndex:i] title] isEqualToString: delegate.selectedStationName]){
                objectIndex = i;
                for(int j = 0; j < [delegate.stationList count]; j++){
                    if([[[delegate.stationList objectAtIndex:j] stationName] isEqualToString: delegate.selectedStationName]){
                        stationListIndex = j;
                        break;
                    }
                }
                break;
            }
        }
        [mapView_ setSelectedMarker: [[mapView_ markers] objectAtIndex:objectIndex]];
        [mapView_ animateToLocation:CLLocationCoordinate2DMake([[delegate.stationList objectAtIndex:stationListIndex] latitude], [[delegate.stationList objectAtIndex:stationListIndex] longitude])];
        [mapView_ animateToZoom:18];
    
        delegate.selectedStationName = @"";
    }
}

@end


