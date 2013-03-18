//
//  bixitoListViewController.m
//  BixiTO
//
//  Created by Andrew Laffin on 2013-03-18.
//  Copyright (c) 2013 BixiTO. All rights reserved.
//

#import "bixitoListViewController.h"

@interface bixitoListViewController ()

@end

@implementation bixitoListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Hello!");
    
    // Do any additional setup after loading the view, typically from a nib.
    
    stationList = [[NSMutableArray alloc] init];
    
    NSData *xmlData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: @"http://bixitodb.appspot.com/remote/getBixiData"]];
    
    xmlParserObject = [[NSXMLParser alloc] initWithData: xmlData];
    [xmlParserObject setDelegate:self];
    
    [xmlParserObject parse];
    
    [self.tableView reloadData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [stationList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[stationList objectAtIndex:indexPath.row
                            ] stationName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", [[stationList objectAtIndex:indexPath.row] stationId]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
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
        NSLog([NSString stringWithFormat:@"Adding station: %@", [currentBikeStation stationName]]);
    }
    
    nodeContent = [[NSMutableString alloc] init];
}


@end
