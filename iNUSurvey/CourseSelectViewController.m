//
//  CourseSelectViewController.m
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/4/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import "CourseSelectViewController.h"

//For passing values to the PartAViewController
#import "PartAViewController.h"

@interface CourseSelectViewController ()
@end

@implementation CourseSelectViewController

@synthesize strStudentID, coursesToSelect, courseSelection, intEnrollmentID, strClassNo, databasePath, DB, courseSelectPicker, strDescription, strCourseNo, strEnrollmentID;

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
        NSString *querySQL = [NSString stringWithFormat:@"SELECT COURSES.CourseNo, COURSES.Description, ENROLLMENT.EnrollmentID, ENROLLMENT.ClassNo FROM COURSES INNER JOIN CLASSES ON COURSES.CourseNo = CLASSES.CourseNo INNER JOIN ENROLLMENT ON ENROLLMENT.ClassNo = CLASSES.ClassNo INNER JOIN STUDENT ON STUDENT.StudentID = ENROLLMENT.StudentID WHERE STUDENT.StudentID = '%@' AND ENROLLMENT.SurveyCompleted = '%d'", strStudentID, 0];
        
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
            NSLog(@"statement Error %d", sqlite3_prepare_v2(DB, query_statement, -1, &statement, NULL));
            NSLog(@"Database returned error %d: %s", sqlite3_errcode(DB), sqlite3_errmsg(DB));
        }
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
        NSString *querySQL = [NSString stringWithFormat:@"SELECT COURSES.CourseNo, COURSES.Description, ENROLLMENT.EnrollmentID, ENROLLMENT.ClassNo FROM COURSES INNER JOIN CLASSES ON COURSES.CourseNo = CLASSES.CourseNo INNER JOIN ENROLLMENT ON ENROLLMENT.ClassNo = CLASSES.ClassNo INNER JOIN STUDENT ON STUDENT.StudentID = ENROLLMENT.StudentID WHERE STUDENT.StudentID = '%@' AND ENROLLMENT.SurveyCompleted = '%d' AND CLASSES.CourseNo = '%@'", strStudentID, 0, courseSelection];
        
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
                printf("CourseNo: %s\n", [strCourseNo UTF8String]);
                printf("EnrollmentID:  %d\n", intEnrollmentID);
                printf("ClassNo:  %s\n\n", [strClassNo UTF8String]);
            }
            //No query results exist
            else
            {
                //Diagnostic error messages if SQL query evaulation fails
                NSLog(@"statement Error %d", sqlite3_prepare_v2(DB, query_statement, -1, &statement, NULL));
                NSLog(@"Database returned error %d: %s", sqlite3_errcode(DB), sqlite3_errmsg(DB));
            }
        }
    }
}

//Passing values to next View controller (Part A)
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PartAViewController *pavc;
    pavc  = [segue destinationViewController];
    pavc.strStudentID = strStudentID;
    pavc.strDescription = strDescription;
    pavc.strCourseNo = strCourseNo;
    pavc.strClassNo = strClassNo;
    pavc.intEnrollmentID = intEnrollmentID;
}

- (IBAction)nextButton:(id)sender {
    if(courseSelection != NULL)
    {
        //Will move to next View controller
    }
    //If no course selection is made, an error will occur, forcing a selection retry
    else
    {
        UIAlertController *loginFailed = [UIAlertController alertControllerWithTitle: @"Selection Error" message: @"Course was not selected.\n\n  Please try again" preferredStyle: UIAlertControllerStyleAlert];
            
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle: @"Dismiss" style: UIAlertActionStyleDestructive handler: nil];
            
        [loginFailed addAction: alertAction];
            
        [self presentViewController:loginFailed animated:YES completion:nil];
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