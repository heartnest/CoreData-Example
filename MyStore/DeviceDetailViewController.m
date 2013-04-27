//
//  DeviceDetailViewController.m
//  MyStore
//
//  Created by Simon on 10/12/12.
//  Modified by HeartNest 25/04/2013
//
//  Original Source&Documentation see: http://www.appcoda.com/introduction-to-core-data/

#import "DeviceDetailViewController.h"

@interface DeviceDetailViewController ()

@end

@implementation DeviceDetailViewController

- (void)useDemoDocument
{
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:@"XDocument"];
    self.document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        [self.document saveToURL:url
           forSaveOperation:UIDocumentSaveForCreating
          completionHandler:^(BOOL success) {
              if (success) {
                  self.managedObjectContext = self.document.managedObjectContext;
              }
          }];
    } else if (self.document.documentState == UIDocumentStateClosed) {
        [self.document openWithCompletionHandler:^(BOOL success) {
            if (success) {
                self.managedObjectContext = self.document.managedObjectContext;
            }
        }];
    } else {
        self.managedObjectContext = self.document.managedObjectContext;
    }
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self useDemoDocument];
	// Do any additional setup after loading the view.
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    // Create a new managed object
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:self.managedObjectContext];
    [newDevice setValue:self.nameTextField.text forKey:@"name"];
    [newDevice setValue:self.versionTextField.text forKey:@"version"];
    [newDevice setValue:self.companyTextField.text forKey:@"company"];
    
    NSError *error = nil;
    
    // Save the object to persistent store
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }else{
    //IMPORTANT! Save context to file system.
        [self.document saveToURL:self.document.fileURL
                forSaveOperation:UIDocumentSaveForOverwriting
               completionHandler:^(BOOL success) {
                   if (success) {
                       //NSLog(@"doc saved ...");
                   }
                   else{
                       NSLog(@"doc not saved ...");
                   }
               }];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
