//
//  CourseSelectViewController.m
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/4/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import "CourseSelectViewController.h"

@interface CourseSelectViewController ()

@property NSArray *courses;

@end

@implementation CourseSelectViewController

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.courses count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.courses[row];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.courses = @[@"CSC480A", @"CSC 340", @"CSC341", @"CSC350"];
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
