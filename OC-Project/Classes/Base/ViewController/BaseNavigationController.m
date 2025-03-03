//
//  BaseNavigationController.m
//  OC-Project
//
//  Created by 卢梓源 on 2020/12/15.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

+ (void)initialize {
    //appearance外观对象
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    //设置导航栏背景颜色
    [navigationBar setBarTintColor:kColorPrimary];
    //设置背景图
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_background"] forBarMetrics:UIBarMetricsDefault];
    //设置NavigationBarItem文字的颜色
    [navigationBar setTintColor:[UIColor whiteColor]];
    //设置标题栏
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:18]};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        // 滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
        //返回按钮自定义
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -20;
        
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0, 0, kNavItemWidth, kNavItemWidth);
        if (@available(ios 11.0,*)) {
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        }
        [button addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        viewController.navigationItem.leftBarButtonItems = @[space, backButton];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)backItemAction:(id)sender {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }else{
        [self popViewControllerAnimated:YES];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
