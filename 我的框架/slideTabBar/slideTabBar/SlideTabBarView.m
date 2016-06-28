//
//  SlideTabBarView.m
//  slideTabBar
//
//  Created by 苏丽荣 on 16/6/22.
//  Copyright © 2016年 苏丽荣. All rights reserved.
//

#import "SlideTabBarView.h"
@interface SlideTabBarView()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

///@brife 上方的Bar，包含内容（若干个TabButton，以及指示滑动的slideIndicator）
@property (strong, nonatomic) UIScrollView *BarView;
///@brife 指示滑动的View
@property (strong, nonatomic) UIView *slideIndicator;
///@brife 上方的按钮数组
@property (strong, nonatomic) NSMutableArray *tapButtons;

///@brife 内容部分的ScrollView，subview为各个TabButton对应的view。
@property (strong, nonatomic) UIScrollView *contentView;
///@brife 每一个TabButton对应的View组成的数组
@property (strong, nonatomic) NSMutableArray *contentPageView;
@property (assign,nonatomic) NSInteger BtnAmoutPerPage;
@property (copy,nonatomic) NSArray* TabBtnTitles;

///@brife 当前选中页数
@property (assign) NSInteger currentPage;


@end




@implementation SlideTabBarView
#pragma mark --接口函数
- (void)setColor:(UIColor*)color AtIndex:(NSInteger)index {
    [self.tapButtons[index] setBackgroundColor:color];
}

#pragma mark --初始化函数
-(instancetype)initWithFrame:(CGRect)frame withDelegate:(id)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        self.tapButtons = [[NSMutableArray alloc] init];
        self.contentPageView = [[NSMutableArray alloc] init];
        if (self.indicatorSlideHeight == 0) {
            self.indicatorSlideHeight = 5;
        }
        self.TabBtnTitles = [self.delegate titlesForTapButton];
        if (self.TabBtnTitles.count == 0) {
            self.TabBtnTitles = [NSArray arrayWithObjects:@"按钮0", @"按钮1",@"按钮2",nil];
            self.tabCount = 3;
        }
        else{
            self.tabCount = self.TabBtnTitles.count;
        }
        self.topBarHeight = [self.delegate heightForTopBar];
        [self initTopTabs];
        [self initContentView];
        [self initContentPageView];
        [self initSlideView];
    }
    [self addObserver];
    return self;
    
}
//
//-(instancetype)initWithFrame:(CGRect)frame withTopBarHeight:(NSInteger)height titles: (NSArray*) titleArray
//{
//    int count = titleArray.count;
////    NSAssert(count != 0, ([NSString stringWithFormat:@"titleArray is empty.file: %s ---> function:= %s at line: %d", __FILE__, __FUNCTION__, __LINE__]));
//    
//    self = [super initWithFrame:frame];
//    if (self) {
//        if (self.indicatorSlideHeight == 0) {
//            self.indicatorSlideHeight = 5;
//        }
//        if (count == 0) {
//            self.TabBtnTitles = [NSArray arrayWithObjects:@"按钮0", @"按钮1",@"按钮2",nil];
//            self.tabCount = 3;
//        }
//        else{
//            self.TabBtnTitles = titleArray;
//            self.tabCount = count;
//        }
//        self.topBarHeight = height;
//        [self initTopTabs];
//        [self initContentView];
//        [self initContentPageView];
//        [self initSlideView];
//    }
//    return self;
//    
//}
//-(instancetype)initWithFrame:(CGRect)frame withTopBarHeight:(NSInteger)height count: (NSInteger) count{
//    NSLog(@"initWithFrame,%@",NSStringFromCGRect(frame));
//    self = [super initWithFrame:frame];
//    if (self) {
//        if (self.indicatorSlideHeight == 0) {
//            self.indicatorSlideHeight = 5;
//        }
//        self.tabCount = count;
//        self.topBarHeight = height;
//        [self initContentView];
//        [self initTopTabs];
//        [self initContentView];
//        [self initContentPageView];
//        [self initSlideView];
//    }
//    return self;
//}

- (void)initContentView
{
    CGRect frame = self.frame;
    self.contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,self.topBarHeight, frame.size.width, frame.size.height - self.topBarHeight)];
    NSLog(@"initContentView,%@",NSStringFromCGRect( self.contentView.frame));
    self.contentView.contentSize = CGSizeMake(frame.size.width * self.tabCount, frame.size.height - self.topBarHeight);
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.pagingEnabled = YES;
    self.contentView.delegate = self;
    [self addSubview:self.contentView];
    
}

-(void) initTopTabs{
    CGRect frame = self.frame;
    CGFloat width;
    if(self.tabCount <6){
        //当tab的数量小于6时，每个tabBtn宽度均分frame的宽度
        width = frame.size.width / self.tabCount;
        self.BtnAmoutPerPage = self.tabCount;
    }
    else {
        width = frame.size.width / 6;
        self.BtnAmoutPerPage = 6;
    }
    self.BarView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, self.topBarHeight)];
    self.BarView.showsHorizontalScrollIndicator = NO;
    self.BarView.showsVerticalScrollIndicator = YES;
    self.BarView.bounces = NO;
    self.BarView.delegate = self;
    
    if (_tabCount >= 6) {
        self.BarView.contentSize = CGSizeMake(width *self.tabCount, self.topBarHeight);
        
    } else {
        self.BarView.contentSize = CGSizeMake(frame.size.width,self.topBarHeight);
    }
    [self addSubview:self.BarView];
    
    for (int i = 0; i < self.tabCount; i ++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 0, width, self.topBarHeight)];
        button.tag = i;
