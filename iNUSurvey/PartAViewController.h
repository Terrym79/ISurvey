//
//  PartAViewController.h
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/13/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface PartAViewController : UIViewController



//for array
//@property (nonatomic, retain) NSString *questionID;
//@property (nonatomic, retain) NSString *courseNo;
//@property (nonatomic, retain) NSString *surveyPart;
//@property (nonatomic, retain) NSString *questionTitle;
//@property (nonatomic, retain) NSString *questionNo;
@property (nonatomic, retain) NSString *question;
@property (nonatomic, retain) NSString *surveyPart;

@property (nonatomic, retain)NSMutableArray *questionArray;

//data values that are passed to this view controller
@property (weak, nonatomic) NSString *studentID;
@property (weak, nonatomic) NSString *strDescription;
@property (weak, nonatomic) NSString *strCourseNo;
@property (weak, nonatomic) NSString *strClassNo;
@property (nonatomic) int intEnrollmentID;

@property(strong, nonatomic) NSString *databasePath;
@property(nonatomic) sqlite3 *DB;

@end
