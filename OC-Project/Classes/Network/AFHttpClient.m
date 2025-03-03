//
//  AFHttpClient.m
//  OC-Project
//
//  Created by 卢梓源 on 2020/12/17.
//

#import "AFHttpClient.h"
#import "UserInfo.h"
#import "DeviceInfo.h"
#import "ResponseStatus.h"
#import "LoginViewController.h"

#define kStatus @"200"
#define kExpiredStatus @"400"
#define kLogoutStatus @"401"
#define kTimeoutInterval 10.f


@interface AFHttpClient ()

//@property(nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation AFHttpClient

+ (instancetype)shareManger {
    /*! 为单例对象创建的静态实例，置为nil，因为对象的唯一性，必须是static类型 */
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
    });
    return manager;
}

- (void)request:(AFRequestMethod)method urlString:(NSString *)urlString parameters:(NSDictionary * __nullable)parameters success:(SuccessBlock)successBlock failure:(FailedBlock)failureBlock {
    NSString *URL = [NSString stringWithFormat:@"%@%@", BASE_URL, urlString];
    [self request:method urlString:URL parameters:parameters headers:nil success:^(id _Nullable result) {
        successBlock(result);
    } failure:^(NSError *error) {
        failureBlock(error);
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    }];
}

- (void)request:(AFRequestMethod)method urlString:(NSString*)urlString parameters:(NSDictionary *)parameters headers:(NSDictionary <NSString *, NSString *>*)headers success:(SuccessBlock)successBlock failure:(FailedBlock)failureBlock progressBlock:(ProgressBlock)progressBlock {
    //参数自定义
    NSMutableDictionary *parame = [NSMutableDictionary dictionaryWithDictionary:parameters];
    //设备信息
    [parame setObject:[DeviceInfo getUUID] forKey:@"deviceinfo"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    //header自定义
    if (![NSString isNilOrEmpty:[UserInfo getUserToken]]) {
        //token
        [manager.requestSerializer setValue:[UserInfo getUserToken] forHTTPHeaderField:@"token"];
    }
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = kTimeoutInterval;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript",@"text/plain", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"\n******************** 请求参数 ********************");
    if (![NSString isNilOrEmpty:[UserInfo getUserToken]]) {
        NSLog(@"\nURL:\n%@ \n参数:\n%@ \nToken:\n%@", urlString, parame, [UserInfo getUserToken]);
    }else
        NSLog(@"\nURL:\n%@ \n参数:\n%@", urlString, parame);
    
    if (method == GET)
    {
        [manager GET:urlString parameters:parame headers:headers progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"上传进度:%lld, 总进度:%lld",downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            //回到主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                if (progressBlock) {
                    progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
                }
            });
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject:%@",responseObject);
            successBlock(responseObject);
            /**
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                ResponseStatus *state = [ResponseStatus mj_objectWithKeyValues:responseObject];
                if ([state.status isEqualToString:kStatus]) {
                    successBlock(responseObject);
                }else if ([state.status isEqualToString:kExpiredStatus] || [state.status isEqualToString:kLogoutStatus]) {
                    [self showAlertController];
                }else {
                    NSString *domain = @"com.Tyrandear.QZMAPP.ErrorDomain";
                    NSString *desc = state.message;
                    NSDictionary *userInfo = @{NSLocalizedDescriptionKey : desc};
                    NSError *error = [NSError errorWithDomain:domain code:[state.status integerValue] userInfo:userInfo];
                    NSLog(@"error:%@",error.description);
                    failureBlock(error);
                }
            }else {
                successBlock(responseObject);
            }
            */
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error.description);
            failureBlock(error);
        }];
    }
    else if (method == POST)
    {
        [manager POST:urlString parameters:parame headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"上传进度:%lld, 总进度:%lld",uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
            //回到主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                if (progressBlock) {
                    progressBlock(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
                }
            });
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject:%@",responseObject);
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                ResponseStatus *state = [ResponseStatus mj_objectWithKeyValues:responseObject];
                if ([state.status isEqualToString:kStatus]) {
                    successBlock(responseObject);
                }else if ([state.status isEqualToString:kExpiredStatus] || [state.status isEqualToString:kLogoutStatus]) {
                    [self showAlertController];
                }else {
                    NSString *domain = @"com.Tyrandear.QZMAPP.ErrorDomain";
                    NSString *desc = state.message;
                    NSDictionary *userInfo = @{NSLocalizedDescriptionKey : desc};
                    NSError *error = [NSError errorWithDomain:domain code:[state.status integerValue] userInfo:userInfo];
                    NSLog(@"error:%@",error.description);
                    failureBlock(error);
                }
            }else {
                successBlock(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error.description);
            failureBlock(error);
        }];
    }
    else if (method == PUT)
    {
        [manager PUT:urlString parameters:parame headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject:%@",responseObject);
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                ResponseStatus *state = [ResponseStatus mj_objectWithKeyValues:responseObject];
                if ([state.status isEqualToString:kStatus]) {
                    successBlock(responseObject);
                }else if ([state.status isEqualToString:kExpiredStatus] || [state.status isEqualToString:kLogoutStatus]) {
                    [self showAlertController];
                }else {
                    NSString *domain = @"com.Tyrandear.QZMAPP.ErrorDomain";
                    NSString *desc = state.message;
                    NSDictionary *userInfo = @{NSLocalizedDescriptionKey : desc};
                    NSError *error = [NSError errorWithDomain:domain code:[state.status integerValue] userInfo:userInfo];
                    NSLog(@"error:%@",error.description);
                    failureBlock(error);
                }
            }else {
                successBlock(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error.description);
            failureBlock(error);
        }];
    }
    else if (method == DELETE)
    {
        [manager DELETE:urlString parameters:parame headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject:%@",responseObject);
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                ResponseStatus *state = [ResponseStatus mj_objectWithKeyValues:responseObject];
                if ([state.status isEqualToString:kStatus]) {
                    successBlock(responseObject);
                }else if ([state.status isEqualToString:kExpiredStatus] || [state.status isEqualToString:kLogoutStatus]) {
                    [self showAlertController];
                }else {
                    NSString *domain = @"com.Tyrandear.QZMAPP.ErrorDomain";
                    NSString *desc = state.message;
                    NSDictionary *userInfo = @{NSLocalizedDescriptionKey : desc};
                    NSError *error = [NSError errorWithDomain:domain code:[state.status integerValue] userInfo:userInfo];
                    NSLog(@"error:%@",error.description);
                    failureBlock(error);
                }
            }else {
                successBlock(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error.description);
            failureBlock(error);
        }];
    }
    else
    {
        [manager PATCH:urlString parameters:parame headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject:%@",responseObject);
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                ResponseStatus *state = [ResponseStatus mj_objectWithKeyValues:responseObject];
                if ([state.status isEqualToString:kStatus]) {
                    successBlock(responseObject);
                }else if ([state.status isEqualToString:kExpiredStatus] || [state.status isEqualToString:kLogoutStatus]) {
                    [self showAlertController];
                }else {
                    NSString *domain = @"com.Tyrandear.QZMAPP.ErrorDomain";
                    NSString *desc = state.message;
                    NSDictionary *userInfo = @{NSLocalizedDescriptionKey : desc};
                    NSError *error = [NSError errorWithDomain:domain code:[state.status integerValue] userInfo:userInfo];
                    NSLog(@"error:%@",error.description);
                    failureBlock(error);
                }
            }else {
                successBlock(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error.description);
            failureBlock(error);
        }];
    }
}

