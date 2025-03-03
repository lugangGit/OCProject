//
//  DatabaseManager.h
//  OC-Project
//
//  Created by 梓源 on 2020/12/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DatabaseManager : NSObject

+ (instancetype)sharedDatabase;

/// 创建数据库
/// @param path 路径
- (void)createDatabaseWithPath:(NSString *)path;

/// 创建表
/// @param tableName 表名
- (void)creatTable:(NSString *)tableName;

#pragma mark - 搜索历史
- (void)addSearchHistoryWithKeyword:(NSString *)keyword type:(NSString *)type;

- (NSMutableArray *)getSearchHistoryWithType:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
