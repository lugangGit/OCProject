//
//  StartViewModel.h
//  OC-Project
//
//  Created by 梓源 on 2020/12/23.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StartViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *channelArray;

/// 获取getConfig接口
/// @param completionHandler 回调
- (void)loadConfig:(CompletionHandler)completionHandler;


/// 获取getConfig接口
/// @param columnId 栏目ID
/// @param completionHandler 回调
- (void)loadChannelsWithColumnId:(int)columnId completionHandler:(CompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
