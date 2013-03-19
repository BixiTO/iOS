//
//  bixitoAppDelegate.m
//  BixiTO
//
//  Created by Andrew Laffin on 2013-03-16.
//  Copyright (c) 2013 BixiTO. All rights reserved.
//

#import "bixitoAppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>
#import "HUD.h"


@implementation bixitoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [HUD showUIBlockingIndicatorWithText:@"Loading..."];
    
    //Parse the data
    self.stationList = [[NSMutableArray alloc] init];

    NSData *xmlData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: @"http://bixitodb.appspot.com/remote/getBixiData"]];
    
    xmlParserObject = [[NSXMLParser alloc] initWithData: xmlData];
    [xmlParserObject setDelegate:self];
    [xmlParserObject parse];
    
    NSLog([NSString stringWithFormat:@"Loaded %d stations.", [self.stationList count] ]);
    
    bixitoAppDelegate *delegate = (bixitoAppDelegate*) [[UIApplication sharedApplication] delegate];
    delegate.stationList = self.stationList;
    
    [HUD hideUIBlockingIndicator];
    
    [GMSServices provideAPIKey:@"AIzaSyAzOXxUvqlspK6rXVGmkuyNg_0wUy9dq8s"];
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
        [self.stationList addObject:currentBikeStation];
        NSLog([NSString stringWithFormat:@"Adding station: %@", [currentBikeStation stationName]]);
    }
    
    nodeContent = [[NSMutableString alloc] init];
}


@end
