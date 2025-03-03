//
//  HomeViewModel.h
//  OC-Project
//
//  Created by 梓源 on 2021/1/8.
//

#import "BaseViewModel.h"
#import "ArticleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : BaseViewModel

/// 轮播数组
@property (nonatomic,strong) NSMutableArray *bannerArray;

- (void)loadArticlesWithColumnId:(int)columnId lastFileId:(int)lastFileId completionHandler:(CompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
