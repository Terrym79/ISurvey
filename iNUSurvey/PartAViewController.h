//
//  PartAViewController.h
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/13/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartAViewController : UIViewController

//data values that are passed to this view controller
@property (weak, nonatomic) NSString *strStudentID;
@property (weak, nonatomic) NSString *strDescription;
@property (weak, nonatomic) NSString *strCourseNo;
@property (weak, nonatomic) NSString *strClassNo;
@property (nonatomic) int intEnrollmentID;

@end
