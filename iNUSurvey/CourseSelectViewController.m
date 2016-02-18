//
//  CourseSelectViewController.m
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/4/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import "CourseSelectViewController.h"
#import "IntroViewController.h"
#import "LoginViewController.h"

//For passing values to the PartAViewController
#import "PartAViewController.h"

@interface CourseSelectViewController ()
@end

@implementation CourseSelectViewController

@synthesize studentID, coursesToSelect, courseSelection, intEnrollmentID, strClassNo, databasePath, DB, courseSelectPicker, strDescription, strCourseNo, strEnrollmentID, CancelButton;

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initialized Array
    coursesToSelect = [[NSMutableArray alloc] init];
    
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
    const char *dbpath = [databasePath UTF8String];
    
    //Database open is successful
    if(sqlite3_open(dbpath, &DB) == SQLITE_OK)
    {
        //Query to determine eligible courses that have not been evaluated
        NSString *querySQL = [NSString stringWithFormat:@"SELECT COURSES.CourseNo, COURSES.Description, ENROLLMENT.EnrollmentID, ENROLLMENT.ClassNo FROM COURSES INNER JOIN CLASSES ON COURSES.CourseNo = CLASSES.CourseNo INNER JOIN ENROLLMENT ON ENROLLMENT.ClassNo = CLASSES.ClassNo INNER JOIN STUDENT ON STUDENT.StudentID = ENROLLMENT.StudentID WHERE STUDENT.StudentID = '%@' AND ENROLLMENT.SurveyCompleted = '%d'", studentID, 0];
        
        const char *query_statement = [querySQL UTF8String];
        
        if(sqlite3_prepare_v2(DB, query_statement, -1, &statement, NULL) == SQLITE_OK)
        {
           //Query results exist
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                //Adds query result objects to the PickerView
                [coursesToSelect addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)]];
            }
        }
        else
        {
            //Diagnostic error messages if SQL query evaulation fails
            NSLog(@"CourseSelect Statement Error %d", sqlite3_prepare_v2(DB, query_statement, -1, &statement, NULL));
            NSLog(@"CourseSelect Database returned error %d: %s", sqlite3_errcode(DB), sqlite3_errmsg(DB));
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(DB);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//The number of columns of data (CourseNo, CourseDescription)
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//The number of rows of data (Eligible courses to be evaluated)
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.coursesToSelect count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.coursesToSelect[row];
}

//Selection of Picker item occurs
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED
{
   // NSString *courseSelection;
    row = [courseSelectPicker selectedRowInComponent:0];
    courseSelection = [coursesToSelect objectAtIndex:row];
    
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    
    //Database open is successful
    if(sqlite3_open(dbpath, &DB) == SQLITE_OK)
    {
        //Query to determine eligible courses that have not been evaluated
        NSString *querySQL = [NSString stringWithFormat:@"SELECT COURSES.CourseNo, COURSES.Description, ENROLLMENT.EnrollmentID, ENROLLMENT.ClassNo FROM COURSES INNER JOIN CLASSES ON COURSES.CourseNo = CLASSES.CourseNo INNER JOIN ENROLLMENT ON ENROLLMENT.ClassNo = CLASSES.ClassNo INNER JOIN STUDENT ON STUDENT.StudentID = ENROLLMENT.StudentID WHERE STUDENT.StudentID = '%@' AND ENROLLMENT.SurveyCompleted = '%d' AND CLASSES.CourseNo = '%@'", studentID, 0, courseSelection];
        
        const char *query_statement = [querySQL UTF8String];
        
        if(sqlite3_prepare_v2(DB, query_statement, -1, &statement, NULL) == SQLITE_OK)
        {
            //Query results exist
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                //Parses the query result to associate values to variables that will be passed forward to other view controllers
                strCourseNo = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 0)];
                strDescription = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 1)];
                strEnrollmentID = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 2)];
                intEnrollmentID = [strEnrollmentID intValue];
                strClassNo = [[NSString alloc]initWithUTF8String: (const char *) sqlite3_column_text(statement, 3)];
                
                //Diagnostic output to console
                printf("CourseSelect StudentID: %s\n", [studentID UTF8String]);
                printf("CourseSelect CourseNo: %s\n", [strCourseNo UTF8String]);
                printf("CourseSelect EnrollmentID:  %d\n", intEnrollmentID);
                printf("CourseSelect ClassNo:  %s\n\n", [strClassNo UTF8String]);
            }
            //No query results exist
            else
            {
                //Diagnostic error messages if SQL query evaulation fails
                NSLog(@"CourseSelect statement Error %d", sqlite3_prepare_v2(DB, query_statement, -1, &statement, NULL));
                NSLog(@"CourseSelect Database returned error %d: %s", sqlite3_errcode(DB), sqlite3_errmsg(DB));
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(DB);
    }
}

//Passing values to next View controller (Part A)
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PartAViewControllerSegue"]){
        PartAViewController *pavc;
        pavc  = [segue destinationViewController];
        pavc.studentID = studentID;
        pavc.strDescription = strDescription;
        pavc.strCourseNo = strCourseNo;
        pavc.strClassNo = strClassNo;
        pavc.intEnrollmentID = intEnrollmentID;
        printf("Entered username: %s\n", [pavc.studentID UTF8String]);
        printf("Entered courseNumber: %s\n", [pavc.strCourseNo UTF8String]);
    }
}

//Cancel button clears variables, closes the DB, reloads the Login VC
- (IBAction)CancelButtonAction:(id)sender {
    //Close the database connection
    sqlite3_close(DB);
    
    //Clear variables
    intEnrollmentID = 0;
    studentID = NULL;
    [coursesToSelect removeAllObjects];
    courseSelection = NULL;
    strClassNo = NULL;
    databasePath = NULL;
    strDescription = NULL;
    strCourseNo = NULL;
    strEnrollmentID = NULL;
    
    //Return to LoginViewController
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *viewController = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
}

//Next button verifies that a selection has been made, the proceeds to Part A VC
- (IBAction)NextButtonAction:(id)sender {
    
    printf("courseSelection:  %s\n\n", [courseSelection UTF8String]);
    
    if(courseSelection != NULL)
    {
        //Proceed to PartAViewController
        [self performSegueWithIdentifier:@"PartAViewControllerSegue" sender:sender];
    }
    
    //If no course selection is made, an error will occur, forcing a selection retry
    else
    {
        UIAlertController *NoCourseSelection = [UIAlertController alertControllerWithTitle: @"Selection Error" message: @"Course was not selected.\n\n  Please try again" preferredStyle: UIAlertControllerStyleAlert];
            
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle: @"Dismiss" style: UIAlertActionStyleDestructive handler: nil];
            
        [NoCourseSelection addAction: alertAction];
            
        [self presentViewController:NoCourseSelection animated:YES completion:nil];
    }
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