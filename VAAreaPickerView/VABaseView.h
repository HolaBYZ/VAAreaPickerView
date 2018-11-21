//
//  VABaseView.h
//  NTAvatar
//
//  Created by 栗子哇 on 2018/11/8.
//  Copyright © 2018 NineTonTech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VABaseView : UIView

// 背景视图
@property (nonatomic, strong) UIView *backgroundView;
// 弹出视图
@property (nonatomic, strong) UIView *alertView;
// 顶部视图
@property (nonatomic, strong) UIView *topView;
// 左边取消按钮
@property (nonatomic, strong) UIButton *leftBtn;
// 右边确定按钮
@property (nonatomic, strong) UIButton *rightBtn;
// 中间标题
@property (nonatomic, strong) UILabel *titleLabel;
// 分割线视图
@property (nonatomic, strong) UIView *lineView;

/** 初始化子视图 */
- (void)initUI;

/** 点击背景遮罩图层事件 */
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender;

/** 取消按钮的点击事件 */
- (void)clickLeftBtn;

/** 确定按钮的点击事件 */
- (void)clickRightBtn;

/** 自定义主题颜色 */
- (void)setupThemeColor:(UIColor *)themeColor;

@end

NS_ASSUME_NONNULL_END
