//
//  bixitoFirstViewController.h
//  BixiTO
//
//  Created by Andrew Laffin on 2013-03-16.
//  Copyright (c) 2013 BixiTO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "station/BikeStation.h"

@interface bixitoFirstViewController : UIViewController{
    NSMutableArray *stationList;
    NSMutableString *nodeContent;
    NSXMLParser *xmlParserObject;
    NSString *xmlFileURL;
    BikeStation *currentBikeStation;
}

@end
