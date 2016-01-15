//
//  LoginViewController.h
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/4/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface LoginViewController : UIViewController

@property(strong, nonatomic) NSString *databasePath;
@property(nonatomic) sqlite3 *DB;
@property(strong, nonatomic) IBOutlet UITextField *studentID;
@property(strong, nonatomic) IBOutlet UITextField *password;

- (IBAction) login:(id)sender;

@end
