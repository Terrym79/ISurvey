//
//  ViewController.m
//  iNUSurvey
//
//  Created by Terry Minton on 12/29/15.
//  Copyright © 2015 iSuperb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//Path to SQLite Database
NSString *docsDir = @"/Users/user114547/Documents/";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Appends the DB filename to the DB path
    _databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"iNUSurvey.sql"]];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //Database not found - Diagnostics
    if([filemgr fileExistsAtPath:_databasePath] == NO)
    {
        printf("Error: Database not ready!\n");  //Console output
    }
    
    //Database is found - Diagnostics
    else
    {
        printf("Database exists and is ready");  //Console output
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender
{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    //Database open is successful
    if(sqlite3_open(dbpath, &_DB) == SQLITE_OK)
    {
        //Query to compare _studentID.text and _password.text
        NSString *querySQL = [NSString stringWithFormat:@"SELECT STUDENT.StudentID, STUDENT_AUTH.PasswordHash FROM STUDENT INNER JOIN STUDENT_AUTH WHERE STUDENT.StudentID = STUDENT_AUTH.StudentID AND STUDENT.StudentID = '%@' AND STUDENT_AUTH.PasswordHash = '%@'", _studentID.text, _password.text];
        
        const char *query_statement = [querySQL UTF8String];
        
        if(sqlite3_prepare_v2(_DB, query_statement, -1, &statement, NULL) == SQLITE_OK)
        {
            //StudentID and password are a match-SUCCESS
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                //diagnostic info
                NSString *name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *pass = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];                NSLog(@"Login Successful");
                
                //diagnostic output to console
                printf("%s\n", [name UTF8String]);
                printf("%s\n", [pass UTF8String]);
            }
            
            //StudentID and password are not a match-FAILURE
            else
            {
                UIAlertController *loginFailed = [UIAlertController alertControllerWithTitle: @"Login Failed" message: @"Incorrect StudentID or Password has been entered.\n\n  Please try again" preferredStyle: UIAlertControllerStyleAlert];
                
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle: @"Dismiss" style: UIAlertActionStyleDestructive handler: nil            ];
                
                [loginFailed addAction: alertAction];
                                              
                [self presentViewController:loginFailed animated:YES completion:nil];
                
                //Blank the password textbox
                _password.text = @"";
                
                sqlite3_finalize(statement);
                sqlite3_close(_DB);
            }
        }
    }
    
}
@end
