//
//  PartAViewController.m
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/13/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import "PartAViewController.h"
#import "IntroViewController.h"
#import "CourseSelectViewController.h"
#import "PartBViewController.h"

@interface PartAViewController ()

@property NSArray *responses;

@end

@implementation PartAViewController

@synthesize strClassNo, strCourseNo, strDescription, studentID, intEnrollmentID, answerValue;
@synthesize DB, databasePath, question, questionArray, surveyPart, answerArray, QuestionLabel;
@synthesize Button0, Button1, Button2, Button3, Button4, Button5, userAnswer, arrayCounter, questionIdArray, BackButton;

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    answerArray = [[NSMutableArray alloc] init];
    questionIdArray = [[NSMutableArray alloc] init];
    userAnswer = 0;
    
    //Initializes the detection for no selection made alert
    answerValue = -1;
    
    //BackButton initial appearance = OFF
    [BackButton setEnabled:NO];
    [BackButton setTintColor: [UIColor clearColor]];
    
    //Array for Questions
    questionArray = [[NSMutableArray alloc] init];
    
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
        printf("PartA Error: Database not ready!\n");  //Console output
    }
    
    //Database is found - Diagnostics
    else
    {
        printf("PartA Error: Database exists and is ready\n");  //Console output
    }
    
    sqlite3_stmt *statement;
    sqlite3_stmt *statementTwo;
    const char *dbpath = [databasePath UTF8String];
    
    //Database open is successful
    if(sqlite3_open(dbpath, &DB) == SQLITE_OK)
    {
        surveyPart = @"A";
        //strCourseNo =  @"CSC 480A";
    
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
            [questionArray addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)]];
        }

    }
    
        if(sqlite3_prepare_v2(DB, [querySQLTwo UTF8String], -1, &statementTwo, NULL) == SQLITE_OK) {
            while(sqlite3_step(statementTwo) == SQLITE_ROW) {
                NSLog(@"record found");
                char *temps = (char *)sqlite3_column_text(statementTwo, 0);
                
                //Adds query result objects to the array
                [questionIdArray addObject:[NSString stringWithUTF8String:(char *) temps]];
            }

        }
        else {
            //Diagnostic error messages if SQL query evaulation fails
            NSLog(@"statement Error %d", sqlite3_prepare_v2(DB, [querySQL UTF8String], -1, &statement, NULL));
            NSLog(@"Database returned error %d: %s", sqlite3_errcode(DB), sqlite3_errmsg(DB));
        }
        
        //Set the first question...
        QuestionLabel.text = [NSString stringWithFormat: @"%d.  %@", userAnswer + 1, questionArray[userAnswer]];
    
        //Diagnostic console output to show the variable data that is being passed to this view controller
        printf("%s\n", [studentID UTF8String]);
        printf("%s\n", [strDescription UTF8String]);
        printf("%s\n", [strCourseNo UTF8String]);
        printf("%s\n", [strClassNo UTF8String]);
        printf("%d\n", intEnrollmentID);
        
        sqlite3_finalize(statement);
        sqlite3_finalize(statementTwo);
        sqlite3_close(DB);
        
    }
    
    arrayCounter = [questionArray count];
    
    //Initializes the answer array
    //answerArray = [[NSMutableArray alloc] initWithCapacity:arrayCounter];
    for (NSInteger i = 0; i < arrayCounter; ++i)
    {
        //[answerArray addObject:[NSNull null]];
      //[NSNumber numberWithInt:answerValue]];
        
        [answerArray addObject:[NSNumber numberWithInt:-1]];
    }
    
}

