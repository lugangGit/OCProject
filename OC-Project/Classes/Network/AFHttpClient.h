//
//  AFHttpClient.h
//  OC-Project
//
//  Created by 卢梓源 on 2020/12/17.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    GET = 1,
    POST,
    PUT,
    DELETE,
    PATCH
} AFRequestMethod;

/// 成功时调用的Block
typedef void (^SuccessBlock)(id _Nullable result);
/// 失败时调用的Block
typedef void (^FailedBlock)(NSError * _Nullable error);
/// 进度调用的Block
typedef void(^ProgressBlock)(int64_t bytesProgress, int64_t totalBytesProgress);

NS_ASSUME_NONNULL_BEGIN

@interface AFHttpClient : NSObject

+ (instancetype)shareManger;

/// 网络请求
/// @param method 请求方式
/// @param urlString 请求地址
/// @param parameters 参数
/// @param successBlock 成功
/// @param failureBlock 失败
- (void)request:(AFRequestMethod)method urlString:(NSString * __nullable)urlString parameters:(NSDictionary * __nullable)parameters success:(SuccessBlock)successBlock failure:(FailedBlock)failureBlock;


/// 网络请求（带header参数）
/// @param method 请求方式
/// @param urlString 请求地址
/// @param parameters 参数
/// @param headers 带header参数
/// @param successBlock 成功
/// @param failureBlock 失败
/// @param progressBlock 进度
- (void)request:(AFRequestMethod)method urlString:(NSString*)urlString parameters:(NSDictionary *)parameters headers:(NSDictionary <NSString *, NSString *> *)headers success:(SuccessBlock)successBlock failure:(FailedBlock)failureBlock progressBlock:(ProgressBlock)progressBlock;

@end

NS_ASSUME_NONNULL_END
