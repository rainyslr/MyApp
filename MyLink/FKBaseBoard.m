//
//  FKBaseBoard.m
//  Link
//
//  Created by yeeku on 13-7-16.
//  Copyright (c) 2013年 crazyit.org. All rights reserved.
//


#import "FKBaseBoard.h"
#import "FKFullBoard.h"
#import "FKHorizontalBoard.h"
#import "FKVerticalBoard.h"
#import <objc/runtime.h>
#import "FKPiece.h"
#import "Constants.h"
#import "FKImageUtil.h"
#import "FKPieceImage.h"

@implementation FKBaseBoard
// 定义一个方法, 让子类去实现
- (NSArray*) createPieces:(NSArray*)pieces
{
    return nil;
}
- (NSArray*) create
{
    // 创建FKPiece的二维数组
    NSMutableArray* pieces = [[NSMutableArray alloc] init];
    for(int i = 0 ; i < xSize ; i++)
    {
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        for (int j = 0 ; j < ySize ; j++)
        {
            [arr addObject:[NSObject new]];
        }
        [pieces addObject:arr];
    }
    // 返回非空的FKPiece集合, 该集合由子类实现的方法负责创建
    NSArray* notNullPieces = [self createPieces:pieces]; //①
    // 根据非空FKPiece对象的集合的大小来取图片
    NSArray* playImages = getPlayImages(notNullPieces.count,self.scene);
    // CIImage cimagege
    UIImage* tempimage = [[playImages objectAtIndex:0] image];
    
    
    
    
    // 所有图片的宽、高都是相同的，随便取出一个方块的宽、高即可。
    // UIImage* tempimage=[UIImage imageWithCIImage:[[playImages objectAtIndex:0] image]];
    int imageWidth = tempimage.size.width;
    //int imageHeight = [[playImages objectAtIndex:0] image].size.height;
    int imageHeight = tempimage.size.height;
    self.piece_width = imageWidth;
    self.piece_height = imageHeight;
    // 遍历非空的FKPiece集合
    CGRect rx = [ UIScreen mainScreen ].bounds;
    int width = rx.size.width;
     int height = rx.size.height;
    int begin_x,begin_y;
    
    if ([self isKindOfClass:[FKFullBoard class]]) {
        begin_x = (width - xSize * self.piece_width)/2;
        begin_y = beginImageY;
    }
    else if ([self isKindOfClass:[FKHorizontalBoard class]]) {
        begin_x = (width - xSize * self.piece_width)/2;
        begin_y = beginImageY + self.piece_height / 2;
    }
    else if([self isKindOfClass:[FKVerticalBoard class]])
    {
        begin_x = (width - xSize * self.piece_width)/2 + self.piece_height / 2;
        begin_y = beginImageY + self.piece_height / 2;
    }
//    begin_x = beginImageX;
//    begin_y = beginImageY;
    for (int i = 0; i < notNullPieces.count; i++)
    {
        // 依次获取每个FKPiece对象
        FKPiece* piece = [notNullPieces objectAtIndex:i];
        piece.image = [playImages objectAtIndex:i];
        // 计算每个方块左上角的X、Y坐标
        piece.beginX = piece.indexX * imageWidth
        + begin_x;
        piece.beginY = piece.indexY * imageHeight
        + begin_y;
        // 将该方块对象放入方块数组的相应位置处
        [[pieces objectAtIndex:piece.indexX]
         setObject:piece atIndex:piece.indexY];
    }
    self.Begin_X = begin_x;
    self.Begin_Y = begin_y;
    return pieces;
}
@end
