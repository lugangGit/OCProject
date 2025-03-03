//
//  UMengTool.m
//  OC-Project
//
//  Created by 梓源 on 2020/12/18.
//

#import "UMengTool.h"
#import <UMShare/UMShare.h>

@implementation UMengTool

//初始化友盟所有组件产品
+ (void)initUMPlatform:(id)delegate {
    [UMConfigure initWithAppkey:UMAppKey channel:@"App Store"];
    
    //UM config 
    [UMengTool configStatisticsSettings];
    
    //U-Share 平台设置
    [UMengTool configUShareSettings];
    [UMengTool configUSharePlatforms];
}

+ (void)configStatisticsSettings {
    //开发者需要显式的调用此函数，日志系统才能工作
    [UMCommonLogManager setUpUMCommonLogManager];
    
    /** 设置是否对统计信息进行加密传输, 默认NO(不加密).
     @param value 设置为YES, umeng SDK 会将日志信息做加密处理
     */
    //[UMConfigure setEncryptEnabled:YES];//打开加密传输

#if DEBUG
    /** 设置是否在console输出SDK的log信息.
     @param bFlag 默认NO(不输出log); 设置为YES, 输出可供调试参考的log信息. 发布产品时必须设置为NO.
     */
    [UMConfigure setLogEnabled:YES];
#endif
}

+ (void)configUShareSettings {
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
        //配置微信平台的Universal Links
    //微信和QQ完整版会校验合法的universalLink，不设置会在初始化平台失败
    
//    [UMSocialGlobal shareInstance].universalLinkDic = @{@(UMSocialPlatformType_WechatSession):wechatUniversalLink,
//                                                        @(UMSocialPlatformType_QQ):qqUniversalLink};
    // 微信、QQ、微博完整版会校验合法的universalLink，不设置会在初始化平台失败
       //配置微信Universal Link需注意 universalLinkDic的key是rawInt类型，不是枚举类型 ，即为 UMSocialPlatformType.wechatSession.rawInt
    [UMSocialGlobal shareInstance].universalLinkDic =@{@(UMSocialPlatformType_WechatSession):universalLink,
    @(UMSocialPlatformType_QQ):qqUniversalLink,
     @(UMSocialPlatformType_Sina):universalLink};
}

+ (void)configUSharePlatforms {
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:wechatKey appSecret:wechatSecret redirectURL:redirectURL];
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:qqKey appSecret:nil redirectURL:redirectURL];
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:sinaKey appSecret:sinaSecret redirectURL:redirectURL];
}

+ (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

//设置Universal Links系统回调
+ (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler {
    if (![[UMSocialManager defaultManager] handleUniversalLink:userActivity options:nil]) {
        // 其他SDK的回调
    }
    return YES;
}

/// 微信登陆
/// @param UMCompletion 回调
+ (void)wechatLoginCompletion:(UMCompletionHandler)UMCompletion {
    [UMengTool getUserInfoForPlatform:UMSocialPlatformType_WechatSession completion:^(UMSocialUserInfoResponse * _Nullable result, NSError * _Nonnull error) {
        UMCompletion(result, error);
    }];
}

/// QQ登陆
/// @param UMCompletion 回调
+ (void)qqLoginCompletion:(UMCompletionHandler)UMCompletion {
    [UMengTool getUserInfoForPlatform:UMSocialPlatformType_QQ completion:^(UMSocialUserInfoResponse * _Nullable result, NSError * _Nonnull error) {
        UMCompletion(result, error);
    }];
}

/// 新浪微博
/// @param UMCompletion 回调
+ (void)sinaLoginCompletion:(UMCompletionHandler)UMCompletion {
    [UMengTool getUserInfoForPlatform:UMSocialPlatformType_Sina completion:^(UMSocialUserInfoResponse * _Nullable result, NSError * _Nonnull error) {
        UMCompletion(result, error);
    }];
}

+ (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType completion:(UMCompletionHandler)UMCompletion {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        UMCompletion(result, error);
        
        UMSocialUserInfoResponse *resp = result;
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];
}

@end
