//
//  StartViewModel.m
//  OC-Project
//
//  Created by 梓源 on 2020/12/23.
//

#import "StartViewModel.h"
#import "ColumnModel.h"

@implementation StartViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.channelArray = [NSMutableArray arrayWithCapacity:5];
    }
    return self;
}

- (void)loadConfig:(CompletionHandler)completionHandler {
    NSString *urlString = [NSString stringWithFormat:@"/getConfig?appID=%@", appId];
    [[AFHttpClient shareManger] request:GET urlString:urlString parameters:nil success:^(id  _Nullable result) {
        if ([self isKindOfDictionary:result]) {
            [[StartInfoModel shareStartInfo] configWithDictionary:result];
        }
        completionHandler(YES, nil, nil);
    } failure:^(NSError * _Nullable error) {
        completionHandler(NO, error.localizedDescription, nil);
    }];
}

- (void)loadChannelsWithColumnId:(int)columnId completionHandler:(CompletionHandler)completionHandler {
    NSString *urlString = [NSString stringWithFormat:@"/getColumns?siteId=%ld&parentColumnId=%d&version=0&columnType=-1", (long)[StartInfoModel shareStartInfo].siteID, columnId];
    [[AFHttpClient shareManger] request:GET urlString:urlString parameters:nil success:^(id  _Nullable result) {
        if ([self isKindOfDictionary:result]) {
            if ([self isKindOfArrary:result[@"columns"]]) {
                NSArray *dataArr = result[@"columns"];
                self.channelArray = [ColumnModel mj_objectArrayWithKeyValuesArray:dataArr];
//                for (NSDictionary *dic in dataArr) {
//                    ColumnModel *model = [ColumnModel mj_objectWithKeyValues:dic];
//                    [self.channelArray addObject:model];
//                }
            }
        }
        completionHandler(YES, nil, nil);
    } failure:^(NSError * _Nullable error) {
        completionHandler(NO, error.localizedDescription, nil);
    }];
}

@end
