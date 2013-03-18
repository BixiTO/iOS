//
//  bixitoListViewController.h
//  BixiTO
//
//  Created by Andrew Laffin on 2013-03-18.
//  Copyright (c) 2013 BixiTO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "station/BikeStation.h"


@interface bixitoListViewController : UITableViewController{
    NSMutableArray *stationList;
    NSMutableString *nodeContent;
    NSXMLParser *xmlParserObject;
    NSString *xmlFileURL;
    BikeStation *currentBikeStation;
}

@end