//        [button setTitle:[NSString stringWithFormat:@"按钮%d", i+1] forState:UIControlStateNormal];
        [button setTitle:[self.TabBtnTitles objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tabButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.BarView addSubview:button];
        if (i%2 == 0) {
            [button setBackgroundColor:[UIColor greenColor]];
        }
        else
            [button setBackgroundColor:[UIColor blueColor]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.tapButtons addObject:button];
        [self.BarView addSubview:button];
    }
}


- (void)initContentPageView{
    NSInteger width = self.frame.size.width;
     for (int i = 0; i < self.tabCount; i ++) {
         CGRect tableFrame = CGRectMake(i*width,0, width, self.frame.size.height - self.topBarHeight);

         NSLog(@"initContentPageView,befor:tableFrame:%@",NSStringFromCGRect(tableFrame));
         UITableView *table = [self.delegate tableForPage:i withFrame:(tableFrame)];


         
//         UITableView *table = [self.delegate tableForPage:i withFrame:(tableFrame)];
         table.dataSource = self;
         table.delegate = self;
         [self.contentView addSubview:table];
         if (table.superview == self.contentView) {
             NSLog(@"YES");
         }
        NSLog(@"initContentPageView,after:tableFrame:%@,parentFrame:%@",NSStringFromCGRect(tableFrame),NSStringFromCGRect(table.superview.frame));
         [self.contentPageView addObject:table];
     }
}

- (void)initSlideView{
    CGFloat width;
    if (self.tabCount > 6) {
        width = self.frame.size.width / 6;
    }
    else
        width = self.frame.size.width / self.tabCount;
    self.slideIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, self.topBarHeight - self.indicatorSlideHeight, width, self.indicatorSlideHeight)];
    [self.slideIndicator setBackgroundColor:[UIColor redColor]];
    [self.BarView addSubview:self.slideIndicator];
}

#pragma mark --点击顶部的按钮所触发的方法
-(void) tabButton: (id) sender{
    UIButton *button = sender;
    NSLog(@"shoud offerset:%f",button.tag * self.frame.size.width);
    [self.contentView setContentOffset:CGPointMake(button.tag * self.frame.size.width, 0) animated:NO];
}

#pragma mark -- scrollView的相关的数据更新方法

-(void) updateTableAtPage: (NSUInteger) pageNumber{
    UITableView *reuseTableView = self.contentPageView[pageNumber];
    [reuseTableView reloadData];
}

- (void)updataBarView:(NSInteger)contentViewPage
{
    CGFloat width = self.slideIndicator.frame.size.width;
    NSInteger firstBtnIndex = self.BarView.contentOffset.x / width;
    NSInteger xOfferset;
    if (contentViewPage >= firstBtnIndex + self.BtnAmoutPerPage) {
        xOfferset = contentViewPage * width;
        [self.BarView setContentOffset:CGPointMake(xOfferset, 0) animated:NO];
    }
    else if (contentViewPage <= firstBtnIndex){
        if (self.BarView.contentOffset.x >= self.BtnAmoutPerPage*width) {
            NSInteger xOfferset = self.BarView.contentOffset.x - self.BtnAmoutPerPage*width;
            [self.BarView setContentOffset:CGPointMake(xOfferset, 0) animated:NO];
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    if ([scrollView isEqual:self.contentView]) {
        _currentPage = self.contentView.contentOffset.x/self.frame.size.width;
        NSLog(@"current page:%ld,offset:%f",_currentPage,self.contentView.contentOffset.x);
        
        [self updataBarView:_currentPage];
        [self updateTableAtPage:self.currentPage];
        return;
    }
}

#pragma mark -- scrollView的代理方法



///拖拽后调用的方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //[self modifyTopScrollViewPositiong:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.contentView isEqual:scrollView]) {
        CGRect frame = self.slideIndicator.frame;
        CGFloat width = frame.size.width;
        frame.origin.x = self.contentView.contentOffset.x/self.frame.size.width * width;
        [self.slideIndicator setFrame:frame];
    }
    
}
#pragma mark -- talbeView内部方法
-(NSInteger)indexOfObject:(id)obj in:(NSArray*)array
{
    for (int i = 0; i < array.count; ++ i) {
        if (array[i] == obj) {
            return i;
        }
    }
    return -1;
}

#pragma mark -- talbeView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.delegate numberOfSectionsInTableView:tableView atPage:self.currentPage];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.delegate tableView:tableView numberOfRowsInSection:section atPage:self.currentPage];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath atPage:self.currentPage];
}

-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = [self.contentPageView indexOfObject:tableView];
//     NSInteger index = [self indexOfObject:tableView in:self.contentPageView];
    return [self.delegate tableView:tableView cellForRowAtIndexPath:indexPath atPage:index];
}


#pragma mark -- 内部函数
- (void)addObserver
{
    //    self.BarView.contentOffset
    [self.BarView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    id old = [change objectForKey:@"old"];
    id new = [change objectForKey:@"new"];
    //    if (new isKindOfClass:[CGPoint class]) {
    //        <#statements#>
    //    }
    NSLog(@"旧值：％@，新值％@",old,new);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
