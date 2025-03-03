//
//  UserInfo.m
//  OC-Project
//
//  Created by 卢梓源 on 2020/12/17.
//

#import "UserInfo.h"

#define USER_IsLogin_KEY                        @"user_login" //是否登录
#define USER_Mobile_KEY                         @"user_mobile" //手机号
#define USER_Email_KEY                          @"user_email" //邮箱
#define USER_UserName_KEY                       @"user_username" // 用户名
#define USER_Password_KEY                       @"user_password" // 密码
#define USER_Avater_KEY                         @"user_avater" //头像
#define USER_Score_KEY                          @"user_score" //积分
#define USER_RealName_KEY                       @"user_realName" //真实姓名
#define USER_Token_KEY                          @"user_token" //token
#define USER_QQ_KEY                             @"user_qq" //qq
#define USER_WX_KEY                             @"user_wx" //wx
#define USER_WB_KEY                             @"user_wb" //wb

@implementation UserInfo

// 是否登录
+ (BOOL)isLogin{
    return [kNSUserDefaults boolForKey:USER_IsLogin_KEY];
}
+ (void)setLoginStatus {
    [kNSUserDefaults setBool:YES forKey:USER_IsLogin_KEY];
    [kNSUserDefaults synchronize];
}

// 用户邮箱Email
+ (NSString *)getUserEmail{
    return [kNSUserDefaults objectForKey:USER_Email_KEY];
}
+ (void)setUserEmail:(NSString *)userEmail{
    NSString * email = @"";
    if ([userEmail isNotEmpty])
    {
        email = userEmail;
    }
    
    [kNSUserDefaults setObject:email forKey:USER_Email_KEY];
    [kNSUserDefaults synchronize];
}

// 用户Token
+ (NSString *)getUserToken{
    return [kNSUserDefaults objectForKey:USER_Token_KEY];
}
+ (void)setUserToken:(NSString *)userToken {
    NSString * token = @"";
    if ([userToken isNotEmpty])
    {
        token = userToken;
    }
    
    [kNSUserDefaults setObject:token forKey:USER_Token_KEY];
    [kNSUserDefaults synchronize];
}

// 用户手机号
+ (NSString *)getUserMobile{
    return [kNSUserDefaults objectForKey:USER_Mobile_KEY];
}
+ (void)setUserMobile:(NSString *)userMobile{
    NSString * mobile = @"";
    if ([userMobile isNotEmpty])
    {
        mobile = userMobile;
    }
    
    [kNSUserDefaults setObject:mobile forKey:USER_Mobile_KEY];
    [kNSUserDefaults synchronize];
}

// 用户名
+ (NSString *)getUserName{
    return [kNSUserDefaults objectForKey:USER_UserName_KEY];
}
+ (void)setUserName:(NSString *)userName{
    NSString * username = @"";
    if ([userName isNotEmpty])
    {
        username = userName;
    }
    
    [kNSUserDefaults setObject:username forKey:USER_UserName_KEY];
    [kNSUserDefaults synchronize];
}

// 密码
+ (NSString *)getUserPassword{
    return [kNSUserDefaults objectForKey:USER_Password_KEY];
}
+ (void)setUserPassword:(NSString *)password{
    NSString * pass = @"";
    if ([password isNotEmpty])
    {
        pass = password;
    }
    
    [kNSUserDefaults setObject:pass forKey:USER_Password_KEY];
    [kNSUserDefaults synchronize];
}

// 头像
+ (NSString *)getUserAvater{
    return [kNSUserDefaults objectForKey:USER_Avater_KEY];
}
+ (void)setUserAvater:(NSString *)avater{
    NSString * ava = @"";
//    if ([avater isNotEmpty]&&![avater isEqualToString:@"<null>"])
//    {
//        ava = avater;
//    }
    if ([avater isNotEmpty])
    {
        ava = avater;
    }
    
    [kNSUserDefaults setObject:ava forKey:USER_Avater_KEY];
    [kNSUserDefaults synchronize];
}

// 积分
+ (NSString *)getUserScore{
    return [kNSUserDefaults objectForKey:USER_Score_KEY];
}
+ (void)setUserScore:(NSString *)score{
    NSString * sc = @"";
    if ([score isNotEmpty])
    {
        sc = score;
    }

    [kNSUserDefaults setObject:sc forKey:USER_Score_KEY];
    [kNSUserDefaults synchronize];
}

// 真是姓名
+ (NSString *)getRealName{
    return [kNSUserDefaults objectForKey:USER_RealName_KEY];
}
+ (void)setRealName:(NSString *)realName{
    NSString * rn = @"";
    if ([rn isNotEmpty])
    {
        rn = realName;
    }
    
    [kNSUserDefaults setObject:rn forKey:USER_RealName_KEY];
    [kNSUserDefaults synchronize];
}

// QQ
+ (NSString *)getSocialQQ {
    return [kNSUserDefaults objectForKey:USER_QQ_KEY];
}
+ (void)setSocialQQ:(NSString *)binded {
    [kNSUserDefaults setObject:binded forKey:USER_QQ_KEY];
    [kNSUserDefaults synchronize];
}

// WX
+ (NSString *)getSocialWX {
    return [kNSUserDefaults objectForKey:USER_WX_KEY];
}
+ (void)setSocialWX:(NSString *)binded{
    [kNSUserDefaults setObject:binded forKey:USER_WX_KEY];
    [kNSUserDefaults synchronize];
}

// WB
+ (NSString *)getSocialWB {
    return [kNSUserDefaults objectForKey:USER_WB_KEY];
}
+ (void)setSocialWB:(NSString *)binded {
    [kNSUserDefaults setObject:binded forKey:USER_WB_KEY];
    [kNSUserDefaults synchronize];
}

// 退出登录
+ (void)logout {
    [kNSUserDefaults removeObjectForKey:USER_IsLogin_KEY];
    [kNSUserDefaults removeObjectForKey:USER_Token_KEY];
    [kNSUserDefaults removeObjectForKey:USER_Mobile_KEY];
    [kNSUserDefaults removeObjectForKey:USER_Email_KEY];
    [kNSUserDefaults removeObjectForKey:USER_UserName_KEY];
    [kNSUserDefaults removeObjectForKey:USER_Password_KEY];
    [kNSUserDefaults removeObjectForKey:USER_Avater_KEY];
    [kNSUserDefaults removeObjectForKey:USER_Score_KEY];
    [kNSUserDefaults removeObjectForKey:USER_RealName_KEY];
    [kNSUserDefaults removeObjectForKey:USER_QQ_KEY];
    [kNSUserDefaults removeObjectForKey:USER_WX_KEY];
    [kNSUserDefaults removeObjectForKey:USER_WB_KEY];
    [kNSUserDefaults synchronize];
}

@end
