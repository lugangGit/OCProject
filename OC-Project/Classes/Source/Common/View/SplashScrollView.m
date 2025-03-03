//
//  SplashScrollView.m
//  OC-Project
//
//  Created by 梓源 on 2021/1/15.
//

#import "SplashScrollView.h"

@interface SplashScrollView ()<UIScrollViewDelegate>

/** view */
@property (nonatomic, strong) UIScrollView *scrollView;
/** pageControl */
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, assign) BOOL isShow;

@end

@implementation SplashScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColorBackground;
        [self createUI];
        [self createPageControl];
    }
    return self;
}

#pragma mark - 创建视图
- (void)createUI {
    //创建视图
    [self addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
}

//配置底部的圆点
-(void)createPageControl {
    //创建圆点
    [self addSubview:self.pageControl];
    self.pageControl.frame = CGRectMake(0, kScreenHeight-50, kScreenWidth, 10);
    //圆点的个数
    self.pageControl.numberOfPages = 3;
    //设置圆点的颜色
    self.pageControl.pageIndicatorTintColor = kColorBlack;
    //设置被选中的圆点的颜色
    self.pageControl.currentPageIndicatorTintColor = kColorWhite;
    
//    [self.pageControl setValue:[UIImage imageNamed:@"pageControl_default"]forKeyPath:@"pageImage"];
//    [self.pageControl setValue:[UIImage imageNamed:@"pageControl_public"]forKeyPath:@"currentPageImage"];
    
    //设置pageControl不能与用户交互
    self.pageControl.userInteractionEnabled = NO;
    
    //当pageControl的currentPage发生变化的时候，让scrollView上的图像视图 做出对应的变化；
    self.pageControl.currentPage = 0;
    //self.scrollView.contentOffset = CGPointMake(self.bounds.size.width * 1, 0);
}

#pragma mark - 更新数据
-(void)updataScrollView:(id)model {
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    self.scrollView.contentSize = CGSizeMake(3*kScreenWidth, kScreenHeight);
    for (NSInteger i=0; i < 3; i++)
    {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        bgView.backgroundColor = kColorRandom;
        bgView.tag = 1000 + i;
        [self.scrollView addSubview:bgView];

        //创建轻拍手势器
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapItem:)];
        [bgView addGestureRecognizer:tap];
    }
}

#pragma mark - UIScrollViewDelegate协议
//滚动视图一滚动，就给代理发此消息
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    //算出横向偏移量与可见区域宽度的整数倍
    //round（）函数  四舍五入
    self.pageControl.currentPage = round(point.x/scrollView.frame.size.width);
    self.selectIndex = self.pageControl.currentPage;

    NSLog(@"pageIndex:%ld", (long)self.pageControl.currentPage);
}

//手势触发事件
- (void)tapItem:(UITapGestureRecognizer *)tap {
    //获取当前图片的tag值
    if ([self.delegate respondsToSelector:@selector(splashScrollView:)]) {
        [self.delegate splashScrollView:tap.view.tag];
    }
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        //边缘不弹跳
        _scrollView.bounces = YES;
        //整页滚动
        _scrollView.pagingEnabled = YES;
        //不出现水平滚动提示
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

-(UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
    }
    return _pageControl;
}

@end
