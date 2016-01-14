//
//  ViewController.h
//  iNUSurvey
//
//  Created by Terry Minton on 12/29/15.
//  Copyright © 2015 iSuperb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ViewController : UIViewController

@property(strong, nonatomic) NSString *databasePath;
@property(nonatomic) sqlite3 *DB;
@property(strong, nonatomic) IBOutlet UITextField *studentID;
@property(strong, nonatomic) IBOutlet UITextField *password;


- (IBAction) login:(id)sender;

@end

