//
//  Macros.h
//  OC-Project
//
//  Created by 卢梓源 on 2020/12/15.
//

#ifndef Macros_h
#define Macros_h

#pragma mark -------- 关于设备
/// 屏幕尺寸
#define kScreenWidth   ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight   ([UIScreen mainScreen].bounds.size.height)

/// 判断是否为iPhone
#define IS_IPHONE  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
/// 判断是否为iPad
#define IS_IPAD  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
/// 判断是否为ipod
#define IS_IPOD  ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
/// 判断iPhoneX等刘海屏系列
#define IS_IPHONEX_SERIES  (([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? YES : NO) && !IS_IPAD)
/// StatusBar高度
#define kStatusBarHeight  ((IS_IPHONEX_SERIES == YES) ? 44 : 20)
/// 导航栏高度
#define kNavigationHeight  (IS_IPHONEX_SERIES ? 88 : 64)
/// TabBar高度
#define kTabbarHeight  (IS_IPHONEX_SERIES ? 83 : 49)
/// TabBar高度
#define kViewHeight (kScreenHeight - kNavigationHeight)

/// 用户机型判断宏
#define kDeviceSize [[UIScreen mainScreen] currentMode].size
/// 判断iPhone5系列
#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), kDeviceSize) && !IS_IPAD : NO)
/// 判断iPhone6系列(包含iPhone6/iPhone7/iPhone8)
#define IS_IPHONE6  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), kDeviceSize) && !IS_IPAD : NO)
/// 判断iphone6P系列(包含iPhone6P/iPhone7P/iPhone8P)
#define IS_IPHONEP  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), kDeviceSize) && !IS_IPAD : NO)
/// 判断iPhoneX
#define IS_IPHONEX  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), kDeviceSize) && !IS_IPAD : NO)
/// 判断iPHoneXr | 11
#define IS_IPHONEXR  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), kDeviceSize) && !DDiPad : NO)
/// 判断iPhoneXs | 11Pro
#define IS_IPHONEXS  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), kDeviceSize) && !IS_IPAD : NO)
/// 判断iPhoneXs Max | 11ProMax
#define IS_IPHONEXSMAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), kDeviceSize) && !IS_IPAD : NO)
/// 判断iPhone12_Mini
#define IS_iPhone12_Mini ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 2340), kDeviceSize) && !IS_IPAD : NO)
/// 判断iPhone12 | 12Pro
#define IS_iPhone12 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1170, 2532), kDeviceSize) && !IS_IPAD : NO)
/// 判断iPhone12 Pro Max
#define IS_iPhone12_ProMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1284, 2778), kDeviceSize) && !IS_IPAD : NO)

/// keyWindow
#define kKeyWindow  [[[UIApplication sharedApplication] windows] objectAtIndex:0]
/// UIApplication单例对象
#define kApplication  [UIApplication sharedApplication]
/// NSUserDefaults实例化
#define kNSUserDefaults  [NSUserDefaults standardUserDefaults]
/// 通知中心
#define kNotificationCenter  [NSNotificationCenter defaultCenter]
/// 发送通知
#define kPostNotification(name,obj,info)  [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj userInfo:info]
#define KDatabaseManager  [DatabaseManager sharedDatabase]

/// APP版本号
#define kVersion  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]
/// 系统版本号
#define kSystemVersion  [[UIDevice currentDevice] systemVersion]

/// 字体定义
#define kFontSystemSize(F)   [UIFont systemFontOfSize:F]
#define kFontSystemBoldSize(F)   [UIFont boldSystemFontOfSize:F]
#define kFontSize(F)   [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]

/// 弱引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type
/// 强引用
#define kStrongSelf(type)  __strong typeof(type) type = weak##type

/// log扩展
#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif

#pragma mark -------- 自定义参数
#define IS_FIRSTOPEN  @"isFirst"
//  以IPhone6为标准
#define kSproportion  kScreenWidth/375.0
#define kPageSize  20
#define kNavItemWidth  40
#define kMargin  15







#endif /* Macros_h */
