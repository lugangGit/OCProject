//
//  SplashViewController.h
//  OC-Project
//
//  Created by 梓源 on 2021/1/11.
//

#import "BaseViewController.h"

@protocol SplashDelegate <NSObject>
@required
- (void)splashDidFinished:(NSInteger)index;
@optional
-(void)showStartPageDetailPage;
@end

NS_ASSUME_NONNULL_BEGIN

@interface SplashViewController : BaseViewController

@property (nonatomic, weak) id<SplashDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
