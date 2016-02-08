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


@property (weak, nonatomic) IBOutlet UILabel *QuestionLabel;
@property (nonatomic) int userAnswer;
@property (nonatomic) int arrayCounter;

//Stores the response 5=Strongly Agree, 4=Agree, etc.
@property (nonatomic) int response;

//BUTTONS
@property (weak, nonatomic) IBOutlet UIButton *Button1;

@property (weak, nonatomic) IBOutlet UIButton *Button2;

@property (weak, nonatomic) IBOutlet UIButton *Button3;

@property (weak, nonatomic) IBOutlet UIButton *Button4;

@property (weak, nonatomic) IBOutlet UIButton *Button5;

- (IBAction)ButtonAnswersAction:(id)sender;


@property (nonatomic, retain) NSString *question;
@property (nonatomic, retain) NSString *surveyPart;

@property (nonatomic, retain)NSMutableArray *questionArray;
@property (nonatomic, retain)NSMutableArray *questionIdArray;
@property (nonatomic, retain)NSMutableArray *answerArray;

//data values that are passed to this view controller
@property (weak, nonatomic) NSString *studentID;
@property (weak, nonatomic) NSString *strDescription;
@property (weak, nonatomic) NSString *strCourseNo;
@property (weak, nonatomic) NSString *strClassNo;
@property (nonatomic) int intEnrollmentID;

@property(strong, nonatomic) NSString *databasePath;
@property(nonatomic) sqlite3 *DB;



@end
