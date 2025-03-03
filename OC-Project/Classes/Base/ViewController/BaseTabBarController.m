//
//  BaseTabBarController.m
//  OC-Project
//
//  Created by 卢梓源 on 2020/12/14.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
#import "LoginViewController.h"
#import "ColumnModel.h"

@interface  BaseTabBarController () <UITabBarControllerDelegate>
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) NSMutableArray *tabBarBtnArray;
@property (nonatomic, assign) int indexFlag;
@end

@implementation BaseTabBarController

- (NSMutableArray *)tabBarBtnArray {
    if (!_tabBarBtnArray) {
        _tabBarBtnArray = [NSMutableArray array];
    }
    return _tabBarBtnArray;
}

- (NSMutableArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //创建子控制器
    [self createTabBarItem];
    
    //tabbar动画效果
    self.indexFlag = 0;
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < 15; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_%d", i]];
        [images addObject:image];
    }
    [self.imagesArray addObject:images];
}

- (void)createTabBarItem {
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    BaseNavigationController *homeNV = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
    [self setTabBarItem:homeNV.tabBarItem
                  title:@"首页"
              titleSize:13.0
          titleFontName:@"Thonburi"
          selectedImage:@"tab_home_selected"
     selectedTitleColor:kColorPrimary
            normalImage:@"tab_home_normal"
       normalTitleColor:kColorGray];

    MineViewController *mineVC = [[MineViewController alloc] init];
    BaseNavigationController *mineNV = [[BaseNavigationController alloc] initWithRootViewController:mineVC];
    [self setTabBarItem:mineNV.tabBarItem
                  title:@"我的"
              titleSize:13.0
          titleFontName:@"Thonburi"
          selectedImage:@"tab_mine_selected"
     selectedTitleColor:kColorPrimary
            normalImage:@"tab_mine_normal"
       normalTitleColor:kColorGray];

    self.viewControllers = @[homeNV, mineNV];
}

- (void)createTabBarItem:(NSMutableArray*)channelArray {
    //创建子控制器
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    BaseNavigationController *homeNV = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    BaseNavigationController *mineNV = [[BaseNavigationController alloc] initWithRootViewController:mineVC];
    
    if (channelArray.count >= 2) {
        for (int i = 0; i < 2; i++) {
            ColumnModel *column = channelArray[i];
            if (i == 0) {
                [self setTabBarItem:homeNV.tabBarItem
                              title:@"首页"
                          titleSize:13.0
                      titleFontName:@"Thonburi"
                      selectedImage:column.padIcon
                 selectedTitleColor:kColorPrimary
                        normalImage:column.phoneIcon
                   normalTitleColor:kColorGray];
            }else if (i == 1) {
                [self setTabBarItem:mineNV.tabBarItem
                              title:@"我的"
                          titleSize:13.0
                      titleFontName:@"Thonburi"
                      selectedImage:column.padIcon
                 selectedTitleColor:kColorPrimary
                        normalImage:column.phoneIcon
                   normalTitleColor:kColorGray];
            }
        }
        self.viewControllers = @[homeNV, mineNV];
    }else {
        [self createTabBarItem];
    }
}

- (void)setTabBarItem:(UITabBarItem *)tabbarItem
                title:(NSString *)title
            titleSize:(CGFloat)size
        titleFontName:(NSString *)fontName
        selectedImage:(NSString *)selectedImage
   selectedTitleColor:(UIColor *)selectColor
          normalImage:(NSString *)normalImage
     normalTitleColor:(UIColor *)unselectColor {
    //本地图片
//    tabbarItem = [tabbarItem initWithTitle:title image:[[UIImage imageNamed:normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //网络加载图片
    tabbarItem.title = title;
    [self loadTabbarItemSelectedImage:tabbarItem selectedImage:selectedImage];
    [self loadTabbarItemImage:tabbarItem normalImage:normalImage];
    
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:[UIFont fontWithName:fontName size:size]} forState:UIControlStateSelected];
    
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:[UIFont fontWithName:fontName size:size]} forState:UIControlStateNormal];
}

- (void)loadTabbarItemImage:(UITabBarItem *)tabbarItem normalImage:(NSString *)normalImage {
    tabbarItem.image = [UIImage imageNamed:@"tab_home_normal"];
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:normalImage] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
     } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
         if (finished && image) {
             CGImageRef imgRef = image.CGImage;
             UIImage *img = [UIImage imageWithCGImage:imgRef scale:2 orientation:UIImageOrientationUp];
             tabbarItem.image = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
         }
    }];
}

