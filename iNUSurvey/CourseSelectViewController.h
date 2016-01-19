//
//  CourseSelectViewController.h
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/4/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface CourseSelectViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

//Database related properties
@property(strong, nonatomic) NSString *databasePath;
@property(nonatomic) sqlite3 *DB;

//Picker related properties
@property (nonatomic, retain)NSMutableArray *coursesToSelect;
@property (weak, nonatomic) IBOutlet UIPickerView *courseSelectPicker;
@property (weak, nonatomic) NSString *courseSelection;

//Data passing related properties
@property (weak, nonatomic) NSString *strStudentID;
@property (nonatomic) int intEnrollmentID;
@property (strong, nonatomic) NSString *strClassNo;
@property (strong, nonatomic) NSString *strCourseNo;
@property (strong, nonatomic) NSString *strDescription;
@property (strong, nonatomic) NSString *strEnrollmentID;
@end
