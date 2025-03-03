//
//  SplashScrollView.h
//  OC-Project
//
//  Created by 梓源 on 2021/1/15.
//

#import <UIKit/UIKit.h>
@protocol SplashScrollViewDelegate <NSObject>
@required
- (void)splashScrollView:(NSInteger)index;
@end
NS_ASSUME_NONNULL_BEGIN

@interface SplashScrollView : UIView

@property (nonatomic, weak) id<SplashScrollViewDelegate> delegate;

-(void)updataScrollView:(id)model;

@end

NS_ASSUME_NONNULL_END
