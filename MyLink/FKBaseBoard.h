//
//  FKBaseBoard.h
//  Link
//
//  Created by yeeku on 13-7-16.
//  Copyright (c) 2013年 crazyit.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKBaseBoard : NSObject
@property (nonatomic,strong) NSString* scene;
@property (nonatomic,assign) NSInteger piece_width;
@property (nonatomic,assign) NSInteger piece_height;
@property (nonatomic,assign) NSInteger Begin_X;
@property (nonatomic,assign) NSInteger Begin_Y;


- (NSArray*) createPieces:(NSArray*)pieces;
- (NSArray*) create;
//- (NSInteger) get
@end
