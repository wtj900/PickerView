//
//  OWXBasePickerView.m
//  pickerView
//
//  Created by 王史超 on 2019/1/17.
//  Copyright © 2019 offcn. All rights reserved.
//

#import "OWXBasePickerView.h"

@implementation OWXBasePickerView

- (void)initUI {
    
    self.frame = SCREEN_BOUNDS;
    // 背景遮罩图层
    [self addSubview:self.backgroundView];
    // 弹出视图
    [self addSubview:self.alertView];
    // 添加顶部标题栏
    [self.alertView addSubview:self.topView];
    // 添加中间标题按钮
    [self.topView addSubview:self.titleLabel];
}

#pragma mark - 背景遮罩图层
- (UIView *)backgroundView {
    
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:SCREEN_BOUNDS];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.20];
        _backgroundView.userInteractionEnabled = YES;
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapBackgroundView:)];
        [_backgroundView addGestureRecognizer:myTap];
    }
    return _backgroundView;
}

#pragma mark - 弹出视图
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kTopViewHeight - kPickerHeight, SCREEN_WIDTH, kTopViewHeight + kPickerHeight)];
        _alertView.backgroundColor = [UIColor whiteColor];
    }
    return _alertView;
}

#pragma mark - 顶部标题栏视图
- (UIView *)topView {
    if (!_topView) {
        _topView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kTopViewHeight)];
        [_topView.layer addSublayer:self.separator];
    }
    return _topView;
}

#pragma mark - 分隔线
- (CALayer *)separator {
    if (!_separator) {
        _separator = [CALayer layer];
        _separator.frame = CGRectMake(0, kTopViewHeight - 1, SCREEN_WIDTH, 1);
        _separator.backgroundColor = RGB_HEX(0xEEEEEE, 1).CGColor;
    }
    return _separator;
}

#pragma mark - 中间标题按钮
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, SCREEN_WIDTH - 130, kTopViewHeight)];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = [UIColor redColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark - 点击背景遮罩图层事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    
}

@end
