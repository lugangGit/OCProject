//
//  HomeViewModel.m
//  OC-Project
//
//  Created by 梓源 on 2021/1/8.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.bannerArray = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

- (void)loadArticlesWithColumnId:(int)columnId lastFileId:(int)lastFileId completionHandler:(CompletionHandler)completionHandler {
    NSString *urlString = [NSString stringWithFormat:@"/getArticles?columnId=%d&lastFileId=%d&page=%ld&version=0&adv=1&appID=1&siteId=1", columnId, lastFileId, (long)self.pageModel.current_page];
    [[AFHttpClient shareManger] request:GET urlString:urlString parameters:nil success:^(id  _Nullable result) {
        NSLog(@"%@", result);
        if (self.pageModel.current_page == 0) {
            [self.dataArray removeAllObjects];
        }
//        self.pageModel.total = [result[@"total"] intValue];
        if ([self isKindOfDictionary:result]) {
            //轮播
            if ([self isKindOfArrary:result[@"carousel"]]) {
                for (NSDictionary *dict in result[@"carousel"]) {
                    ArticleModel *model = [ArticleModel mj_objectWithKeyValues:dict];
                    [self.bannerArray addObject:model];
                }
            }
            //列表
            if ([self isKindOfArrary:result[@"list"]]) {
                for (NSDictionary *dict in result[@"list"]) {
                    ArticleModel *model = [ArticleModel mj_objectWithKeyValues:dict];
                    [self.dataArray addObject:model];
                }
            }
        }
        completionHandler(YES, nil, nil);
    } failure:^(NSError * _Nullable error) {
        NSLog(@"%ld", (long)error.code);
        NSLog(@"%@", error.description);
        completionHandler(NO, error.description, nil);
    }];
}


@end
