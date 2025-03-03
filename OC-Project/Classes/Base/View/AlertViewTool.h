//
//  AlertViewTool.h
//  OC-Project
//
//  Created by 梓源 on 2020/12/23.
//

#import <Foundation/Foundation.h>

// 点击的下标回调
typedef void (^AlertViewClickedIndex)(NSInteger index);
// 点击确定按钮回调
typedef void (^AlertViewOkClicked)(void);
// 点击取消按钮回调
typedef void (^AlertViewCancelClicked)(void);

NS_ASSUME_NONNULL_BEGIN

@interface AlertViewTool : NSObject

@property (nonatomic, copy) AlertViewClickedIndex buttonIndex;

+ (AlertViewTool *)sharedInstacne;

#pragma mark - 使用 UIAlertController
/**
 *  @brief 弹出提示框，AlertController可变参数版
 *
 *  @param title           标题
 *  @param message         提示信息
 *  @param cancelTitle     取消按钮文字
 *  @param confirmTitle    确定按钮文字
 *  @param confirmHandler  确定回调
 *  @param cancleHandler   取消回调
 */
+ (void)showAlertControllerWithTitle:(NSString *)title
                            mesasge:(NSString *)message
                        cancelTitle:(NSString *)cancelTitle
                       confirmTitle:(NSString *)confirmTitle
                     confirmHandler:(void(^)(UIAlertAction *action))confirmHandler
                     cancleHandler:(void(^)(UIAlertAction *action))cancleHandler;

#pragma mark - 使用 UIAlertController Sheet
/**
 *  创建菜单(Sheet 可变参数版)
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(默认@“取消”)
 *  @param confirm      点击按钮的回调
 *  @param buttonTitles 按钮
 */
+ (void)showSheetController:(NSString *)title
                    message:(NSString *)message
                cancelTitle:(NSString *)cancelTitle
               buttonTitles:(NSArray *)buttonTitles
                    confirm:(AlertViewClickedIndex)confirm;

#pragma mark - 使用 UIAlertView
/**
 *  @brief 弹出提示框，点击返回点击下标
 *
 *  @param title           标题
 *  @param msg             提示信息
 *  @param cancelTitle     取消按钮文字
 *  @param okTitle         确定按钮文字
 *  @param otherTitleArray 其他按钮文字
 *  @param handler          点击回调
 */
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)msg cancleButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle otherButtonTitleArray:(NSArray*)otherTitleArray clickHandler:(AlertViewClickedIndex)handler;
/**
 *  @brief 弹出框，没有回调.
 *
 *  @param title           标题
 *  @param msg             提示信息
 *  @param cancelTitle     取消按钮的文字
 *  @param okTitle         确定按钮的文字
 *  @param otherTitleArray 其他按钮文字
 */
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)msg cancleButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle otherButtonTitleArray:(NSArray*)otherTitleArray;


@end

NS_ASSUME_NONNULL_END
