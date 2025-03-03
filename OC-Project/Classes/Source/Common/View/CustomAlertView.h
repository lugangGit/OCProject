//
//  CustomAlertView.h
//  OC-Project
//
//  Created by 梓源 on 2021/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomAlertView : UIView
@property (nonatomic, copy) CallBackBool callback;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@end

NS_ASSUME_NONNULL_END
