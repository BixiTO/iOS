//
//  bixitoFirstViewController.m
//  BixiTO
//
//  Created by Andrew Laffin on 2013-03-16.
//  Copyright (c) 2013 BixiTO. All rights reserved.
//

#import "bixitoListViewController.h"

@interface bixitoFirstViewController ()

@end

@implementation bixitoFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    stationList = [[NSMutableArray alloc] init];
    
    NSData *xmlData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: @"http://bixitodb.appspot.com/remote/getBixiData"]];
    
    xmlParserObject = [[NSXMLParser alloc] initWithData: xmlData];
    [xmlParserObject setDelegate:self];
    
    [xmlParserObject parse];
    
    
    
}

-(void) parser: (NSXMLParser *) parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if([elementName isEqualToString:@"station"]){
        //If its the root tag, allocate a new station
        currentBikeStation = [[BikeStation alloc] init];
    }
    
}

-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string{
    [nodeContent appendString:[string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

-(void)parser:(NSXMLParser *) parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if([elementName isEqualToString:@"id"]){
        [currentBikeStation setStationId:[nodeContent intValue]];
    }
    else if ([elementName isEqualToString:@"name"]){
        [currentBikeStation setStationName:nodeContent];
    }
    else if([elementName isEqualToString:@"terminalName"]){
        [currentBikeStation setTerminalName:nodeContent];
    }
    else if([elementName isEqualToString:@"lastCommWithServer"]){
        [currentBikeStation setLastCommWithServer: [nodeContent longLongValue]];
    }
    else if([elementName isEqualToString:@"lat"]){
        [currentBikeStation setLatitude:[nodeContent doubleValue]];
    }
    else if([elementName isEqualToString:@"long"]){
        [currentBikeStation setLongitude:[nodeContent doubleValue]];
    }
    else if([elementName isEqualToString:@"installed"]){
        [currentBikeStation setInstalled: [nodeContent isEqualToString:@"true"]];
    }
    else if([elementName isEqualToString:@"locked"]){
        [currentBikeStation setLocked: [nodeContent isEqualToString:@"true"]];
    }
    else if([elementName isEqualToString:@"temporary"]){
        [currentBikeStation setTemporary: [nodeContent isEqualToString:@"true"]];
    }
    else if([elementName isEqualToString:@"public"]){
        [currentBikeStation setPublicStation: [nodeContent isEqualToString:@"true"]];
    }
    else if([elementName isEqualToString:@"nbBikes"]){
        [currentBikeStation setNbBikes: [nodeContent intValue]];
    }
    else if([elementName isEqualToString:@"nbEmptyDocks"]){
        [currentBikeStation setNbEmptyBikes: [nodeContent intValue]];
    }
    else if([elementName isEqualToString:@"latestUpdateTime"]){
        [currentBikeStation setLatestUpdateTime: [nodeContent longLongValue]];
    }
    
    //Finished parsing the current station
    if([elementName isEqualToString:@"station"]){
        [stationList addObject:currentBikeStation];
    }
    
    nodeContent = [[NSMutableString alloc] init];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
