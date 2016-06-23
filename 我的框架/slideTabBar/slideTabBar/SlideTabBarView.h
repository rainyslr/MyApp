//
//  SlideTabBarView.h
//  slideTabBar
//
//  Created by 苏丽荣 on 16/6/22.
//  Copyright © 2016年 苏丽荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideTabBarViewDelegate <NSObject>
- (UITableView*) tableForPage:(NSInteger)page;
@end

@protocol SlideTabBarViewDataSource<NSObject>
- (UITableView*) tableAtPage:(NSInteger)page;
-(NSInteger)numberOfSectionsInTableAtPage:(NSInteger)page;
-(NSInteger) tableAtPage:(NSInteger)page numberOfRowsInSection:(NSInteger)section;
-(CGFloat) tableAtPage:(NSInteger)page heightForRowAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *)tableAtPage:(NSInteger)page cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface SlideTabBarView : UIView
@property (assign) NSInteger tabCount;
@property (nonatomic,assign) NSInteger topBarHeight;
@property (nonatomic,assign) NSInteger indicatorSlideHeight;
@property (nonatomic, strong) id<SlideTabBarViewDelegate,SlideTabBarViewDataSource> delegate;
-(instancetype)initWithFrame:(CGRect)frame withTopBarHeight:(NSInteger)height titles: (NSArray*) titleArray;
//-(instancetype)initWithFrame:(CGRect)frame withTopBarHeight:(NSInteger)height count: (NSInteger) count;


@end
