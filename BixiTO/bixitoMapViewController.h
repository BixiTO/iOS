//
//  bixitoSecondViewController.h
//  BixiTO
//
//  Created by Andrew Laffin on 2013-03-16.
//  Copyright (c) 2013 BixiTO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bixitoAppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>


@interface bixitoSecondViewController : UIViewController{
    bixitoAppDelegate* delegate;
    GMSCameraPosition *camera;

}

@property (nonatomic, assign) NSMutableArray *stationList;
@property (nonatomic, strong) NSMutableArray *markerList;
@property (nonatomic) int selectedStationId;

@end
