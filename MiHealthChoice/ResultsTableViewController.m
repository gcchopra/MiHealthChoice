//
//  ResultsTableViewController.m
//  MiDosServiceFinder
//
//  Created by Girish Chopra on 26/11/2013.
//  Copyright (c) 2013 Intuiti. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "DetailViewController.h"

@interface ResultsTableViewController ()

@end

@implementation ResultsTableViewController
@synthesize serviceId;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

-(void) setPostcode:(NSString *)pc{
    postCode = [pc stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(void) setPageTitle:(NSString *)title {
    pageTitle = title;
}
                

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:pageTitle];
    
    NSMutableString * str = [NSMutableString stringWithFormat:@"http://pubapp.midosweb.co.uk/MidosPubAppService.svc/"];
    
    NSString * deviceId = [[[UIDevice currentDevice] identifierForVendor]UUIDString];
    [str appendString:deviceId];
    [str appendString:serviceId];
    
    [str appendString:@"/"];
    [str appendString:postCode];
    NSURL * url = [NSURL URLWithString:str];
    
    NSMutableURLRequest * rurl
    = [NSMutableURLRequest requestWithURL:url];
    [rurl addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [rurl setHTTPMethod:@"Get"];
    
    NSURLConnection * conn = [[NSURLConnection alloc] initWithRequest:rurl delegate:self];
    [self showActivityIndicatorOnView:self.parentViewController.view];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // self.navigationItem.leftBarButtonItem = self.backButtonItem;
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self performSegueWithIdentifier:@"hideResults" sender:self];
}


- (UIActivityIndicatorView *)showActivityIndicatorOnView:(UIView*)aView
{
    CGSize viewSize = aView.bounds.size;
    
    // create new dialog box view and components
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                                                      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // other size? change it
    activityIndicatorView.bounds = CGRectMake(0, 0, 65, 65);
    activityIndicatorView.hidesWhenStopped = YES;
    activityIndicatorView.alpha = 0.7f;
    activityIndicatorView.backgroundColor = [UIColor blackColor];
    activityIndicatorView.layer.cornerRadius = 10.0f;
    
    
    // display it in the center of your view
    activityIndicatorView.center = CGPointMake(viewSize.width / 2.0, viewSize.height / 2.0);
    
    [aView addSubview:activityIndicatorView];
    
    [activityIndicatorView startAnimating];
    
    return activityIndicatorView;
}


#pragma mark NSURLConnection Delegate Methods

//- (void) connection:(NSURLConnection *) connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
//    NSLog(@"Received authentication challenge");
//    if ([challenge previousFailureCount] == 0) {
//        NSURLCredential *newCredential;
//        newCredential = [NSURLCredential credentialWithUser:[self @"MyApp"]
//                                                   password:[self @"Intuiti"]
//                                                persistence:NSURLCredentialPersistenceNone];
//        [[challenge sender] useCredential:newCredential
//               forAuthenticationChallenge:challenge];
//    } else {
//        [[challenge sender] cancelAuthenticationChallenge:challenge];
//        // inform the user that the user name and password
//        // in the preferences are incorrect
////        [self showPreferencesCredentialsAreIncorrectPanel:self];
//        NSLog(@"Authentication failed. Please check username/password");
//    }
//    
//}


- (void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
    long erroCode = httpResponse.statusCode;
    
    NSString *fileMIMEType = [[httpResponse MIMEType] lowercaseString];
    NSLog(@"Received response %ld - %@", erroCode, fileMIMEType);
    _results = [[NSMutableData alloc] init];
}

- (void) connection:(NSURLConnection *) connection didReceiveData:(NSData *)data {
    NSLog(@"Received data");
    [_results appendData:data];
}

- (void) connectionDidFinishLoading: (NSURLConnection *) connection {
    NSLog(@"Finished loading data");
    NSError * error;
    serviceData = [NSJSONSerialization JSONObjectWithData:_results options:NSJSONReadingAllowFragments error:&error];
    if(error != nil) {
        NSString * msg = [[NSString alloc] initWithFormat:@"Failed to parse results.\nPlease try again.\nError code: %ld, Description: %@",(long)[error code],[error description]];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate: self cancelButtonTitle : @"Cancel" otherButtonTitles: nil];
        [alert show];
    } else {
//        Boolean add = FALSE;
//        NSDictionary * entry ;
//        if ([serviceData count] > 0 && [[serviceData objectAtIndex:0] count] == 0
//            && [[serviceData objectAtIndex:1] count] == 0) {
//            NSArray * vals = [[NSArray alloc] initWithObjects: @"No results found. Please check postcode.",@"",@"",@"",nil];
//            NSArray * keys =
//            [[NSArray alloc] initWithObjects: @"Address",@"Postcode",@"Phone",@"OpeningHours",nil];
//            entry = [[NSDictionary alloc] initWithObjects:vals forKeys:keys];
//            
//            add = true;
//        }
//        if(add) {
//            NSArray * array = [[NSArray alloc] initWithObjects:entry, nil];
//            [serviceData setObject:array atIndexedSubscript:0];
//        }
        [self.tableView reloadData];
    }
    [activityIndicatorView stopAnimating];
}

-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *)error {
    NSString * errorDesc = [error localizedDescription];
    NSString * errorInfo = [[error userInfo] objectForKey:NSURLErrorFailingURLErrorKey];
    NSLog(@"Connection failed. Error: %@ %@", errorDesc,errorInfo);
    [activityIndicatorView stopAnimating];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorDesc delegate: self cancelButtonTitle : @"Cancel" otherButtonTitles: nil];
    [alert show];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    NSMutableString * retVal = [[NSMutableString alloc] initWithString:pageTitle] ;
    if (section == 0) {
        return [[NSString alloc]  initWithFormat:@"%@ Open Now",pageTitle];
    } if (section == 1) {
        return [[NSString alloc]  initWithFormat:@"%@ Open Later",pageTitle];
//        [retVal appendString:@" Open Later"];
    }
//    return retVal;
    return @"Unknown";
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [serviceData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[serviceData objectAtIndex:section]  count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        NSDictionary * dataDict = [[serviceData objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]] ;
        cell.textLabel.text = [dataDict objectForKey:@"Name"];
//        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    // Configure the cell...
    
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

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle]];

    
    // Pass the selected object to the new view controller.
    detailViewController.imageName = @"spotlight_icon.png";
    
    detailViewController.details = [[serviceData objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]] ;
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 



@end
