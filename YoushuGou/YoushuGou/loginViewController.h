//
//  loginViewController.h
//  YoushuGou
//
//  Created by 苏丽荣 on 16/6/17.
//  Copyright © 2016年 苏丽荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : UIViewController
@property (nonatomic,retain) UITextField *username;
@property (nonatomic,retain) UITextField *passwd;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)login:(id)sender;


@end
