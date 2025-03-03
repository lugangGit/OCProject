//
//  UIColor+Category.h
//  iOS-Category
//
//  Created by MacBook on 2017/8/23.
//  Copyright © 2017年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

//从十六进制字符串获取颜色
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)randomColor;

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;

//以#开头
+ (instancetype)colorWithHexRGBA:(NSString *)rgba;

+ (instancetype)colorWithHexRGB:(NSString *)rgb;

+ (instancetype)colorWithHexARGB:(NSString *)argb;

@end
