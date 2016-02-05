//
//  PartCViewController.m
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/16/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import "PartCViewController.h"
#import "PartDViewController.h"

@interface PartCViewController ()

@end

@implementation PartCViewController

@synthesize strClassNo, strCourseNo, strDescription, studentID, intEnrollmentID;
@synthesize DB, databasePath;
@synthesize questionArray, questionArrayTwo, questionIdArray, questionIdArrayTwo, answerArray,answerArrayTwo,Comments;

// part of placeholder
//@synthesize textView;

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // self.textView.placeholder = @"place"; (place holder)
   
}

- (IBAction)BackToCOurseButtonAction:(id)sender {
    NSString *commentsString = Comments.text;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Releases the keyboard
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    

    UIAlertAction *backtAction = [UIAlertAction actionWithTitle:@"Back" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        //User Text Comments
        NSString *commentsText = Comments.text;
        
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
    
        //Go To Last Page
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PartDViewController *viewController = (PartDViewController *)[storyboard instantiateViewControllerWithIdentifier:@"PartDViewController"];
        [self presentViewController:viewController animated:YES completion:nil];
    
    
    }];
    

    
    [alert addAction:backtAction];
    [alert addAction:submitAction];
    
   
    
    [self presentViewController:alert animated:YES completion:nil];
}


//Passing values to next View controller (Part D)
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PartDViewController *pavc4;
    pavc4  = [segue destinationViewController];
    pavc4.studentID = studentID;
    pavc4.strDescription = strDescription;
    pavc4.strCourseNo = strCourseNo;
    pavc4.strClassNo = strClassNo;
    pavc4.intEnrollmentID = intEnrollmentID;
    
    printf("Entered username: %s\n", [pavc4.studentID UTF8String]);
    printf("Entered courseNumber: %s\n", [pavc4.strCourseNo UTF8String]);
}



@end
