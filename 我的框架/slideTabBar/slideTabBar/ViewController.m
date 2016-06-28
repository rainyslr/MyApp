//
//  ViewController.m
//  slideTabBar
//
//  Created by 苏丽荣 on 16/6/22.
//  Copyright © 2016年 苏丽荣. All rights reserved.
//

#import "ViewController.h"
#import "SlideTabBarView.h"

@interface ViewController ()<SlideTabBarViewDelegate,SlideTabBarViewDataSource>
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
    _slideTabBarView = [[SlideTabBarView alloc] initWithFrame:screenBound withDelegate:self];
    
    [_slideTabBarView setColor:[UIColor purpleColor] AtIndex:2];
    [self.view addSubview:self.slideTabBarView];
    
}

- (CGFloat) heightForTopBar
{
    return 30;
}
- (NSArray*) titlesForTapButton
{
    return [NSArray arrayWithObjects:@"全部", @"京东", @"当当", nil];
}

- (UITableView*) tableForPage:(NSInteger)page withFrame:(CGRect)frame {

    UITableView *tableView = [[UITableView alloc] initWithFrame:frame];
    return tableView;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView atPage:(NSInteger)page{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section atPage:(NSInteger)page{
    return 2;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath atPage:(NSInteger)page
{
    return 30;
}

-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath atPage:(NSInteger)page
{
    static NSString* cellId = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",page];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"row:%ld",indexPath.row];
        
    }
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
