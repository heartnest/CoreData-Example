//
//  DeviceViewController.m
//  MyStore
//
//  Created by Simon on 9/12/12.
//  Modified by HeartNest 25/04/2013
//
//  Original Source&Documentation see: http://www.appcoda.com/introduction-to-core-data/

#import "DeviceViewController.h"

@interface DeviceViewController ()
@property (nonatomic, strong) NSArray *devices;
@end

@implementation DeviceViewController

#pragma mark - view controller init

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self useDemoDocument];
}

//Update the content every time appear the view
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performFetch];
    
}

- (void)useDemoDocument
{
    //base document url
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    //directory for our data storage
    url = [url URLByAppendingPathComponent:@"XDocument"];
    //create document object
    UIManagedDocument *document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        //create file path for document object
        [document saveToURL:url
           forSaveOperation:UIDocumentSaveForCreating
          completionHandler:^(BOOL success) {
              if (success) {
                  self.managedObjectContext = document.managedObjectContext;
              }
          }];
    } else if (document.documentState == UIDocumentStateClosed) {
        //active document object
        [document openWithCompletionHandler:^(BOOL success) {
            if (success) {
                self.managedObjectContext = document.managedObjectContext;
            }
        }];
    } else {
        self.managedObjectContext = document.managedObjectContext;
    }
}


-(void)performFetch{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Device"];
    self.devices = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
}

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    _managedObjectContext = managedObjectContext;
    [self performFetch];
}

-(void)setDevices:(NSArray *)devices{
    _devices = devices;
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.devices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSManagedObject *device = [self.devices objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@", [device valueForKey:@"name"], [device valueForKey:@"version"]]];
    [cell.detailTextLabel setText:[device valueForKey:@"company"]];
    
    return cell;
}


@end
