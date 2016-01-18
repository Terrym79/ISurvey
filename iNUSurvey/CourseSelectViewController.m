//
//  CourseSelectViewController.m
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/4/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import "CourseSelectViewController.h"

@interface CourseSelectViewController ()
@end

@implementation CourseSelectViewController

@synthesize strStudentID, coursesToSelect, intEnrollmentID, strClassNo, databasePath, DB;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        //Query to compare _studentID.text and _password.text
        NSString *querySQL = [NSString stringWithFormat:@"SELECT COURSES.CourseNo, COURSES.Description, ENROLLMENT.EnrollmentID, ENROLLMENT.ClassNo FROM COURSES INNER JOIN CLASSES ON COURSES.CourseNo = CLASSES.CourseNo INNER JOIN ENROLLMENT ON ENROLLMENT.ClassNo = CLASSES.ClassNo INNER JOIN STUDENT ON STUDENT.StudentID = ENROLLMENT.StudentID WHERE STUDENT.StudentID = '%@' AND ENROLLMENT.SurveyCompleted = '%d'", strStudentID, 0];
        
        const char *query_statement = [querySQL UTF8String];
        
        if(sqlite3_prepare_v2(DB, query_statement, -1, &statement, NULL) == SQLITE_OK)
        {
           //Query results exist
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                //Adds query results to the PickerView
                [coursesToSelect addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)]];
                
                strClassNo = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                NSString * test = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                intEnrollmentID = [test intValue];
                
                printf("Data passed value for username: %s\n", [strStudentID UTF8String]);
                printf("Data passed value for enrollment ID: %d\n", intEnrollmentID);
                printf("Data passed value for ClassNo: %s\n", [strClassNo UTF8String]);            }
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED
{
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