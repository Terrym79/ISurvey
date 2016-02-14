//
//  PartCViewController.m
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/16/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import "PartBViewController.h"
#import "PartCViewController.h"
#import "PartDViewController.h"

@interface PartCViewController ()

@end

@implementation PartCViewController

@synthesize strClassNo, strCourseNo, strDescription, studentID, intEnrollmentID, DB, databasePath, Comments;
@synthesize questionIdArray, answerArray, questionIdArrayTwo, answerArrayTwo;

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Diagnostic console output to show the variable data that is being passed to this view controller
    printf("PartC %s\n", [studentID UTF8String]);
    printf("PartC %s\n", [strDescription UTF8String]);
    printf("PartC %s\n", [strCourseNo UTF8String]);
    printf("PartC %s\n", [strClassNo UTF8String]);
    printf("PartC %d\n", intEnrollmentID);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Releases the keyboard
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)showAlert:(id)sender {

    //Database path location building
    NSArray *dirPaths;
    NSString *docsDir;
    
    //Get the directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    //Appends the DB filename to the DB path
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"iNUSurvey.sql"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CONFIRMATION" message:@"Are you ready to submit your responses?" preferredStyle:UIAlertControllerStyleAlert];
    
    //Alert response = Back (Remains at PartC for text editing)
    UIAlertAction *backAction = [UIAlertAction actionWithTitle:@"Back" style:UIAlertActionStyleDestructive handler: nil];
    
    //Alert response = Submit
    UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        //User Text Comments
        NSString *commentsText = Comments.text;
 
        
        //SQL query to INSERT the comments into the Part=A, QuestionNo=1 record for the student
        //SQL statement goes here
        //
        //
        ////////////////////////////////////////////////////////////////////////////////////////
        
        
        //SQL query to UPDATE the Enrollment record SurveyCompleted bit = 1 (completed)
        //SQL statement goes here
        //
        //
        ///////////////////////////////////////////////////////////////////////////////////////
        
        
        //Database open is successful
        //FOR PART A
        for(int i = 0; i < [questionIdArray count]; i++)
        {
            
            NSString *string = [questionIdArray objectAtIndex:(i)];
            NSInteger value = [string intValue];
            NSString *answerString = [answerArray objectAtIndex: (i)];
            //long enrollmentID = intEnrollmentID;

            
            if(sqlite3_open(dbpath, &DB) == SQLITE_OK)
            {
                NSString *querySQLThree = [NSString stringWithFormat: @"INSERT INTO RESPONSES (EnrollmentID, QuestionID, QuestionResponse, Comment) VALUES ('%d', '%ld', '%@', '%@')", intEnrollmentID, (long)value, answerString, commentsText];
                
                 const char *query_statementOne = [querySQLThree UTF8String];
                
                if(sqlite3_prepare_v2(DB, query_statementOne, -1, &statement, NULL) == SQLITE_OK)
                {
            
                sqlite3_exec(DB, [querySQLThree UTF8String], NULL, NULL, NULL);
                
                }
            }
            sqlite3_close(DB);
        }
        
        
        //FOR PART B
        for(int i = 0; i < [questionIdArrayTwo count]; i++)
        {
            
            NSString *string = [questionIdArrayTwo objectAtIndex:(i)];
            NSInteger value = [string intValue];
            NSString *answerString = [answerArrayTwo objectAtIndex: (i)];
            //long enrollmentID = intEnrollmentID;
            
            if(sqlite3_open(dbpath, &DB) == SQLITE_OK)
            {
                NSString *querySQLFour = [NSString stringWithFormat: @"INSERT INTO RESPONSES (EnrollmentID, QuestionID, QuestionResponse, Comment) VALUES ('%d', '%ld', '%@', '%@')", intEnrollmentID, (long)value, answerString, commentsText];
                
                const char *query_statementTwo = [querySQLFour UTF8String];
                
                if(sqlite3_prepare_v2(DB, query_statementTwo, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_exec(DB, [querySQLFour UTF8String], NULL, NULL, NULL);
                }
            }
            sqlite3_close(DB);
        }
        
        //Set the SurveyCompleted Flag (ENROLLMENT TABLE) = 1 (completed)
        //SQL Statement to UPDATE Record
        //
        //
        ///////////////////////////////////////////////////////////////////////
      
        //Segue transition to PartDViewController
        [self performSegueWithIdentifier:@"PartDViewController" sender:sender];
        
         }];
    
    [alert addAction:backAction];
    [alert addAction:submitAction];
    [self presentViewController:alert animated:YES completion:nil];
}

//Passing values to next View controller (Part D)
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"PartDViewController"]) {
       PartDViewController *pdvc;
       pdvc  = [segue destinationViewController];
       pdvc.studentID = studentID;
       pdvc.intEnrollmentID = intEnrollmentID;
    }
    if([segue.identifier isEqualToString:@"PartCToPartBSegue"]){
        PartBViewController *pbvc;
        pbvc  = [segue destinationViewController];
        pbvc.studentID = studentID;
        pbvc.strDescription = strDescription;
        pbvc.strCourseNo = strCourseNo;
        pbvc.strClassNo = strClassNo;
        pbvc.intEnrollmentID = intEnrollmentID;
    }
}

- (IBAction) BackButtonAction:(id)sender {
     [self performSegueWithIdentifier:@"PartCToPartBSegue" sender:sender];
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
