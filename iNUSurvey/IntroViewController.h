//
//  IntroViewController.h
//  iNUSurvey
//
//  Created by Meiza Fleitas on 1/4/16.
//  Copyright © 2016 iSuperb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface IntroViewController : UIViewController
    
    @property(strong, nonatomic) NSString *databasePath;
    @property(nonatomic) sqlite3 *DB;
    @property (weak, nonatomic) IBOutlet UILabel *introText;
    @property (weak, nonatomic) NSString *strStudentID;


@end
