//
//  bixitoListViewController.h
//  BixiTO
//
//  Created by Andrew Laffin on 2013-03-18.
//  Copyright (c) 2013 BixiTO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "station/BikeStation.h"
#import "bixitoAppDelegate.h"

@class bixitoAppDelegate;

@interface bixitoListViewController : UITableViewController{
    NSMutableString *nodeContent;
    NSXMLParser *xmlParserObject;
    NSString *xmlFileURL;
    BikeStation *currentBikeStation;
    
}

@property (nonatomic,retain) NSMutableArray *stationList;

-(void) updateStationList;

@end
