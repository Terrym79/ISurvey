//
//  PartBViewController.m
//  iNUSurvey
//
//  Created by Terry Minton on 2/3/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartBViewController.h"
#import "PartCViewController.h"
#import "PartAViewController.h"


@interface PartBViewController ()

@property NSArray *responses;

@end

@implementation PartBViewController

@synthesize strClassNo, strCourseNo, strDescription, studentID, intEnrollmentID;
@synthesize DB, databasePath, question, questionArrayTwo, surveyPart, answerArrayTwo, QuestionLabel;
@synthesize Button1, Button2, Button3, Button4, Button5, userAnswerTwo, arrayCounter,questionIdArrayTwo;
@synthesize questionArray, questionIdArray, answerArray;

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.answerArrayTwo = [[NSMutableArray alloc] init];
    self.questionIdArrayTwo = [[NSMutableArray alloc] init];
    self.questionArrayTwo = [[NSMutableArray alloc] init];
    self.userAnswerTwo = 0;
    
    
    //Database path location building
    NSArray *dirPaths;
    NSString *docsDir;
    
    //Get the directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    //Appends the DB filename to the DB path
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"iNUSurvey.sql"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //Database not found - Diagnostics
    if([filemgr fileExistsAtPath:databasePath] == NO)
    {
        printf("CourseSelect Module Error: Database not ready!\n");  //Console output
    }
    
    //Database is found - Diagnostics
    else
    {
        printf("CourseSelect Module: Database exists and is ready\n");  //Console output
    }
    
    
    sqlite3_stmt *statement;
    sqlite3_stmt *statementTwo;
    const char *dbpath = [databasePath UTF8String];
    
    //Database open is successful
    if(sqlite3_open(dbpath, &DB) == SQLITE_OK)
    {
        surveyPart = @"B";
        strCourseNo = @"CSC 480A";
        
        //Query to get all of the questions
        NSString *querySQL = [NSString stringWithFormat:@"SELECT SURVEY_QUESTIONS.Question FROM SURVEY_QUESTIONS WHERE SURVEY_QUESTIONS.CourseNo = '%@' AND SURVEY_QUESTIONS.SurveyPart = '%@'", strCourseNo, surveyPart];
        
        //Query to get all of the questions
        NSString *querySQLTwo = [NSString stringWithFormat:@"SELECT SURVEY_QUESTIONS.QuestionID FROM SURVEY_QUESTIONS WHERE SURVEY_QUESTIONS.CourseNo = '%@' AND SURVEY_QUESTIONS.SurveyPart = '%@'", strCourseNo, surveyPart];
        
        //Database open is successful
        if(sqlite3_prepare_v2(DB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                
                //Adds query result objects to the array
                [questionArrayTwo addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)]];
            }
        }
        
        if(sqlite3_prepare_v2(DB, [querySQLTwo UTF8String], -1, &statementTwo, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statementTwo) == SQLITE_ROW)
            {
                NSLog(@"record found");
                char *temps = (char *)sqlite3_column_text(statementTwo, 0);
                //Adds query result objects to the array
                [questionIdArrayTwo addObject:[NSString stringWithUTF8String:(char *) temps]];
            }
            
        }
        else
        {
            //Diagnostic error messages if SQL query evaulation fails
            NSLog(@"statement Error %d", sqlite3_prepare_v2(DB, [querySQL UTF8String], -1, &statement, NULL));
            NSLog(@"Database returned error %d: %s", sqlite3_errcode(DB), sqlite3_errmsg(DB));
        }
        
        
        //Set the first question...
        QuestionLabel.text = questionArrayTwo[userAnswerTwo];
        
        //Diagnostic console output to show the variable data that is being passed to this view controller
        printf("%s\n", [studentID UTF8String]);
        printf("%s\n", [strDescription UTF8String]);
        printf("%s\n", [strCourseNo UTF8String]);
        printf("%s\n", [strClassNo UTF8String]);
        printf("%d\n", intEnrollmentID);
        
        
    }
    
    arrayCounter = [questionArray count];
    
}




- (IBAction)ButtonAnswersAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    NSString *title = btn.titleLabel.text;
    [self.answerArrayTwo addObject:title];
    
    userAnswerTwo++;
    if (userAnswerTwo < arrayCounter) {
        QuestionLabel.text = questionArrayTwo[userAnswerTwo];
    }
    else if (userAnswerTwo >= arrayCounter) {
        QuestionLabel.text = @"Finished! Click Next To Continue To Next Section";
        self.Button1.hidden = YES;
        self.Button2.hidden = YES;
        self.Button3.hidden = YES;
        self.Button4.hidden = YES;
        self.Button5.hidden = YES;
        
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Passing values to next View controller (Part C)
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PartCViewController *pavc3;
    pavc3  = [segue destinationViewController];
    pavc3.studentID = studentID;
    pavc3.strDescription = strDescription;
    pavc3.strCourseNo = strCourseNo;
    pavc3.strClassNo = strClassNo;
    pavc3.intEnrollmentID = intEnrollmentID;
    pavc3.questionArray = questionArray;
    pavc3.questionArrayTwo = questionArrayTwo;
    pavc3.questionIdArray = questionIdArray;
    pavc3.questionIdArrayTwo = questionIdArrayTwo;
    pavc3.answerArray = answerArray;
    pavc3.answerArrayTwo = answerArrayTwo;
    
    
    printf("Entered username: %s\n", [pavc3.studentID UTF8String]);
    printf("Entered courseNumber: %s\n", [pavc3.strCourseNo UTF8String]);
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end