//
//  PartCViewController.m
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/16/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import "PartCViewController.h"

@interface PartCViewController ()

@end

@implementation PartCViewController

// part of placeholder
//@synthesize textView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // self.textView.placeholder = @"place"; (place holder)
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Releases the keyboard
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
/* Trying to do a placeholder
- (void)dealloc{
    
    [self.textView release];
    //[super dealloc];

}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
}
*/
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
    
    UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    [alert addAction:backtAction];
    [alert addAction:submitAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
