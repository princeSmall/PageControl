//
//  TLScrollView.m
//  PageControl
//
//  Created by 李敏 on 2018/4/9.
//  Copyright © 2018年 李敏. All rights reserved.
//

#import "TLScrollView.h"
#import "TLPageControl.h"

#define Width    self.frame.size.width
#define Height   self.frame.size.height
@interface TLScrollView()
@property (nonatomic,strong)TLPageControl * pageControl;
@property (nonatomic,strong)NSTimer * time;
@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)UIPageControl * pageControl1;
@end
@implementation TLScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       [self addSubview:self.scrollView];
       [self addSubview:self.pageControl];
       [self addSubview:self.pageControl1];
    }
    return self;
}

/**
 循环播放主要看这里

 @param count 要方法图的数量
 */
- (void)setImageCount:(NSUInteger)count{
    
//    1、2、3、4、5 五张图循环播放
    //    1.如何从5变到1:在5后面加一张为1的图
    //    2.如何从1变到5:在1后面加一张为5的图
    //    3.具体看下图if 和 else if， 但是pagecontrol数目保持为五而不变，并设置首次contentoffset为width是以第一张图为起始点，而不是前面加的图5
    count = count + 2;

    for (int i = 0; i < count; i ++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * Width, 0 , Width, Height)];
        if (i == 0) {
            imageView.image = [UIImage imageNamed:@"image5"];
        }else if (i == count - 1){
            imageView.image = [UIImage imageNamed:@"image1"];
        }else{
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%d",i]];
        }
        [self.scrollView addSubview:imageView];
    }
    _count = count;
    self.pageControl.numberOfPages = _count -2 ;
    self.pageControl1.numberOfPages = _count -2;
    self.pageControl.currentPage = 0;
    self.scrollView.contentSize = CGSizeMake(Width * _count, Height);
    [self.scrollView setContentOffset:CGPointMake(Width , 0)];
}

#pragma mark - lazy

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled=YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
- (TLPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[TLPageControl alloc]initWithFrame:CGRectMake(Width / 2.0 - 50, Height - 20, 100, 10)];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.currentPage = 0;
        [_pageControl setValue:[UIImage imageNamed:@"11111"] forKeyPath:@"pageImage"];
        [_pageControl setValue:[UIImage imageNamed:@"22222"] forKeyPath:@"currentPageImage"];
    }
    return _pageControl;
}
- (UIPageControl *)pageControl1{
    if (_pageControl1 == nil) {
        _pageControl1 = [[UIPageControl alloc]initWithFrame:CGRectMake(Width / 2.0 - 50, Height + 20, 100, 10)];
        _pageControl1.backgroundColor = [UIColor clearColor];
        _pageControl1.currentPage = 0;
        [_pageControl1 setValue:[UIImage imageNamed:@"white"] forKeyPath:@"pageImage"];
        [_pageControl1 setValue:[UIImage imageNamed:@"red"] forKeyPath:@"currentPageImage"];
    }
    return _pageControl1;
}


#pragma mark - NSTimer

- (void)startNSTimer{
    self.time = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(CurrentPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.time forMode:NSDefaultRunLoopMode];
}
- (void)endNSTimer{
    [self.time invalidate];
    self.time = nil;
}
- (void)CurrentPage{
    self.pageControl.currentPage = _page;
     self.pageControl.currentPage = _page;
    [self.scrollView setContentOffset:CGPointMake(Width * self.pageControl.currentPage, 0) animated:YES];
    if (_page == 0) {
        isDirection =  YES;
    }else if (_page == 4){
        isDirection = NO;
    }
    if (isDirection == YES) {
        _page ++;
    }else{
        _page --;
    }
}

#pragma mark - UIScrollViewDelegate

/**
 其次在这里判断
 1、如果是最后一张，跳到第一张
 2、如果是第一张，跳到最后一张
 3、改变contentoffset和pagecontrol的展示

 @param scrollView 循环的scrollview
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == Width * (_count - 1)) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width, 0)];
    }else if (scrollView.contentOffset.x == 0){
        CGFloat x = self.scrollView.bounds.size.width * (_count - 2);
        [self.scrollView setContentOffset:CGPointMake(x , 0)];
    }
    _page = (scrollView.contentOffset.x - Width)/Width;
    self.pageControl.currentPage =_page;
}
// 防止按住图片而没有停止定时器

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.time invalidate];
    self.time = nil;
}
// 可不予理睬定时器

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.time = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(CurrentPage) userInfo:nil repeats:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
