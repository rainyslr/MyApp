//
//  loginViewController.m
//  YoushuGou
//
//  Created by 苏丽荣 on 16/6/17.
//  Copyright © 2016年 苏丽荣. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.table.dataSource = self;
    self.table.delegate = self;
    
    
    //单击空白处隐藏键
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.username resignFirstResponder];
    [self.passwd resignFirstResponder];
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.username = [[UITextField alloc]initWithFrame:CGRectMake(120, 0, 140, 30)];
    [self.username setBorderStyle:UITextBorderStyleNone];
    [self.username setTextColor:[UIColor brownColor]];
    [self.username setFont:[UIFont fontWithName:@"Arial" size:14]];
    [self.username setPlaceholder:@"请输入用户名"];
    //cell.selectionStyle = UITableViewStyleGrouped;
    self.username.keyboardType =  UIKeyboardTypeURL;
    
    self.passwd = [[UITextField alloc]initWithFrame:CGRectMake(120, 0, 140, 30)];
    [self.passwd setBorderStyle:UITextBorderStyleNone];
    [self.passwd setPlaceholder:@"请输入密码"];
    [self.passwd setTextColor:[UIColor brownColor]];
    [self.passwd setFont:[UIFont fontWithName:@"Arial" size:14]];
    [self.passwd setSecureTextEntry:YES];
    [self.passwd setReturnKeyType:UIReturnKeyDone];
    //cell.selectionStyle = UITableViewStyleGrouped;
    self.passwd.keyboardType = UIKeyboardTypeNumberPad;

    static NSString *identifier = @"_QiShiCELL";
    UITableViewCell *cell =(UITableViewCell *) [tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            
            [cell.textLabel setTextColor:[UIColor blackColor]];
            [cell.textLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
            [cell.textLabel setText: @"用户名:"];
            [cell addSubview:self.username];
        }else if(indexPath.row == 1)
        {
            
            [cell.textLabel setTextColor:[UIColor blackColor]];
            [cell.textLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
            [cell.textLabel setText:  @"密   码:"];
            [cell addSubview:self.passwd];
        }
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableview heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section{
    return 2;
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

- (IBAction)login:(id)sender {
    
}
@end
