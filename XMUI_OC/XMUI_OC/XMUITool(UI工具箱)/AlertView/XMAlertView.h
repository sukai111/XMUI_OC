//
//  XMAlertView.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 自定义AlertView
@interface XMAlertView : UIView

/// 初始化
+ (XMAlertView *)initWithTitle:(nullable NSString *)titleStr contentStr:(nullable NSString *)contentStr cancelStr:(nullable NSString *)cancelStr submitStr:(nullable NSString *)submitStr;

- (void)showAction;

@end

NS_ASSUME_NONNULL_END
