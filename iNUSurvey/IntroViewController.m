//
//  IntroViewController.m
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/4/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import "IntroViewController.h"
#import "CourseSelectViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

@synthesize strStudentID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // printf("\n\n\n%s\n", [name UTF8String]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Will pass the value for the StudentID that was entered in the Login module
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CourseSelectViewController *csvc;
    csvc = [segue destinationViewController];
    csvc.strStudentID = strStudentID;
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
