//
//  PartAViewController.m
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/13/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import "PartAViewController.h"

@interface PartAViewController ()

@property NSArray *responses;

@end

@implementation PartAViewController

@synthesize strClassNo, strCourseNo, strDescription, strStudentID, intEnrollmentID;

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.responses count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.responses[row];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.responses = @[@"Strongly Agree", @"Agree", @"Neutral", @"Disagree", @"Strongly Disagree"];
    
    //Diagnostic console output to show the variable data that is being passed to this view controller
    printf("%s\n", [strStudentID UTF8String]);
    printf("%s\n", [strDescription UTF8String]);
    printf("%s\n", [strCourseNo UTF8String]);
    printf("%s\n", [strClassNo UTF8String]);
    printf("%d\n", intEnrollmentID);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
