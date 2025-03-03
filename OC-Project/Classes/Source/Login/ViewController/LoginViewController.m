//
//  LoginViewController.m
//  OC-Project
//
//  Created by 卢梓源 on 2020/12/16.
//

#import "LoginViewController.h"
#import "AlertViewTool.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

static const NSString *CompanyFirstDomainByWeChatRegister = @"";//微信 H5支付的授权域名（兑啊账号、商户平台-产品中心-开发配置自行配置、配置了5种）

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorHEX(@"#02A0E9");
    [self setNavRightItemTitle:@"" imageName:@"icon_nav_share"];
    if (IS_IPHONEX_SERIES) {
        NSLog(@"IS_IPHONEX_SERIES");
    }
//    [self showMessage:@"测试showMessage"];
    
//    [AlertViewTool showAlertControllerWithTitle:@"一测试的测试的测试的测试的" mesasge:@"" cancelTitle:@"取消" confirmTitle:@"确定" confirmHandler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"123");
//    } cancleHandler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"456");
//    }];
    
//    [AlertViewTool showSheetController:@"一测试的测试的测试的测试的" message:@"二测试message" cancelTitle:@"取消" buttonTitles:@[@"一一", @"二二", @"三三"] confirm:^(NSInteger index) {
//        NSLog(@"%d", index);
//    }];
    
//    [[AlertViewTool sharedInstacne] showAlertViewWithTitle:@"一测试的测试的测试的测试的" message:@"二测试message" cancleButtonTitle:@"取消" okButtonTitle:@"确定" otherButtonTitleArray:nil clickHandler:^(NSInteger index) {
//        NSLog(@"%d", index);
//    }];
//#if APPCLIP
//  // do somethings
//    [[AlertViewTool sharedInstacne] showAlertViewWithTitle:@"APPCLIP" message:@"二测试message" cancleButtonTitle:@"取消" okButtonTitle:@"确定" otherButtonTitleArray:nil];
//#endif
    
//    [[AlertViewTool sharedInstacne] showAlertViewWithTitle:@"一测试的测试的测试的测试的" message:@"二测试message" cancleButtonTitle:@"取消" okButtonTitle:@"确定" otherButtonTitleArray:nil];
    
}



- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


#pragma mark - 解码方法
- (NSString *)decodedString:(NSString *)urlString {
    NSString *decodedString = [urlString stringByRemovingPercentEncoding];
    return decodedString;
}

#pragma mark - 编码方法
- (NSString *)encodeString:(NSString *)urlString {
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodeString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodeString;
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
