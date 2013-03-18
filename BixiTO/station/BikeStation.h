//
//  BikeStation.h
//  BixiTO
//
//  Created by Andrew Laffin on 2013-03-17.
//  Copyright (c) 2013 BixiTO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BikeStation : NSObject

@property(nonatomic) int stationId;
@property(nonatomic, strong) NSString* stationName;
@property(nonatomic, strong) NSString* terminalName;
@property(nonatomic) long lastCommWithServer;
@property(nonatomic) double latitude;
@property(nonatomic) double longitude;
@property(nonatomic) Boolean installed;
@property(nonatomic) Boolean locked;
@property(nonatomic) Boolean temporary;
@property(nonatomic) Boolean publicStation;
@property(nonatomic) int nbBikes;
@property(nonatomic) int nbEmptyBikes;
@property(nonatomic) long latestUpdateTime;


@end
