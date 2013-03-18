//
//  XMLParser.h
//  BixiTO
//
//  Created by Andrew Laffin on 2013-03-18.
//  Copyright (c) 2013 BixiTO. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BikeStation;

@interface XMLParser : NSObject{
    NSMutableString *currentValue;
    BikeStation *currentStation;
    NSMutableArray *stationList;
}

@property(nonatomic, retain) NSMutableArray *stationList;
@property(nonatomic, retain) BikeStation *currentStation;

@end
