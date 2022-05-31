//
//  XMAlertView.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/30.
//

#import "XMAlertView.h"

@interface XMAlertView() {
    /// 容器宽度
    CGFloat _contentWidth;
    /// 容器高度
    CGFloat _contentHeight;
    /// 容器左右间距
    CGFloat _contentLeftSpace;
    /// 按钮宽度
    CGFloat _btnWidth;
    /// 按钮高度
    CGFloat _btnHeight;
}

/// 容器
@property (nonatomic, strong) UIView        *contentView;
/// 蒙层
@property (nonatomic, strong) UIView        *maskView;
/// 标题label
@property (nonatomic, strong) UILabel       *titleLbl;
/// 内容label
@property (nonatomic, strong) UILabel       *contentLbl;
/// 取消按钮
@property (nonatomic, strong) UIButton      *cancelBtn;
/// 确定按钮
@property (nonatomic, strong) UIButton      *submitBtn;

@end

@implementation XMAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    [self addSubview:self.maskView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titleLbl];
    [self.contentView addSubview:self.contentLbl];
    [self.contentView addSubview:self.cancelBtn];
    [self.contentView addSubview:self.submitBtn];
    
    // 设置默认大小
    _contentLeftSpace = 30; // 容器左边距离
    _contentWidth = (kScreenWidth_XM - _contentLeftSpace*2.0);
    _contentHeight = 150; // 默认容器高度
    _btnWidth = (_contentWidth - 18 - 33*2)/2.0; // 按钮宽度
    _btnHeight = 28;
    
    return self;
}

/// 初始化
+ (XMAlertView *)initWithTitle:(NSString *)titleStr contentStr:(NSString *)contentStr cancelStr:(NSString *)cancelStr submitStr:(NSString *)submitStr {
    XMAlertView *alertV = [[XMAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth_XM, kScreenHeight_XM)];
    alertV.titleLbl.text = titleStr;
    alertV.contentLbl.text = contentStr;
    [alertV.cancelBtn setTitle:cancelStr forState:UIControlStateNormal];
    [alertV.submitBtn setTitle:submitStr forState:UIControlStateNormal];
    
    // 初始化位置
    [alertV initFrame];
    [alertV.titleLbl sizeToFit];
    [alertV.contentLbl sizeToFit];
    return alertV;
}

/// 初始化布局
- (void)initFrame {
    self.maskView.frame = CGRectMake(0, 0, kScreenWidth_XM, kScreenHeight_XM);
    self.contentView.frame = CGRectMake(_contentLeftSpace, (kScreenHeight_XM - _contentHeight)/2.0, kScreenWidth_XM - _contentLeftSpace*2.0, _contentHeight);
    self.titleLbl.frame = CGRectMake(10, 24, self.contentView.width - 20, 0);
    self.contentLbl.frame = CGRectMake(10, self.titleLbl.bottom + 18, self.contentView.width - 20, 0);
    self.cancelBtn.frame = CGRectMake(32, self.contentLbl.bottom + 24, _btnWidth, _btnHeight);
    self.submitBtn.frame = CGRectMake(self.cancelBtn.right + 18, self.cancelBtn.top, _btnWidth, _btnHeight);
}

/// 刷新布局
- (void)reloadFrame {
    self.titleLbl.frame = CGRectMake(10, 24, self.contentView.width - 20, self.titleLbl.height);
    self.contentLbl.frame = CGRectMake(10, self.titleLbl.bottom + 18, self.contentView.width - 20, self.contentLbl.height);
    self.cancelBtn.frame = CGRectMake(32, self.contentLbl.bottom + 24, _btnWidth, _btnHeight);
    self.submitBtn.frame = CGRectMake(self.cancelBtn.right + 18, self.cancelBtn.top, _btnWidth, _btnHeight);
    // 重新自适应容器的高度
    _contentHeight = self.submitBtn.bottom + 18;
    self.contentView.frame = CGRectMake(_contentLeftSpace, (kScreenHeight_XM - _contentHeight)/2.0, kScreenWidth_XM - _contentLeftSpace*2.0, _contentHeight);
}

/// 展示方法
- (void)showAction {
    if (![self superview]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    if (![self superview]) {
        [[UIApplication sharedApplication].windows.firstObject addSubview:self];
    }
    [self reloadFrame];
}

/// 隐藏方法
- (void)hiddenAction {
    [self removeFromSuperview];
    
}

/// 确定按钮点击
- (void)clickSubmitAction {
    [self hiddenAction];
}

/// 取消按钮点击
- (void)clickCancelAction {
    [self hiddenAction];
}

#pragma mark - 懒加载

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 8;
    }
    return _contentView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.5;
    }
    return _maskView;
}

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.backgroundColor = [UIColor clearColor];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        _titleLbl.textColor = [XMAlertView colorFromHexString:@"#1A1A1A"];
        _titleLbl.numberOfLines = 0;
    }
    return _titleLbl;
}

- (UILabel *)contentLbl {
    if (!_contentLbl) {
        _contentLbl = [[UILabel alloc] init];
        _contentLbl.backgroundColor = [UIColor clearColor];
        _contentLbl.textAlignment = NSTextAlignmentCenter;
        _contentLbl.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _contentLbl.textColor = [XMAlertView colorFromHexString:@"#666666"];
        _contentLbl.numberOfLines = 0;
    }
    return _contentLbl;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitleColor:[XMAlertView colorFromHexString:@"#F82C45"] forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.layer.cornerRadius = 6;
        _cancelBtn.layer.borderWidth = 1.0;
        _cancelBtn.layer.borderColor = [XMAlertView colorFromHexString:@"#F82C45"].CGColor;
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCancelAction)];
        [_cancelBtn addGestureRecognizer:tap];
    }
    return _cancelBtn;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.backgroundColor = [XMAlertView colorFromHexString:@"#F82C45"];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 6;
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSubmitAction)];
        [_submitBtn addGestureRecognizer:tap];
    }
    return _submitBtn;
}

#pragma mark - 方便的获取16进制的颜色，不引起其他类目，避免耦合性太高。

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    return [[self class] colorWithR:((rgbValue & 0xFF0000) >> 16) G:((rgbValue & 0xFF00) >> 8) B:(rgbValue & 0xFF) A:1.0];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha{
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    
    return [[self class] colorWithR:((rgbValue & 0xFF0000) >> 16) G:((rgbValue & 0xFF00) >> 8) B:(rgbValue & 0xFF) A:alpha];
}

#pragma mark - RGBA Helper method
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha {
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}


@end
