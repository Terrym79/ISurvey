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
