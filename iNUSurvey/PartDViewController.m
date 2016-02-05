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

@synthesize strClassNo, strCourseNo, strDescription, studentID, intEnrollmentID;
@synthesize DB, databasePath, LogoutButton, BackToCourseButton;

// part of placeholder
//@synthesize textView;

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)BackToCOurseButtonAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *viewController = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CourseSelectViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
    
}

- (IBAction)LogoutButtonAction:(id)sender {
    sqlite3_close(DB);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *viewController = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
    
    
    
}
@end