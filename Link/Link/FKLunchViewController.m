//
//  FKLunchViewController.m
//  Link
//
//  Created by 苏丽荣 on 16/5/4.
//  Copyright © 2016年 crazyit.org. All rights reserved.
//

#import "FKLunchViewController.h"
#import "WelcomeController.h"


@implementation FKLunchViewController


- (void)viewDidLoad {
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"small_bg.png"]];
    WelcomeController *welcomeViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"IDWelcomeViewController"];
    [self setViewControllers:@[welcomeViewController]];
}

@end
