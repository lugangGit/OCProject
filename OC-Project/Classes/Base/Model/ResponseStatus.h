//
//  ResponseStatus.h
//  OC-Project
//
//  Created by 卢梓源 on 2020/12/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResponseStatus : NSObject

@property (nonatomic ,strong) NSString *status;

@property (nonatomic ,strong) NSString *message;

@end

NS_ASSUME_NONNULL_END
