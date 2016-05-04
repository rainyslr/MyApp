//
//  FKGameView.h
//  Link
//
//  Created by yeeku on 13-7-16.
//  Copyright (c) 2013年 crazyit.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FKGameService.h"
#import "FKLinkInfo.h"
#import "FKPiece.h"
#import <AudioToolbox/AudioToolbox.h>

@class FKGameView;
@protocol FKGameViewDelegate <NSObject>
- (void) checkWin: (FKGameView*)gameView;
@end
@interface FKGameView : UIView
// 游戏逻辑的实现类
@property (nonatomic, strong) FKGameService* gameService;  //①
// 连接信息对象
@property (nonatomic, strong) FKLinkInfo* linkInfo;
// 保存当前已经被选中的方块
@property (nonatomic, strong) FKPiece* selectedPiece;
@property (nonatomic, strong) id<FKGameViewDelegate> delegate;
@property (nonatomic,assign) SystemSoundID gu;
@property (nonatomic,assign) SystemSoundID dis;
@property (nonatomic,assign) BOOL silent;
// 开始游戏方法
- (void) startGame;
- (void) ControlVioce:(BOOL)enabled;
@end

