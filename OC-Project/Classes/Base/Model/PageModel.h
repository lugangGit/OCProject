//
//  PageModel.h
//  OC-Project
//
//  Created by 梓源 on 2020/12/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageModel : NSObject

/** 当前页数 */
@property (nonatomic, assign) NSInteger current_page;
/** 总条数 */
@property (nonatomic, assign) NSInteger total;

/** 步长 */
@property (nonatomic, assign) NSString *per_page;
/** 个数 */
@property (nonatomic, assign) NSString *count;
/** 总共页数 */
@property (nonatomic, assign) NSString *total_pages;

@end

NS_ASSUME_NONNULL_END
