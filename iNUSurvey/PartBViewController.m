//
//  PartBViewController.m
//  iNUSurvey
//
//  Created by Terry Minton on 2/3/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import "PartBViewController.h"
#import "PartCViewController.h"
#import "PartAViewController.h"

@interface PartBViewController ()

@property NSArray *responses;

@end

@implementation PartBViewController

@synthesize strClassNo, strCourseNo, strDescription, studentID, intEnrollmentID, answerValue, answerArray, questionIdArray;
@synthesize DB, databasePath, question, questionArrayTwo, surveyPart, answerArrayTwo, QuestionLabel;
@synthesize Button0, Button1, Button2, Button3, Button4, Button5, userAnswerTwo, arrayCounter,questionIdArrayTwo, BackButton;

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    answerArrayTwo = [[NSMutableArray alloc] init];
    questionIdArrayTwo = [[NSMutableArray alloc] init];
    userAnswerTwo = 0;
    
    //Initializes the detection for no selection made alert
    answerValue = -1;
    
    //BackButton initial appearance = OFF
    [BackButton setEnabled:NO];
    [BackButton setTintColor: [UIColor clearColor]];
    
    //Array for Questions
    questionArrayTwo = [[NSMutableArray alloc] init];
    
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
        printf("PartB Error: Database not ready!\n");  //Console output
    }
    
    //Database is found - Diagnostics
    else
    {
        printf("PartB Error: Database exists and is ready\n");  //Console output
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
        
        if(sqlite3_prepare_v2(DB, [querySQLTwo UTF8String], -1, &statementTwo, NULL) == SQLITE_OK) {
            while(sqlite3_step(statementTwo) == SQLITE_ROW) {
                NSLog(@"record found");
                char *temps = (char *)sqlite3_column_text(statementTwo, 0);
                
                //Adds query result objects to the array
                [questionIdArrayTwo addObject:[NSString stringWithUTF8String:(char *) temps]];
            }
        }
        
        else {
            //Diagnostic error messages if SQL query evaulation fails
            NSLog(@"PartB statement Error %d", sqlite3_prepare_v2(DB, [querySQL UTF8String], -1, &statement, NULL));
            NSLog(@"PartB Database returned error %d: %s", sqlite3_errcode(DB), sqlite3_errmsg(DB));
        }
        
        //Set the first question...
        QuestionLabel.text = [NSString stringWithFormat: @"%d.  %@", userAnswerTwo + 1, questionArrayTwo[userAnswerTwo]];
        
        //Diagnostic console output to show the variable data that is being passed to this view controller
        printf("PartB %s\n", [studentID UTF8String]);
        printf("PartB %s\n", [strDescription UTF8String]);
        printf("PartB %s\n", [strCourseNo UTF8String]);
        printf("PartB %s\n", [strClassNo UTF8String]);
        printf("PartB %d\n", intEnrollmentID);
    }
    
    arrayCounter = [questionArrayTwo count];
    
    //Initializes the answer array for PartB
    for (NSInteger i = 0; i < arrayCounter; ++i)
    {
        [answerArrayTwo addObject:[NSNull null]];
    }
}

- (IBAction)ButtonAnswersAction:(id)sender {
    
    //UIButton *btn = (UIButton *)sender;
    //NSString *title = btn.titleLabel.text;
    //[self.answerArrayTwo addObject:title];
    
    //Detects which button was selected and assigns a value to the response
    if ([sender isEqual:Button5]) {         //Strongly Agree = 5
        answerValue = 5;
    }
    else if ([sender isEqual:Button4]) {    //Agree = 4
        answerValue = 4;
    }
    else if ([sender isEqual:Button3]) {    //Neutral = 3
        answerValue = 3;
    }
    else if ([sender isEqual:Button2]) {    //Disagree = 2
        answerValue = 2;
    }
    else if ([sender isEqual:Button1]) {    //Strongly Disagree = 1
        answerValue = 1;
    }
    else if ([sender isEqual:Button0]) {    //Not Applicable = 0
        answerValue = 0;
    }
    
    //Diagnostic console output
    printf("PartB user answer: %d\n", userAnswerTwo);
    printf("PartB question id array: %s\n", [questionIdArrayTwo[userAnswerTwo] UTF8String]);
    printf("PartB student response: %d\n\n", answerValue);
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Passing values to next View controller (Part C)
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.identifier isEqualToString:@"SegueToPartC"];
    PartCViewController *pcvc;
    pcvc  = [segue destinationViewController];
    pcvc.studentID = studentID;
    pcvc.strDescription = strDescription;
    pcvc.strCourseNo = strCourseNo;
    pcvc.strClassNo = strClassNo;
    pcvc.intEnrollmentID = intEnrollmentID;
    pcvc.answerArray = answerArray;
    pcvc.questionIdArray = questionIdArray;
    pcvc.answerArrayTwo = answerArrayTwo;
    pcvc.questionIdArrayTwo = questionIdArrayTwo;
}

-(IBAction)NextButtonAction:(id)sender {
    
    //Generates an alert due to no selection being made
    if(answerValue == -1) {
        UIAlertController *NoSelectionMade = [UIAlertController alertControllerWithTitle: @"Selection Error" message: @"A selection was not made.\n\n  Please try again" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle: @"Dismiss" style: UIAlertActionStyleDestructive handler: nil];
        [NoSelectionMade addAction: alertAction];
        
        [self presentViewController:NoSelectionMade animated:YES completion:nil];
    }
    
    else {
        
        //Populates userAnswerTwo array for Part B
        [answerArrayTwo replaceObjectAtIndex:userAnswerTwo withObject: [NSNumber numberWithInt:answerValue]];
        
        //Increments to next array element
        userAnswerTwo++;
        
        //Resets BackButton to ON
        [BackButton setEnabled:YES];
        [BackButton setTintColor: nil];
        
        //Resets the detection for no selection made alert
        answerValue = -1;
        
        //Displays questions while inbounds of the array
        if (userAnswerTwo < arrayCounter) {
      
            QuestionLabel.text = [NSString stringWithFormat: @"%d.  %@", userAnswerTwo + 1, questionArrayTwo[userAnswerTwo]];
        }
        
        //Last question answered, proceed to PartB
        else if(userAnswerTwo >= arrayCounter) {
            
            //Segue transition to PartCViewController
            [self performSegueWithIdentifier:@"SegueToPartC" sender:sender];
        }
    }
}

-(IBAction)BackButtonAction:(id)sender {
    //Decrements an array element
    --userAnswerTwo;
    
    //Landed at first question, disable BackButton and make invisible
    if (userAnswerTwo == 0) {
        [BackButton setEnabled:NO];
        [BackButton setTintColor: [UIColor clearColor]];
    }
    
    //Refresh with question for this array element
    QuestionLabel.text = [NSString stringWithFormat: @"%d.  %@", userAnswerTwo + 1, questionArrayTwo[userAnswerTwo]];
    
    //Diagnostic console output
    NSLog(@"PartB Backbutton presed\n");
    printf("PartB user answer: %d\n", userAnswerTwo);
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