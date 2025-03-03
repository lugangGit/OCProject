//
//  BaseViewModel.m
//  OC-Project
//
//  Created by 梓源 on 2021/1/8.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataArray = [NSMutableArray arrayWithCapacity:10];
        self.pageModel = [[PageModel alloc] init];
    }
    return self;
}

- (BOOL)isKindOfDictionary:(id)obj {
    if (obj && [obj isKindOfClass:[NSDictionary class]]) return YES;
    return NO;
}

- (BOOL)isKindOfArrary:(id)obj {
    if (obj && [obj isKindOfClass:[NSArray class]]) return YES;
    return NO;
}

- (BOOL)isKindOfString:(id)obj {
    if (obj && [obj isKindOfClass:[NSString class]]) return YES;
    return NO;
}

@end
