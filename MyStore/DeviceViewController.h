//
//  DeviceViewController.h
//  MyStore
//
//  Created by Simon on 9/12/12.
//  Modified by HeartNest 25/04/2013
//
//  Original Source&Documentation see: http://www.appcoda.com/introduction-to-core-data/


#import <UIKit/UIKit.h>

@interface DeviceViewController : UITableViewController

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;

@end
