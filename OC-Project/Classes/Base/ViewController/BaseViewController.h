//
//  BaseViewController.h
//  OC-Project
//
//  Created by 卢梓源 on 2020/12/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController


/// 导航左侧标题图
/// @param title 文字
/// @param imageName 图片名称
- (void)setNavRightItemTitle:(NSString *)title imageName:(NSString *)imageName;

/// loading框
- (void)showLoading;

- (void)hideLoading;

- (void)showMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
