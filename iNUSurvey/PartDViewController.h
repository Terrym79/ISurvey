//
//  PartDViewController.h
//  iNUSurvey
//
//  Created by Terry Minton on 2/4/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface PartDViewController : UIViewController

//data values that are passed to this view controller
@property (weak, nonatomic) NSString *studentID;
@property (nonatomic) int intEnrollmentID;

@property(strong, nonatomic) NSString *databasePath;
@property(nonatomic) sqlite3 *DB;

@property (weak, nonatomic) IBOutlet UIButton *BackToCourseButton;

@property (weak, nonatomic) IBOutlet UIButton *LogoutButton;

- (IBAction)BackToCourseButtonAction:(id)sender;

- (IBAction)LogoutButtonAction:(id)sender;


@end
