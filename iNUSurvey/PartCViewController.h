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

@property (weak, nonatomic) UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UILabel *CourseNoLabel;

@property (nonatomic, retain)NSMutableArray *questionArray;
@property (nonatomic, retain)NSMutableArray *questionIdArray;
@property (nonatomic, retain)NSMutableArray *answerArray;
@property (nonatomic, retain)NSMutableArray *questionArrayTwo;
@property (nonatomic, retain)NSMutableArray *questionIdArrayTwo;
@property (nonatomic, retain)NSMutableArray *answerArrayTwo;

//Comments textview
@property (weak, nonatomic) IBOutlet UITextView *Comments;

//DB variables
@property(strong, nonatomic) NSString *databasePath;
@property(nonatomic) sqlite3 *DB;

// part of place holder
- (IBAction)showAlert:(id)sender;
- (IBAction) BackButtonAction:(id)sender;
@end