- (IBAction)ButtonAnswersAction:(id)sender {
    
    //UIButton *btn = (UIButton *)sender;
   // NSString *title = btn.titleLabel.text;
   // [self.answerArray addObject:title];
    
    //Detects which button was selected and assigns a value to the response
    if ([sender isEqual:Button5]) {         //Strongly Agree = 5
        answerValue = 5;
        Button5.backgroundColor = [UIColor greenColor];
    }
    else if ([sender isEqual:Button4]) {    //Agree = 4
        answerValue = 4;
        Button4.backgroundColor = [UIColor greenColor];
    }
    else if ([sender isEqual:Button3]) {    //Neutral = 3
        answerValue = 3;
        Button3.backgroundColor = [UIColor greenColor];
    }
    else if ([sender isEqual:Button2]) {    //Disagree = 2
        answerValue = 2;
        Button2.backgroundColor = [UIColor greenColor];
    }
    else if ([sender isEqual:Button1]) {    //Strongly Disagree = 1
        answerValue = 1;
        Button1.backgroundColor = [UIColor greenColor];
    }
    else if ([sender isEqual:Button0]) {    //Not Applicable = 0
        answerValue = 0;
        Button0.backgroundColor = [UIColor greenColor];
    }
    
    //Diagnostic console output
    printf("PartA user answer: %d\n", userAnswer);
    printf("PartA question id array: %s\n", [questionIdArray[userAnswer] UTF8String]);
    printf("PartA student response: %d\n\n", answerValue);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Passing values to next View controller (Part B)
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.identifier isEqualToString:@"PartBViewControllerSegue"];
    PartBViewController *pbvc;
    pbvc = [segue destinationViewController];
    pbvc.studentID = studentID;
    pbvc.strDescription = strDescription;
    pbvc.strCourseNo = strCourseNo;
    pbvc.strClassNo = strClassNo;
    pbvc.intEnrollmentID = intEnrollmentID;
    pbvc.answerArray = answerArray;
    pbvc.questionIdArray = questionIdArray;
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
        //Change button color back to original
        Button0.backgroundColor = [UIColor lightGrayColor];
        Button1.backgroundColor = [UIColor lightGrayColor];
        Button2.backgroundColor = [UIColor lightGrayColor];
        Button3.backgroundColor = [UIColor lightGrayColor];
        Button4.backgroundColor = [UIColor lightGrayColor];
        Button5.backgroundColor = [UIColor lightGrayColor];
        
        [answerArray replaceObjectAtIndex:userAnswer withObject: [NSNumber numberWithInt:answerValue]];
        
        //Increments to next array element
        userAnswer++;
        
        //Resets BackButton to ON
        [BackButton setEnabled:YES];
        [BackButton setTintColor: nil];
        
        //Resets the detection for no selection made alert
        answerValue = -1;
        
        //Displays questions while inbounds of the array
        if (userAnswer < arrayCounter) {
            
            QuestionLabel.text = [NSString stringWithFormat: @"%d.  %@", userAnswer + 1, questionArray[userAnswer]];
        }
        
        //Last question answered, proceed to PartB
        else if (userAnswer >= arrayCounter) {
            
            //Segue transition to PartBViewController
            [self performSegueWithIdentifier:@"PartBViewControllerSegue" sender:sender];
        }
    }
}

-(IBAction)BackButtonAction:(id)sender {
    
    //Change button color back to original
    Button0.backgroundColor = [UIColor lightGrayColor];
    Button1.backgroundColor = [UIColor lightGrayColor];
    Button2.backgroundColor = [UIColor lightGrayColor];
    Button3.backgroundColor = [UIColor lightGrayColor];
    Button4.backgroundColor = [UIColor lightGrayColor];
    Button5.backgroundColor = [UIColor lightGrayColor];
  
    //Decrements an array element
    --userAnswer;
    
    //Landed at first question, disable BackButton and make invisible
    if (userAnswer == 0) {
        [BackButton setEnabled:NO];
        [BackButton setTintColor: [UIColor clearColor]];
    }
    
    //Refresh with question for this array element
    QuestionLabel.text = [NSString stringWithFormat: @"%d.  %@", userAnswer + 1, questionArray[userAnswer]];
    
    //Diagnostic console output
    NSLog(@"PartA Backbutton presed\n");
    printf("PartA user answer: %d\n", userAnswer);
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
