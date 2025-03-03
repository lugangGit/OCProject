//
//  AlertViewTool.m
//  OC-Project
//
//  Created by 梓源 on 2020/12/23.
//

#import "AlertViewTool.h"

#define RootVC  [UIApplication sharedApplication].delegate.window.rootViewController

@implementation AlertViewTool

+ (AlertViewTool *)sharedInstacne {
    static AlertViewTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)showAlertControllerWithTitle:(NSString *)title
                            mesasge:(NSString *)message
                        cancelTitle:(NSString *)cancelTitle
                       confirmTitle:(NSString *)confirmTitle
                     confirmHandler:(void(^)(UIAlertAction *action))confirmHandler
                      cancleHandler:(void(^)(UIAlertAction *action))cancleHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    if (cancelTitle.length > 0 || (confirmTitle.length == 0 && cancelTitle.length == 0)) {
        NSString *title = cancelTitle.length > 0?cancelTitle:@"取消";
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:cancleHandler];
        [alertController addAction:cancleAction];
    }
    
    if (confirmTitle.length > 0) {
      UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:confirmHandler];
      [alertController addAction:confirmAction];
    }

    [RootVC presentViewController:alertController animated:YES completion:nil];
}

+ (void)showSheetController:(NSString *)title
                    message:(NSString *)message
                cancelTitle:(NSString *)cancelTitle
               buttonTitles:(NSArray *)buttonTitles
                    confirm:(AlertViewClickedIndex)confirm {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];

    NSString *ctitle = cancelTitle.length > 0?cancelTitle:@"取消";
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:ctitle style:UIAlertActionStyleCancel handler:nil];
    [sheet addAction:cancleAction];

    if (buttonTitles.count > 0) {
        for (NSInteger i = 0; i < buttonTitles.count; i++) {
            UIAlertAction  *action = [UIAlertAction actionWithTitle:buttonTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (confirm)confirm(i);
            }];
            [sheet addAction:action];
        }
    }
    [RootVC presentViewController:sheet animated:YES completion:nil];
}

- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)msg
             cancleButtonTitle:(NSString *)cancelTitle
                 okButtonTitle:(NSString *)okTitle
         otherButtonTitleArray:(NSArray *)otherTitleArray
                   clickHandler:(AlertViewClickedIndex)handler {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:handler ? self : nil cancelButtonTitle:cancelTitle otherButtonTitles:okTitle, nil];
    for (NSString *otherTitle in otherTitleArray) {
        [alert addButtonWithTitle:otherTitle];
    }
    self.buttonIndex = handler;
    [alert show];
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)msg cancleButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle otherButtonTitleArray:(NSArray*)otherTitleArray {
    [self showAlertViewWithTitle:title message:msg cancleButtonTitle:cancelTitle okButtonTitle:okTitle otherButtonTitleArray:otherTitleArray clickHandler:nil];
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.buttonIndex) {
        self.buttonIndex(buttonIndex);
    }
}

@end