// 重新登录
- (void)showAlertController{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号身份已过期，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [UserInfo logout];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIViewController *topRootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        while (topRootViewController.presentedViewController) {
            topRootViewController = topRootViewController.presentedViewController;
        }
        LoginViewController *loginVC = [LoginViewController new];
        [topRootViewController presentViewController:loginVC animated:YES completion:nil];
    }];
    
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    
    //相当于之前的[actionSheet show];
    //兼容ipad
    if ([actionSheet respondsToSelector:@selector(popoverPresentationController)]) {
        actionSheet.popoverPresentationController.sourceView = [UIApplication sharedApplication].keyWindow.rootViewController.view; //必须加
        actionSheet.popoverPresentationController.sourceRect = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);//可选，我这里加这句代码是为了调整到合适的位置
    }
    UIViewController *topRootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [topRootViewController presentViewController:actionSheet animated:YES completion:nil];
}

+ (NSInteger)getStatusCodeWithError:(NSError *)error
{
    NSHTTPURLResponse *response = error.userInfo[@"com.alamofire.serialization.response.error.response"];
    NSInteger code = response.statusCode;
    return code;
}

+ (NSString *)getErrorMessgae:(NSError *)error
{
    NSDictionary *bodyDict = [AFHttpClient dictionaryWithJsonString:error.userInfo[@"body"]];
    NSString *message = [bodyDict valueForKey:@"message"];
    NSDictionary *errors = [bodyDict valueForKey:@"errors"];
    NSArray *strArr = [errors allValues];
    NSArray *info = strArr.firstObject;
    NSString *err = info.firstObject;
    if (![NSString isNilOrEmpty:err]) // 有具体错误信息
    {
        return err;
    }
    else if (![NSString isNilOrEmpty:message]) // 有具体错误信息
    {
        return message;
    }
    else
    {
        return @"服务器数据错误";
    }
}

// json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
