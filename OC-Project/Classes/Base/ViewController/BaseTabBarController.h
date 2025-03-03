//
//  BaseTabBarController.h
//  OC-Project
//
//  Created by 卢梓源 on 2020/12/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTabBarController : UITabBarController

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) NSMutableArray *channelArray;

- (void)createTabBarItem:(NSMutableArray*)channelArray;

@end

NS_ASSUME_NONNULL_END
