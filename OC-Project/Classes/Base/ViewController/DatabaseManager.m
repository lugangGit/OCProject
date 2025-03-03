//
//  DatabaseManager.m
//  OC-Project
//
//  Created by 梓源 on 2020/12/24.
//

#import "DatabaseManager.h"
#import <FMDB.h>

//static FMDatabase *db = nil;
//static FMDatabaseQueue *queue = nil;
static DatabaseManager *manager = nil;

@interface DatabaseManager() <NSCopying,NSMutableCopying> {
    FMDatabase  *_db;
    FMDatabaseQueue *_queue;
}
@end

@implementation DatabaseManager

+ (instancetype)sharedDatabase {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DatabaseManager alloc] init];
    });
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (manager == nil) {
        manager = [super allocWithZone:zone];
    }
    return manager;
}

- (id)copy {
    return self;
}

- (id)mutableCopy {
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return self;
}

/// 创建数据库
- (void)createDatabaseWithPath:(NSString *)path {
    _db = [FMDatabase databaseWithPath:path];
}

/// 创建表
- (void)creatTable:(NSString *)tableName {
    //打开数据库
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat: @"create table IF NOT EXISTS %@ (keyword text, type text, username text, addTime datetime, PRIMARY KEY(keyword, type))", tableName];
//       NSString *sql = [NSString stringWithFormat:@"create table if not exists %@('ID' INTEGER PRIMARY KEY AUTOINCREMENT , 'name' TEXT NOT NULL, 'phone' TEXT NOT NULL, 'score' TEXT NOT NULL)", tableName];
       BOOL result = [_db executeUpdate:sql];
       if (result) {
           NSLog(@"创建成功");
       }else{
           NSLog(@"创建失败");
       }
    }else {
        NSLog(@"打开失败");
    }
    [_db close];
}

#pragma mark - 搜索历史
- (void)addSearchHistoryWithKeyword:(NSString *)keyword type:(NSString *)type {
    [_db open];
    NSString *sql1 = @"replace into SearchHistory(keyword, type, addTime) VALUES (?,?,?)";
    [_db executeUpdate:sql1,keyword,type,[NSDate date]];
    [_db close];
}

- (NSMutableArray *)getSearchHistoryWithType:(NSString *)type {
    [_db open];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    NSString *sql;
    if (![type isNotEmpty]) {
        sql = @"select *from SearchHistory where type !=? and type !=? order by addTime desc";
        FMResultSet *res = [_db executeQuery:sql, @"", @""];
        while ([res next]) {
            NSString * keyStr = [res stringForColumn:@"keyword"];
            if (![keyStr isNotEmpty]) {
                keyStr = @"";
            }
            [temp addObject:keyStr];
        }
    }else{
        sql = @"select *from SearchHistory where type =? order by addTime desc";
        FMResultSet *res = [_db executeQuery:sql,type];
        while ([res next]) {
            NSString * keyStr = [res stringForColumn:@"keyword"];
            if (![keyStr isNotEmpty]) {
                keyStr = @"";
            }
            [temp addObject:keyStr];
        }
    }
    [_db close];
    
    return temp;
}

- (void)deleteSearchHistoryWithType:(NSString *)type {
    [_db open];
    if ([type isNotEmpty]) {
        NSString *sql = @"delete from SearchHistory where type = ?";
        [_db executeUpdate:sql,type];
    }else {
        NSString *sql = @"delete from SearchHistory where type = ? or type = ? or type = ? or type = ?";
        [_db executeUpdate:sql,type,@"",@"",@""];
    }
    [_db close];
}

@end
