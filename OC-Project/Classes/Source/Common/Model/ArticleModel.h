//
//  ArticleModel.h
//  OC-Project
//
//  Created by 梓源 on 2021/1/11.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArticleModel : BaseModel

@property (nonatomic, assign) NSInteger fileId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *shortTitle;
@property (nonatomic, strong) NSString *picBig;

@end

NS_ASSUME_NONNULL_END
