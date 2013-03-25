//
//  bixitoSecondViewController.m
//  BixiTO
//
//  Created by Andrew Laffin on 2013-03-16.
//  Copyright (c) 2013 BixiTO. All rights reserved.
//

#import "bixitoMapViewController.h"
#import "Station/BikeStation.h"

@interface bixitoSecondViewController ()

@end

@implementation bixitoSecondViewController
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
    
    //Select a given marker:
    //[mapView_ setSelectedMarker:[[mapView_ markers] objectAtIndex:1]];
    
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
                for(int j = 0; j < [self.stationList count]; j++){
                    if([[[self.stationList objectAtIndex:j] stationName] isEqualToString: delegate.selectedStationName]){
                        stationListIndex = j;
                        break;
                    }
                }
                break;
            }
        }
        [mapView_ setSelectedMarker: [[mapView_ markers] objectAtIndex:objectIndex]];
        //NSLog(@"Told to select station %@, found this item at %d", delegate.selectedStationName, objectIndex);
        //NSLog(@"Animating to these coordinates: %f , %f", [[self.stationList objectAtIndex:stationListIndex] latitude], [[self.stationList objectAtIndex:stationListIndex] longitude]);
        [mapView_ animateToLocation:CLLocationCoordinate2DMake([[self.stationList objectAtIndex:stationListIndex] latitude], [[self.stationList objectAtIndex:stationListIndex] longitude])];
        [mapView_ animateToZoom:18];
        /*[mapView_ ca] = [GMSCameraPosition cameraWithLatitude: [[self.stationList objectAtIndex:stationListIndex] latitude]
                                    longitude: [[self.stationList objectAtIndex:stationListIndex] longitude]
                                         zoom:18];
        */
        delegate.selectedStationName = @"";
    }
}

@end


