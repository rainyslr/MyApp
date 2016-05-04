//
//  ViewController.h
//  MyLink
//
//  Created by 苏丽荣 on 16/5/4.
//  Copyright © 2016年 苏丽荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic,strong) NSString* chosenMode;
@property (nonatomic,strong) NSString* chosenScene;
- (IBAction)chooseMode:(id)sender;
- (IBAction)chooseScene:(id)sender;

@end

