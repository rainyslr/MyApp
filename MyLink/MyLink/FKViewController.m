//
//  FKViewController.m
//  Link
//
//  Created by yeeku on 13-7-16.
//  Copyright (c) 2013年 crazyit.org. All rights reserved.
//

#import "FKViewController.h"
#import "FKGameView.h"
#import "Constants.h"
#import "FKPiece.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
@interface FKViewController ()

@end

@implementation FKViewController
AVAudioPlayer *audioPlayer;
// 游戏界面类
FKGameView* gameView;
// 游戏剩余时间
NSInteger leftTime;
// 定时器
NSTimer* timer;
BOOL isPlaying;
UIAlertView* lostAlert;
UIAlertView* successAlert;
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"room.jpg"];
    self.view.layer.contents = (id) image.CGImage;
    
	[UIApplication sharedApplication].statusBarHidden = YES;
	self.timeLabel.textColor = [UIColor colorWithRed:1 green:1
		blue: 9/15 alpha:1];
   
	[self.startBn addTarget:self action:@selector(startGame)
		forControlEvents:UIControlEventTouchUpInside];
    // 创建FKGameView控件
    gameView = [[FKGameView alloc] initWithFrame:CGRectMake(0, 20, 500, 600)];
	// 创建FKGameService对象
    gameView.gameService = [[FKGameService alloc] initWithMode:self.chosenMode Scene:self.chosenScene];

	gameView.delegate = self;
	gameView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:gameView];
	// 初始化游戏失败的对话框
	lostAlert = [[UIAlertView alloc] initWithTitle:@"失败！"
		message:@"游戏失败！重新开始？"delegate:self
		cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
	// 初始化游戏胜利的对话框
	successAlert = [[UIAlertView alloc] initWithTitle:@"胜利！"
		message:@"游戏胜利！重新开始？"delegate:self
		cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    gameView.hidden = YES;
  
    if (self.silent) {
        //当前为静音模式，因此调声按钮图标为有声喇叭（意为点击后离开静音模式）
        self.VoiceCtnlBtn.imageView.image = [UIImage imageNamed:@"有声喇叭.png"];
    }
    else
    {
        //当前为有声模式，因此调声按钮图标为静音喇叭（意为点击后进入静音模式）
        self.VoiceCtnlBtn.imageView.image = [UIImage imageNamed:@"静音喇叭.png"];
    }
   
}
- (void) startGame
{
    gameView.hidden = NO;
    self.returnBtn.enabled = NO;
    self.startBn.enabled = NO;
	// 如果之前的timer还未取消，取消timer
	if (timer != nil)
	{
		[timer invalidate];
	}
	// 重新设置游戏时间
	leftTime = DEFAULT_TIME;
	// 开始新的游戏游戏
	[gameView startGame];
	isPlaying = YES;
	timer = [NSTimer scheduledTimerWithTimeInterval:1
		target:self selector:@selector(refreshView) userInfo:nil repeats:YES];
	// 将选中方块设为nil。
	gameView.selectedPiece = nil;
}
- (void) refreshView
{
	self.timeLabel.text = [NSString stringWithFormat:@"剩余时间：%d" , leftTime];
	leftTime--;
	// 时间小于0, 游戏失败
	if (leftTime < 0)
	{
		[timer invalidate];
		// 更改游戏的状态
		isPlaying = NO;
        if (!self.silent) {
            NSURL* winSoundUrl = [[NSBundle mainBundle]
                                  URLForResource:@"失败" withExtension:@"wav"];
            audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:winSoundUrl error:Nil];
            [audioPlayer prepareToPlay];
            [audioPlayer play];

        }
        [lostAlert show];
        self.returnBtn.enabled = YES;
        self.startBn.enabled = YES;
		return;
	}
}
- (void) alertView:(UIAlertView *)alertView
	clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [audioPlayer stop];
    audioPlayer = nil;
	// 如果用户选中的“确定”按钮
	if(buttonIndex == 1)
	{
		[self startGame];
	}
    // 如果用户选中的“取消”按钮
    else if(buttonIndex == 0)
    {
        self.timeLabel.text = @"";
        gameView.hidden = YES;
    }
}
- (void)checkWin:(FKGameView *)gameView
{
	// 判断是否还有剩下的方块, 如果没有, 游戏胜利
	if (![gameView.gameService hasPieces])
	{
        if (!self.silent) {
            NSURL* winSoundUrl = [[NSBundle mainBundle]
                                  URLForResource:@"游戏胜利" withExtension:@"wav"];
            audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:winSoundUrl error:Nil];
            [audioPlayer prepareToPlay];
            [audioPlayer play];
        }

       		// 游戏胜利
		[successAlert show];
		// 停止定时器
		[timer invalidate];
		// 更改游戏状态
		isPlaying = NO;
        self.returnBtn.enabled = YES;
        self.startBn.enabled = YES;
	}
}

- (IBAction)StartGame:(id)sender {
    [self startGame];
}

- (IBAction)StopGame:(id)sender {
    [timer invalidate];
    // 更改游戏的状态
    isPlaying = NO;
    self.returnBtn.enabled = YES;
    self.startBn.enabled = YES;
    self.timeLabel.text = @"";
    gameView.hidden = YES;
}



- (IBAction)changeVoice:(id)sender {

    self.silent = !self.silent;
    [gameView ControlVioce:self.silent];
    if (self.silent) {
        //当前为静音模式，因此调声按钮图标为有声喇叭（意为点击后离开静音模式）
        self.VoiceCtnlBtn.imageView.image = [UIImage imageNamed:@"有声喇叭.png"];
    }
    else
    {
        //当前为有声模式，因此调声按钮图标为静音喇叭（意为点击后进入静音模式）
        self.VoiceCtnlBtn.imageView.image = [UIImage imageNamed:@"静音喇叭.png"];
    }

}
@end
