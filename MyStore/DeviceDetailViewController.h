//
//  DeviceDetailViewController.h
//  MyStore
//
//  Created by Simon on 10/12/12.
//  Modified by HeartNest 25/04/2013
//
//  Original Source&Documentation see: http://www.appcoda.com/introduction-to-core-data/

#import <UIKit/UIKit.h>

@interface DeviceDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *versionTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) UIManagedDocument *document;

@end
