//
//  BaseViewModel.h
//  OC-Project
//
//  Created by 梓源 on 2021/1/8.
//

#import "BaseModel.h"
#import "PageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewModel : BaseModel
/// 分页model
@property (nonatomic, strong) PageModel *pageModel;
/// 数据数组
@property (nonatomic,strong) NSMutableArray *dataArray;

/// 判断字典
- (BOOL)isKindOfDictionary:(id)obj;
/// 判断数组
- (BOOL)isKindOfArrary:(id)obj;
/// 判断字符串
- (BOOL)isKindOfString:(id)obj;

@end

NS_ASSUME_NONNULL_END
