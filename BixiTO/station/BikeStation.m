//
//  BikeStation.m
//  BixiTO
//
//  Created by Andrew Laffin on 2013-03-17.
//  Copyright (c) 2013 BixiTO. All rights reserved.
//

#import "BikeStation.h"

@implementation BikeStation

-(void) setStationName:(NSString *)stationName{
    
    NSRange range = [stationName rangeOfString:@"/"];
    
    if(range.length > 0){
        //station name contains a /
        NSArray *splitString = [stationName componentsSeparatedByString:@"/"];
        NSString *outputStationName = [[NSString alloc] init];
        
        for(int i = 0; i < [splitString count]; i++){ 
            outputStationName = [outputStationName stringByAppendingString: [[splitString objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
            if(i != ([splitString count] - 1)){
                outputStationName = [outputStationName stringByAppendingString: @" and "];
            }
        }
        _stationName = outputStationName;
    }
    else{
        _stationName = stationName;
    }

}

@end
