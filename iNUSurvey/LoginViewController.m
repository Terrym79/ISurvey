//
//  LoginViewController.m
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/4/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import "LoginViewController.h"
#import "IntroViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize studentID, password;

//Path to SQLite Database
//NSString *docsDir = @"/Users/user114547/Documents/";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    //Get the directory
    //dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    //Appends the DB filename to the DB path
    _databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"iNUSurvey.sql"]];
    
    //Diagnostics displays path to SQLite database file
    NSLog (@"Database path: %@\n", _databasePath);
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //Database not found - Diagnostics
    if([filemgr fileExistsAtPath:_databasePath] == NO)
    {
        printf("Error: Database not ready!\n");  //Console output
    }
    
    //Database is found - Diagnostics
    else
    {
        printf("Database exists and is ready\n");  //Console output
    }
}
  //Releases the keyboard
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
        NSString *querySQL = [NSString stringWithFormat:@"SELECT STUDENT.StudentID, STUDENT_AUTH.PasswordHash FROM STUDENT INNER JOIN STUDENT_AUTH WHERE STUDENT.StudentID = STUDENT_AUTH.StudentID AND STUDENT.StudentID = '%@' AND STUDENT_AUTH.PasswordHash = '%@'", studentID.text, password.text];
        
        const char *query_statement = [querySQL UTF8String];
        
        if(sqlite3_prepare_v2(_DB, query_statement, -1, &statement, NULL) == SQLITE_OK)
        {
            //StudentID and password are a match-SUCCESS
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                //diagnostic info
                NSString *name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *pass = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSLog(@"Login Successful\n");
                
                //diagnostic output to console
                printf("Entered username: %s\n", [name UTF8String]);
                printf("Entered password: %s\n", [pass UTF8String]);
            }
            
            //StudentID and password are not a match-FAILURE
            else
            {
                UIAlertController *loginFailed = [UIAlertController alertControllerWithTitle: @"Login Failed" message: @"Incorrect StudentID or Password has been entered.\n\n  Please try again" preferredStyle: UIAlertControllerStyleAlert];
                
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle: @"Dismiss" style: UIAlertActionStyleDestructive handler: nil            ];
                
                [loginFailed addAction: alertAction];
                
                [self presentViewController:loginFailed animated:YES completion:nil];
                
                //Blank the password textbox
                password.text = @"";
                
                sqlite3_finalize(statement);
                sqlite3_close(_DB);
            }
        }
    }
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    IntroViewController *ivc;
    ivc = [segue destinationViewController];
    ivc.strStudentID = studentID.text;
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
