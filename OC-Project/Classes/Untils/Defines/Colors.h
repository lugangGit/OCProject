//
//  Colors.h
//  OC-Project
//
//  Created by 卢梓源 on 2020/12/17.
//

#ifndef Colors_h
#define Colors_h

/// 判断夜间模式
#define kDarkMode @available(iOS 13.0, *) && UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark

/// 颜色转换
#define kColorRGBA(r, g, b, a)  [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]
#define kColorRGB(r, g, b)  kColorRGBA(r, g, b, 1.0)

#define kColorHEXA(hex, a)  kColorRGBA(((float)((hex & 0xFF0000) >> 16)), ((float)((hex & 0xFF00) >> 8)), ((float)(hex & 0xFF)), a)
//#define kColorHEX(hex)  kColorHEXA(hex, 1.0)
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
#define kColorHEX(hexString)  [UIColor colorWithHexString:hexString]

#define kColorRandom  kColorRGB(arc4random() % 255, arc4random() % 255, arc4random() % 255)
#define kColorGray(v)  kColorRGB(v, v, v)

#define kColorClear  [UIColor clearColor]
#define kColorWhite  [UIColor whiteColor]
#define kColorGray   [UIColor grayColor]
#define kColorBlack  [UIColor blackColor]
#define kColorRed    [UIColor redColor]

/// 主色调
#define kColorPrimary  [UIColor colorWithRed:95/255.0f green:207/255.0f blue:250/255.0f alpha:1]
/// 标题黑色
#define kColorTitle1  [UIColor colorWithRed:29/255.0f green:30/255.0f blue:32/255.0f alpha:1]
/// 副标题
#define kColorTitle2  [UIColor colorWithRed:160/255.0f green:161/255.0f blue:164/255.0f alpha:1]
/// 分割线
#define kColorLine  [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]
/// 半透明
#define kColorTransparent  [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.7]
/// 背景色
#define kColorBackground  [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1]

#endif /* Colors_h */
