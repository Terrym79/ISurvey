//
//  PartBViewController.h
//  iNUSurvey
//
//  Created by Terry Minton on 2/3/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//


#define PartBViewController_h

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface PartBViewController : UIViewController


@property (nonatomic) int userAnswerTwo;
@property (nonatomic) int arrayCounter;

@property (nonatomic, retain) NSString *question;
@property (nonatomic, retain) NSString *surveyPart;

@property (nonatomic, retain)NSMutableArray *questionArrayTwo;
@property (nonatomic, retain)NSMutableArray *questionIdArrayTwo;
@property (nonatomic, retain)NSMutableArray *answerArrayTwo;

//data values that are passed to this view controller
@property (weak, nonatomic) NSString *studentID;
@property (weak, nonatomic) NSString *strDescription;
@property (weak, nonatomic) NSString *strCourseNo;
@property (weak, nonatomic) NSString *strClassNo;
@property (nonatomic) int intEnrollmentID;
@property (nonatomic, retain)NSMutableArray *questionArray;
@property (nonatomic, retain)NSMutableArray *questionIdArray;
@property (nonatomic, retain)NSMutableArray *answerArray;


@property(strong, nonatomic) NSString *databasePath;
@property(nonatomic) sqlite3 *DB;


@property (weak, nonatomic) IBOutlet UILabel *QuestionLabel;
@property (weak, nonatomic) IBOutlet UIButton *Button1;
@property (weak, nonatomic) IBOutlet UIButton *Button2;
@property (weak, nonatomic) IBOutlet UIButton *Button3;
@property (weak, nonatomic) IBOutlet UIButton *Button4;
@property (weak, nonatomic) IBOutlet UIButton *Button5;

- (IBAction)ButtonAnswersAction:(id)sender;



@end

