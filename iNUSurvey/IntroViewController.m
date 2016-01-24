//
//  IntroViewController.m
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/4/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController
@synthesize introText, databasePath, DB, strStudentID;

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *dirPaths;
    NSString *docsDir;
    
    //Get the directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    //Appends the DB filename to the DB path
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"iNUSurvey.sql"]];
    
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    
    
    
    //Database open is successful
    if(sqlite3_open(dbpath, & DB) == SQLITE_OK)
    {
        //Query to get introText
        NSString *querySQL = [NSString stringWithFormat:@"SELECT INTRODUCTION.IntroText from INTRODUCTION order by introductionID DESC LIMIT 1"];
        
        
        if(sqlite3_prepare_v2(DB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *intText = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                introText.text = intText;
            }
        }
        
        
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


//Passing values to next View controller (Part A)
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    IntroViewController *introVc;
    introVc  = [segue destinationViewController];
    introVc.strStudentID = strStudentID;

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
