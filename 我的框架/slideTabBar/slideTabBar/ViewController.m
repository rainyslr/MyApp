//
//  ViewController.m
//  slideTabBar
//
//  Created by 苏丽荣 on 16/6/22.
//  Copyright © 2016年 苏丽荣. All rights reserved.
//

#import "ViewController.h"
#import "SlideTabBarView.h"

@interface ViewController ()
@property (strong, nonatomic) SlideTabBarView *slideTabBarView;
@property (assign) NSInteger tabCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tabCount = 8;
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    screenBound.origin.y = 60;
//    _slideTabBarView = [[SlideTabBarView alloc] initWithFrame:screenBound withTopBarHeight:30  titles:nil];
    NSArray *myTitle = [NSArray arrayWithObjects:@"全部", @"京东", @"当当", nil];
    _slideTabBarView = [[SlideTabBarView alloc] initWithFrame:screenBound withTopBarHeight:30  titles:myTitle];
    [self.view addSubview:self.slideTabBarView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
