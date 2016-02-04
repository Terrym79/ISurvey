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
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CONFIRMATION" message:@"Are you ready to submit your responses?" preferredStyle:UIAlertControllerStyleAlert];
    

    UIAlertAction *backtAction = [UIAlertAction actionWithTitle:@"Back" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        
        NSString *commentsText = Comments.text;
    
        //Do some thing here
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
