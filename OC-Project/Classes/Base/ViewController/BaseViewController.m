//
//  BaseViewController.m
//  OC-Project
//
//  Created by 卢梓源 on 2020/12/15.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, assign)int i;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setNavRightItemTitle:(NSString *)title imageName:(NSString *)imageName {
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kNavItemWidth, kNavItemWidth)];
    if (![NSString isNilOrEmpty:title]) {
        [rightBtn setTitle:title forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [rightBtn setTitleColor:kColorPrimary forState:UIControlStateNormal];
    }else {
        UIImage *image = [UIImage imageNamed:imageName];
        [rightBtn setImage:image forState:UIControlStateNormal];
    }
    
    rightBtn.exclusiveTouch = YES;
    [rightBtn addTarget:self action:@selector(rightItemAction:) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)rightItemAction:(id)sender {
    
}

#pragma mark - MBProgressHUD
-(void)showLoading {
    [self.view endEditing:YES];
    self.hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
//    hud.contentColor = [UIColor colorWithRed:0.f green:0.6f blue:0.7f alpha:1.f];
//    self.hud.label.text = NSLocalizedString(@"Loading...", @"加载中");
}

-(void)hideLoading {
    [self.view endEditing:NO];
    [self.hud hideAnimated:YES];
}

- (void)showMessage:(NSString *)message {
    self.hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    // Set the text mode to show only text.
    self.hud.mode = MBProgressHUDModeText;
    self.hud.label.text = message;
    // Move to bottm center.
    self.hud.label.numberOfLines = 2;
    self.hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [self.hud hideAnimated:YES afterDelay:2.f];
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
