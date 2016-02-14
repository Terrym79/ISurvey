//
//  PartDViewController.m
//  iNUSurvey
//
//  Created by Terry Minton on 2/4/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartDViewController.h"
#import "LoginViewController.h"
#import "CourseSelectViewController.h"


@interface PartDViewController ()

@end

@implementation PartDViewController

@synthesize studentID, intEnrollmentID;
@synthesize DB, databasePath, LogoutButton, BackToCourseButton;

// part of placeholder
//@synthesize textView;

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Diagnostic console output to show the variable data that is being passed to this view controller
    printf("PartD %s\n", [studentID UTF8String]);
    printf("PartD %d\n", intEnrollmentID);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)BackToCourseButtonAction:(id)sender {
    
    //Segue transition to CourseSelectViewController
    [self performSegueWithIdentifier:@"PartDToCourseSelectSegue" sender:sender];
}

- (IBAction)LogoutButtonAction:(id)sender {
    //Close database and clear variables
    sqlite3_close(DB);
    studentID = NULL;
    intEnrollmentID = 0;
    
    //Segue transition to LoginViewController
    [self performSegueWithIdentifier:@"PartDToLoginSegue" sender:sender];
}

//Passing values to next View controller (conditional)
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PartDToCourseSelectSegue"]) {
        CourseSelectViewController *csvc;
        csvc  = [segue destinationViewController];
        csvc.studentID = studentID;
    }
    
    if([segue.identifier isEqualToString:@"PartDToLoginSegue"]) {
        LoginViewController *lvc;
        lvc  = [segue destinationViewController];
    }
}

@end