//
//  bixitoAppDelegate.h
//  BixiTO
//
//  Created by Andrew Laffin on 2013-03-16.
//  Copyright (c) 2013 BixiTO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "station/BikeStation.h"


@interface bixitoAppDelegate : UIResponder <UIApplicationDelegate>{
    NSMutableString *nodeContent;
    NSXMLParser *xmlParserObject;
    NSString *xmlFileURL;
    BikeStation *currentBikeStation;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSMutableArray *stationList;

@end
