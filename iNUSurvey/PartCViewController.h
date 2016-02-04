//
//  PartCViewController.h
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/16/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface PartCViewController : UIViewController

//data values that are passed to this view controller
@property (weak, nonatomic) NSString *studentID;
@property (weak, nonatomic) NSString *strDescription;
@property (weak, nonatomic) NSString *strCourseNo;
@property (weak, nonatomic) NSString *strClassNo;
@property (nonatomic) int intEnrollmentID;

@property(strong, nonatomic) NSString *databasePath;
@property(nonatomic) sqlite3 *DB;

 

// part of place holder
//@property (weak, nonatomic) IBOutlet UITextField *textView;
- (IBAction)showAlert:(id)sender;

@end