- (void)loadTabbarItemSelectedImage:(UITabBarItem *)tabbarItem selectedImage:(NSString *)selectedImage {
    tabbarItem.selectedImage = [UIImage imageNamed:@"tab_home_selected"];
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:selectedImage] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
     } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
         if (finished && image) {
             CGImageRef imgRef = image.CGImage;
             UIImage *img = [UIImage imageWithCGImage:imgRef scale:2 orientation:UIImageOrientationUp];
             tabbarItem.selectedImage = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
         }
    }];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    //前往登录页
//    if (viewController == [tabBarController.viewControllers objectAtIndex:1]) {
//        if (![UserInfo isLogin]) {
//            [self showLogin];
//            return NO;
//        }
//    }
    
    //双击tabbar操作
    static UIViewController *lastViewController = nil;
    static NSTimeInterval lastClickTime = 0;
    if (lastViewController != viewController) {
        lastViewController = viewController;
        lastClickTime = [NSDate timeIntervalSinceReferenceDate];
        return YES;
    }
    NSTimeInterval clickTime = [NSDate timeIntervalSinceReferenceDate];
    if (clickTime - lastClickTime < 0.7 ) {
        NSLog(@"双击tabbar");
        lastClickTime = clickTime;
        
        //3.动图效果，执行动画
//        UIView *button = self.tabBarBtnArray[self.indexFlag];
//        NSArray *images = self.imagesArray[0];
//        for (UIView *imageV in button.subviews) {
//            if ([imageV isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
//                 UIImageView *imageView = (UIImageView*)imageV;
//                 imageView.animationImages = images;
//                 imageView.animationDuration = images.count * 0.08;
//                 imageView.animationRepeatCount = 1;
//                 [imageView startAnimating];
//            }
//        }
        
        return NO;
    }
    lastClickTime = clickTime;
    
    return YES;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    //1、缩放效果
    int index = [NSNumber numberWithUnsignedInteger:[tabBar.items indexOfObject:item]].intValue;
    if (index != self.indexFlag) {
        NSMutableArray *tabBarBtnArray = [NSMutableArray array];
        for (UIView *btn in self.tabBar.subviews) {
            if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [tabBarBtnArray addObject:btn];
                //NSLog(@"tabBarButton.sup=%@", [tabBarButton.class]);
            }
        }
        //添加动画
        [self addScaleAnimtaionWithArr:tabBarBtnArray index:index];
        self.indexFlag = index;
    }
    
    //2、动图效果，添加到数组
//    self.indexFlag = [NSNumber numberWithUnsignedInteger:[tabBar.items indexOfObject:item]].intValue;
//    for (UIView *btn in self.tabBar.subviews) {
//        if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            [self.tabBarBtnArray addObject:btn];
//            //NSLog(@"tabBarButton.sup=%@", [tabBarButton.class]);
//        }
//    }
}

#pragma mark - 前往登录页
- (void)showLogin {
    LoginViewController *VC = [[LoginViewController alloc] init];
    VC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:VC animated:YES completion:nil];
}

#pragma mark - More Animation
/// 先放大，再缩小
- (void)addScaleAnimtaionWithArr:(NSMutableArray *)array index:(NSInteger)index
{
    //放大效果，并回到原位
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.15;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
    animation.fromValue = [NSNumber numberWithFloat:0.9];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.0];     //结束伸缩倍数
    [[array[index] layer] addAnimation:animation forKey:nil];
}

/// Z轴旋转
- (void)addRotationAnimtaionWithArr:(NSMutableArray *)array index:(NSInteger)index
{
    //z轴旋转180度
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.removedOnCompletion = YES;
    animation.fromValue = [NSNumber numberWithFloat:0];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:M_PI];     //结束伸缩倍数
    [[array[index] layer] addAnimation:animation forKey:nil];
}

/// 向上移动
- (void)addUpTranslationAnimtaionWithArr:(NSMutableArray *)array index:(NSInteger)index
{
    //向上移动
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.removedOnCompletion = YES;
    animation.fromValue = [NSNumber numberWithFloat:0];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:-10];     //结束伸缩倍数
    [[array[index] layer] addAnimation:animation forKey:nil];
}

/// 放大并保持
- (void)addscaleAndKeepAnimtaionWithArr:(NSMutableArray *)array index:(NSInteger)index
{
    //放大效果
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;           //保证动画效果延续
    animation.fromValue = [NSNumber numberWithFloat:1.0];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.15];     //结束伸缩倍数
    [[array[index] layer] addAnimation:animation forKey:nil];
    //移除其他tabbar的动画
    for (int i = 0; i<array.count; i++) {
        if (i != index) {
            [[array[i] layer] removeAllAnimations];
        }
    }
}

@end
