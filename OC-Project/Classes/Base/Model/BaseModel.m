//
//  BaseModel.m
//  OC-Project
//
//  Created by 梓源 on 2020/12/23.
//

#import "BaseModel.h"

@implementation BaseModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"m_id": @"id"};
}

@end
