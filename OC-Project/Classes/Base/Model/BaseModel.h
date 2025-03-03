//
//  BaseModel.h
//  OC-Project
//
//  Created by 梓源 on 2020/12/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject

@property (nonatomic, strong) NSString *m_id;
@property (nonatomic, assign) CGFloat m_x;
@property (nonatomic, assign) CGFloat m_y;
@property (nonatomic, assign) CGFloat m_height;
@property (nonatomic, assign) CGFloat m_width;

@end

NS_ASSUME_NONNULL_END
