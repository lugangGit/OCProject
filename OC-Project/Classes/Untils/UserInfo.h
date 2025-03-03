//
//  UserInfo.h
//  OC-Project
//
//  Created by 卢梓源 on 2020/12/17.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,DQHLoginType)
{
    DQHLoginType_WeiBo,   // 微博
    DQHLoginType_WeiXin   // 微信
};

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject

// 是否登录
+ (BOOL)isLogin;
+ (void)setLoginStatus;

// 用户token
+ (NSString *)getUserToken;
+ (void)setUserToken:(NSString *)userToken;

// 用户登录方式
//+ (DQHLoginType)getUesrLoginType;
//+ (void)setUserLoginType:(DQHLoginType)type;

// 用户邮箱Email
+ (NSString *)getUserEmail;
+ (void)setUserEmail:(NSString *)userEmail;

// 用户手机号
+ (NSString *)getUserMobile;
+ (void)setUserMobile:(NSString *)userMobile;

// 用户名
+ (NSString *)getUserName;
+ (void)setUserName:(NSString *)userName;

// 真实姓名
+ (NSString *)getRealName;
+ (void)setRealName:(NSString *)realName;

// 密码
+ (NSString *)getUserPassword;
+ (void)setUserPassword:(NSString *)password;

// 头像
+ (NSString *)getUserAvater;
+ (void)setUserAvater:(NSString *)avater;

// 积分
+ (NSString *)getUserScore;
+ (void)setUserScore:(NSString *)score;

// QQ
+ (NSString *)getSocialQQ;
+ (void)setSocialQQ:(NSString *)binded;

// WX
+ (NSString *)getSocialWX;
+ (void)setSocialWX:(NSString *)binded;

// WB
+ (NSString *)getSocialWB;
+ (void)setSocialWB:(NSString *)binded;

// 退出登录
+ (void)logout;

@end

NS_ASSUME_NONNULL_END
