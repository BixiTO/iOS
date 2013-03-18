//
//  XMLParser.m
//  BixiTO
//
//  Created by Andrew Laffin on 2013-03-18.
//  Copyright (c) 2013 BixiTO. All rights reserved.
//

#import "XMLParser.h"
#import "BikeStation.h"

@implementation XMLParser

-(XMLParser *) initXMLParser {
    [super init];
    
    //initialize the station list array
    stationList = [[NSMutableArray alloc] init];
    return self;
}

-(void)parser:(NSXMLParser *)parser
    didStartElement:(NSString*) elementName
    namespaceURI:(NSString*) namespaceURI
    qualifiedName:(NSString*) qualifiedName
    attributes:(NSDictionary*) attributeDict {
    NSLog(@"Found a new bike station to add.");
    
    //Initialize the currentstation
    currentStation = [[BikeStation alloc] init];
    
    [currentStation setStationName: [[attributeDict objectForKey:@"station"]]];
    
    /* Other tags to implement:
     static final String STATION_TAG = "station";
     static final String ID = "id";
     static final String NAME = "name";
     static final String TERMINAL_NAME = "terminalName";
     static final String LAST_COMM_WITH_SERVER = "lastCommWithServer";
     static final String LATITUDE = "lat";
     static final String LONGITUDE = "long";
     static final String INSTALLED = "installed";
     static final String LOCKED = "locked";
     static final String TEMPORARY = "temporary";
     static final String PUBLIC = "public";
     static final String NUMBER_OF_BIKES = "nbBikes";
     static final String NUMBER_OF_EMPTY_DOCKS = "nbEmptyDocks";
     static final String STATION_LAST_UPDATE_TIME = "latestUpdateTime";
     */
    
}

@end
