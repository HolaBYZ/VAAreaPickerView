//
//  VABaseView.m
//  NTAvatar
//
//  Created by 栗子哇 on 2018/11/8.
//  Copyright © 2018 NineTonTech. All rights reserved.
//

#import "VABaseView.h"


@implementation VABaseView

- (void)initUI {
    self.frame = NTScreenBounds();
    // 设置子视图的宽度随着父视图变化
    self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    // 背景遮罩图层
    [self addSubview:self.backgroundView];
    // 弹出视图
    [self addSubview:self.alertView];
    // 设置弹出视图子视图
    // 添加顶部标题栏
    [self.alertView addSubview:self.topView];
    // 添加左边取消按钮
    [self.topView addSubview:self.leftBtn];
    // 添加中间标题按钮
    [self.topView addSubview:self.titleLabel];
    // 添加右边确定按钮
    [self.topView addSubview:self.rightBtn];
    // 添加分割线
    [self.topView addSubview:self.lineView];
}

#pragma mark - 背景遮罩图层
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:NTScreenBounds()];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2f];
        // 设置子视图的大小随着父视图变化
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backgroundView.userInteractionEnabled = YES;
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapBackgroundView:)];
        [_backgroundView addGestureRecognizer:myTap];
    }
    return _backgroundView;
}

#pragma mark - 弹出视图
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height - kTopViewHeight - kPickerHeight - VA_BOTTOM_MARGIN, Screen_Width, kTopViewHeight + kPickerHeight + VA_BOTTOM_MARGIN)];
        _alertView.backgroundColor = [UIColor whiteColor];
        // 设置子视图的大小随着父视图变化
        _alertView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    }
    return _alertView;
}

#pragma mark - 顶部标题栏视图
- (UIView *)topView {
    if (!_topView) {
        _topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.alertView.frame.size.width, kTopViewHeight + 0.5)];
        _topView.backgroundColor = VAToolBarColor;
        // 设置子视图的大小随着父视图变化
        _topView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    }
    return _topView;
}

#pragma mark - 左边取消按钮
- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(5, 8, 60, 28);
        _leftBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f * kScaleFit];
        [_leftBtn setTitleColor:NT_HEX(#333333) forState:UIControlStateNormal];
        [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

#pragma mark - 右边确定按钮
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(self.alertView.frame.size.width - 65, 8, 60, 28);
        _rightBtn.layer.backgroundColor = NT_HEX(#FFDF00).CGColor;
        _rightBtn.layer.cornerRadius = 4.;
        _rightBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f * kScaleFit];
        [_rightBtn setTitleColor:NT_HEX(#333333) forState:UIControlStateNormal];
        [_rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

#pragma mark - 中间标题按钮
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.leftBtn.frame.origin.x + self.leftBtn.frame.size.width + 2, 0, self.alertView.frame.size.width - 2 * (self.leftBtn.frame.origin.x + self.leftBtn.frame.size.width + 2), kTopViewHeight)];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
        _titleLabel.font = [UIFont systemFontOfSize:14.0f * kScaleFit];
        _titleLabel.textColor = [NT_HEX(#333333) colorWithAlphaComponent:0.8f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark - 分割线
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kTopViewHeight, self.alertView.frame.size.width, 0.5)];
        _lineView.backgroundColor = NT_HEXA(0xf1f1f1, 1.0f);
        _lineView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        [self.alertView addSubview:_lineView];
    }
    return _lineView;
}

#pragma mark - 点击背景遮罩图层事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    
}

#pragma mark - 取消按钮的点击事件
- (void)clickLeftBtn {
    
}

#pragma mark - 确定按钮的点击事件
- (void)clickRightBtn {
    
}

#pragma mark - 自定义主题颜色
- (void)setupThemeColor:(UIColor *)themeColor {
    self.leftBtn.layer.cornerRadius = 6.0f;
    self.leftBtn.layer.borderColor = themeColor.CGColor;
    self.leftBtn.layer.borderWidth = 1.0f;
    self.leftBtn.layer.masksToBounds = YES;
    [self.leftBtn setTitleColor:themeColor forState:UIControlStateNormal];
    
    self.rightBtn.backgroundColor = themeColor;
    self.rightBtn.layer.cornerRadius = 6.0f;
    self.rightBtn.layer.masksToBounds = YES;
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.titleLabel.textColor = [themeColor colorWithAlphaComponent:0.8f];
}

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

@end
