//
//  ViewController.m
//  MyLink
//
//  Created by 苏丽荣 on 16/5/4.
//  Copyright © 2016年 苏丽荣. All rights reserved.
//

#import "ViewController.h"
#import "FKViewController.h"
@interface ViewController ()

@end

@implementation ViewController
NSArray* modes;
NSArray* scenes;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"welcome.png"]];
    modes = [[NSArray alloc] initWithObjects:@"完满模式", @"竖条纹", @"横条纹", nil];
    scenes = [[NSArray alloc] initWithObjects:@"动物世界", @"qq风格", nil];
    self.chosenMode = [modes objectAtIndex:0];
    self.chosenScene = [scenes objectAtIndex:0];
}

- (IBAction)chooseMode:(id)sender {
    UIActionSheet* sheet = [[UIActionSheet alloc]
                            initWithTitle:@"请选择模式" // 指定标题
                            delegate:self // 指定该UIActionSheet的委托对象就是该控制器自身
                            cancelButtonTitle:@"取消" // 指定取消按钮的标题
                            destructiveButtonTitle:@"确定" // 指定销毁按钮的标题
                            otherButtonTitles:@"完满模式", @"竖条纹", @"横条纹",nil]; // 为其他按钮指定标题
    // 设置UIActionSheet的风格
    sheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [sheet showInView:self.view];
    
}

- (IBAction)chooseScene:(id)sender {
    UIActionSheet* sheet = [[UIActionSheet alloc]
                            initWithTitle:@"请选择场景" // 指定标题
                            delegate:self // 指定该UIActionSheet的委托对象就是该控制器自身
                            cancelButtonTitle:@"取消" // 指定取消按钮的标题
                            destructiveButtonTitle:@"确定" // 指定销毁按钮的标题
                            otherButtonTitles:@"动物世界", @"qq风格",nil]; // 为其他按钮指定标题
    // 设置UIActionSheet的风格
    sheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [sheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([actionSheet.title isEqualToString:@"请选择模式"]) {
        if (buttonIndex > 0 && buttonIndex <=[modes count]) {
            self.chosenMode = [modes objectAtIndex:buttonIndex - 1];
        }
    }
    if (buttonIndex > 0 && buttonIndex <=[scenes count]) {
        self.chosenScene = [scenes objectAtIndex:buttonIndex - 1];
    }
    NSLog(@"%@",actionSheet.title);
    //    NSLog(@"%@",[NSString stringWithFormat:@"您单击了第%ld个按钮" , buttonIndex]);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    FKViewController* fkVc = segue.destinationViewController;
    fkVc.chosenMode = self.chosenMode;
    fkVc.chosenScene = self.chosenScene;
    fkVc.silent = NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
