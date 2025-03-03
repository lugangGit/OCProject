//
//  UMengTool.h
//  OC-Project
//
//  Created by 梓源 on 2020/12/18.
//

#import <Foundation/Foundation.h>
#import <UMCommon/UMCommon.h>
#import <UMCommonLog/UMCommonLogHeaders.h>
#import <UMShare/UMShare.h>

typedef void (^UMCompletionHandler)(UMSocialUserInfoResponse * _Nullable result, NSError * _Nonnull error);
NS_ASSUME_NONNULL_BEGIN

@interface UMengTool : NSObject

/// 初始化友盟所有组件产品
+ (void)initUMPlatform:(id)delegate;

/// 微信登陆
/// @param UMCompletion 回调
+ (void)wechatLoginCompletion:(UMCompletionHandler)UMCompletion;

/// QQ登陆
/// @param UMCompletion 回调
+ (void)qqLoginCompletion:(UMCompletionHandler)UMCompletion;

/// 新浪微博
/// @param UMCompletion 回调
+ (void)sinaLoginCompletion:(UMCompletionHandler)UMCompletion;

+ (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;

+ (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler;

@end

NS_ASSUME_NONNULL_END
