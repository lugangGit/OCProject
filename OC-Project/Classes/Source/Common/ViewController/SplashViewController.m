//
//  SplashViewController.m
//  OC-Project
//
//  Created by 梓源 on 2021/1/11.
//

#import "SplashViewController.h"
#import "CustomAlertView.h"
#import "SplashScrollView.h"

@interface SplashViewController () <SplashScrollViewDelegate>
@property (nonatomic, strong) CustomAlertView *privacyView;
@property (nonatomic, strong) SplashScrollView *splashScrollView;

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //第一次启动
    if (![kNSUserDefaults boolForKey:IS_FIRSTOPEN]) {
        //隐私协议
        [self.view addSubview:self.privacyView];
    }else {
        //视频、图片广告
        
    }
}

#pragma mark - 第一次启动欢迎界面
- (void)splashScrollView:(NSInteger)index {
    [self dismissViewControllerAnimated:NO completion:^{
        if ([self.delegate respondsToSelector:@selector(splashDidFinished:)]) {
            [self.delegate splashDidFinished:1];
        }
    }];
}

- (CustomAlertView *)privacyView {
    if (!_privacyView) {
        _privacyView = [[CustomAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _privacyView.title = @"隐私协议";
        _privacyView.content = @"为了更好的维护您的利益，我们对《用户协议》及《隐私政策》进行了更新，特向您推送本提示。请仔细阅读并充分理解相关条款。\n\n 您点击\"同意\"，即表示您已阅读并同意更新后的《用户协议》及《隐私政策》";
        [_privacyView.rightButton setTitle:@"同意" forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        _privacyView.callback = ^(BOOL isTrue) {
//            [kNSUserDefaults setBool:YES forKey:IS_FIRSTOPEN];
            [weakSelf.view addSubview:weakSelf.splashScrollView];
            [weakSelf.splashScrollView updataScrollView:nil];
        };
    }
    return _privacyView;
}

- (SplashScrollView *)splashScrollView {
    if (!_splashScrollView) {
        _splashScrollView = [[SplashScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _splashScrollView.delegate = self;
    }
    return _splashScrollView;
}

- (void)dealloc {
    NSLog(@"deallow");
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
