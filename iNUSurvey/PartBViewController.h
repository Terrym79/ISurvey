//
//  PartBViewController.h
//  iNUSurvey
//
//  Created by Terry Minton on 2/3/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface PartBViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *QuestionLabel;
@property (weak, nonatomic) IBOutlet UINavigationBar *CourseTitle;

@property (nonatomic) int userAnswerTwo;
@property (nonatomic) int arrayCounter;

//Stores the response 5=Strongly Agree, 4=Agree, etc.
@property (nonatomic) int answerValue;

//Buttons
@property (weak, nonatomic) IBOutlet UIButton *Button5;  //Strongly Agree = 5
@property (weak, nonatomic) IBOutlet UIButton *Button4;  //Agree = 4
@property (weak, nonatomic) IBOutlet UIButton *Button3;  //Neutral = 3
@property (weak, nonatomic) IBOutlet UIButton *Button2;  //Disagree = 2
@property (weak, nonatomic) IBOutlet UIButton *Button1;  //Strongly Disagree = 1
@property (weak, nonatomic) IBOutlet UIButton *Button0;  //N/A = 0

//Navigation Buttons
@property (weak, nonatomic) IBOutlet UIBarButtonItem *NextButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *BackButton;

@property (nonatomic, retain) NSString *question;
@property (nonatomic, retain) NSString *surveyPart;

/*
@property (nonatomic, retain)NSMutableArray *questionArray;
@property (nonatomic, retain)NSMutableArray *questionIdArray;
@property (nonatomic, retain)NSMutableArray *answerArray;
 */

@property (nonatomic, retain)NSMutableArray *questionArrayTwo;
@property (nonatomic, retain)NSMutableArray *questionIdArrayTwo;
@property (nonatomic, retain)NSMutableArray *answerArrayTwo;
 
//data values that are passed to this view controller
@property (weak, nonatomic) NSString *studentID;
@property (weak, nonatomic) NSString *strDescription;
@property (weak, nonatomic) NSString *strCourseNo;
@property (weak, nonatomic) NSString *strClassNo;
@property (nonatomic) int intEnrollmentID;

@property(strong, nonatomic) NSString *databasePath;
@property(nonatomic) sqlite3 *DB;

- (IBAction)ButtonAnswersAction:(id)sender;
- (IBAction) NextButtonAction:(id)sender;
- (IBAction) BackButtonAction:(id)sender;

@end

