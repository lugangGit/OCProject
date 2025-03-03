//
//  AppDelegate.m
//  OC-Project
//
//  Created by 卢梓源 on 2020/12/11.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "SplashViewController.h"
#import "UMengTool.h"
#import "PushService.h"
#import <UserNotifications/UserNotifications.h>
#import <UMPush/UMessage.h>
#import "AlertViewTool.h"
#import "StartViewModel.h"
#import "LoginViewController.h"
#import "DatabaseManager.h"

@interface AppDelegate () <UNUserNotificationCenterDelegate, SplashDelegate>
@property (nonatomic, strong) NSDictionary *launchOptions;
@property (nonatomic, strong) StartViewModel *startVM;
@property (nonatomic, strong) BaseTabBarController *tabBarController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.launchOptions = [NSDictionary dictionaryWithDictionary:launchOptions];
    //创建Window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = kColorWhite;
    
    if (![kNSUserDefaults boolForKey:IS_FIRSTOPEN]) {
        //第一次启动
        [self initSplash];
        [kNSUserDefaults setBool:YES forKey:IS_FIRSTOPEN];
    }else {
        [self platformSettings];
    }
    
    return YES;
}

#pragma mark - 启动页
- (void)initSplash {
    UIViewController *VC = [[UIViewController alloc] init];
    self.window.rootViewController = VC;
    [self.window makeKeyAndVisible];

    //启动页
    SplashViewController *splash = [[SplashViewController alloc] init];
    splash.delegate = self;
    splash.modalPresentationStyle = UIModalPresentationFullScreen;
    [VC presentViewController:splash animated:NO completion:nil];
}

#pragma mark - splash
- (void)splashDidFinished:(NSInteger)index {
    NSLog(@"splashDidFinished %ld", (long)index);
    //启动配置
    [self platformSettings];
}

#pragma mark - 启动配置
- (void)platformSettings {
    //创建跟视图
    [self initRootViewController];
    //创建本地缓存
    [self initLocalCache];
    //友盟初始化
    [UMengTool initUMPlatform:self];
    //友盟推送
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    [PushService configUMessage:self.launchOptions];
    //请求数据
    [self loadConfig];
}

#pragma mark - 创建根控制器
- (void)initRootViewController {
    if ([UserInfo isLogin]) {
        //登录
        LoginViewController *VC = [[LoginViewController alloc] init];
        self.window.rootViewController = VC;
        [self.window makeKeyAndVisible];
    }else {
        //首页
        self.tabBarController = [[BaseTabBarController alloc] init];
        self.window.rootViewController = self.tabBarController;
        [self.window makeKeyAndVisible];
    }
}

#pragma mark - 请求数据
- (void)loadConfig {
    __weak typeof(self) weakSelf = self;
    [self.startVM loadConfig:^(BOOL isSuccess, NSString *message, id obj) {
        self.tabBarController.tabBar.hidden = isSuccess ? NO : YES;
        if (isSuccess) {
            [weakSelf loadChannels];
        }else {
            [weakSelf showAlertView:message];
        }
    }];
}

- (void)loadChannels {
    __weak typeof(self) weakSelf = self;
    [self.startVM loadChannelsWithColumnId:0 completionHandler:^(BOOL isSuccess, NSString *message, id obj) {
        if (isSuccess) {
            //创建根控制器
            [self.tabBarController createTabBarItem:self.startVM.channelArray];
        }else {
            [weakSelf showAlertView:message];
        }
    }];
}

- (StartViewModel *)startVM {
    if (!_startVM) {
        _startVM = [[StartViewModel alloc] init];
    }
    return _startVM;
}

#pragma mark - alertView
-(void)showAlertView:(NSString *)message {
    NSString *tips = message;
    if(![kNSUserDefaults boolForKey:@"isFirstStarted"]) {
        tips = @"非常抱歉，第一次启动需要保证联网，请允许手机使用网络重新加载";
    }
    [[AlertViewTool sharedInstacne] showAlertViewWithTitle:message message:@"" cancleButtonTitle:@"退出" okButtonTitle:@"重新加载" otherButtonTitleArray:@[] clickHandler:^(NSInteger index) {
        if (index == 1) {
            [self loadConfig];
        }else{
            exit(0);
        }
    }];
}

#pragma mark - 数据持久化
-(void)initLocalCache {
    //复制数据文件到library目录,保证无法通过iturns直接查看
    NSFileManager *filemanage = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSLog(@"create documents:%@",documents);
    
    //数据库目录
    NSString *homeDir = NSHomeDirectory();
    NSString *databaseDir = [homeDir stringByAppendingString:@"/Library/db/"];
    NSString *writableDBPath = [databaseDir stringByAppendingPathComponent:@"tables.db"];
    NSLog(@"create Database:%@", writableDBPath);
    BOOL exist = [filemanage fileExistsAtPath:writableDBPath];
    if (!exist) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"tables.db"];
        NSError *error;
        NSLog(@"defaultDBPath from:%@",defaultDBPath);
        NSLog(@"writableDBPath to:%@",writableDBPath);
        exist = [filemanage copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if (!exist) {
            NSLog(@"create Database error:%@",[error localizedDescription]);
        }
    }
    if(![filemanage fileExistsAtPath:databaseDir]){
        [filemanage createDirectoryAtPath:databaseDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [KDatabaseManager createDatabaseWithPath:writableDBPath];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(nonnull NSURL *)url {
    return [UMengTool application:application handleOpenURL:url];
}

#pragma mark - 推送 delegate
//iOS10新增：处理前台收到通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];

    }else{
        //应用处于前台时的本地推送接受
    }
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else {
        //应用处于后台时的本地推送接受
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
