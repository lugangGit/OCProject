//
//  StartInfoModel.h
//  OC-Project
//
//  Created by 梓源 on 2020/12/23.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StartInfoModel : BaseModel
/// siteID
@property (nonatomic, assign) int siteID;
/// 一键置灰
@property (nonatomic, assign) int setGrey;
/// 版本
@property (nonatomic, copy) NSString *version;
/// 用户隐私协议
@property (nonatomic, assign) NSInteger privacyPolicyType;
@property (nonatomic, copy) NSString *privacyPolicyHtml;
@property (nonatomic, copy) NSString *privacyPolicyUrl;
/// sso
@property (nonatomic, copy) NSString *ssoUrl;

+ (instancetype)shareStartInfo;

- (void)configWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
