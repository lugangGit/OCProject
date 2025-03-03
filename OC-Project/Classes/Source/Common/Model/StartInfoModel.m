//
//  StartInfoModel.m
//  OC-Project
//
//  Created by 梓源 on 2020/12/23.
//

#import "StartInfoModel.h"

@implementation StartInfoModel

+ (instancetype)shareStartInfo {
    static StartInfoModel *start;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        start = [[self alloc] init];
    });
    return start;
}

- (void)configWithDictionary:(NSDictionary *)dict
{
    if (dict == nil && ![dict isKindOfClass:[NSDictionary class]])
        return;
    self.siteID = [[dict objectForKey:@"siteID"] intValue];
    self.privacyPolicyType = [[dict objectForKey:@"privacyPolicyType"] intValue];
    self.privacyPolicyUrl = [dict objectForKey:@"privacyPolicyUrl"];
    self.privacyPolicyHtml = [dict objectForKey:@"privacyPolicyHtml"];
    self.setGrey = [[dict objectForKey:@"setGrey"] intValue];
    self.ssoUrl = [dict objectForKey:@"ssoUrl"];
    self.version = [dict objectForKey:@"version"];
}
@end
