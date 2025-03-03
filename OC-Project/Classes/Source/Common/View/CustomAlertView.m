//
//  CustomAlertView.m
//  OC-Project
//
//  Created by 梓源 on 2021/1/15.
//

#import "CustomAlertView.h"

@interface CustomAlertView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIView *vLine;
@end

@implementation CustomAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorTransparent;
        [self createUI];
    }
    return self;
}

#pragma mark - 创建UI
- (void)createUI {
    [self addSubview:self.bgView];

    [self.bgView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40*kSproportion);
        make.right.mas_equalTo(-40*kSproportion);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25*kSproportion);
        make.right.mas_equalTo(-25*kSproportion);
        make.top.equalTo(self.contentLabel.mas_top).offset(-85*kSproportion);
        make.bottom.equalTo(self.contentLabel.mas_bottom).offset(65*kSproportion);
    }];
    
    [self.bgView addSubview:self.topLine];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*kSproportion);
        make.right.mas_equalTo(-15*kSproportion);
        make.bottom.equalTo(self.contentLabel.mas_top).offset(-25*kSproportion);
        make.height.mas_equalTo(1*kSproportion);
    }];
    
    [self.bgView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*kSproportion);
        make.right.mas_equalTo(-15*kSproportion);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(25*kSproportion);
        make.height.mas_equalTo(1*kSproportion);
    }];
    
    [self.bgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25*kSproportion);
        make.right.mas_equalTo(-25*kSproportion);
        make.height.mas_equalTo(60*kSproportion);
    }];
    
    [self.bgView addSubview:self.vLine];
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLine.mas_bottom).offset(0);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(1*kSproportion);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(0);
    }];
    
    [self.bgView addSubview:self.leftButton];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLine.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.right.equalTo(self.vLine.mas_left).offset(0);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(0);
    }];
    
    [self.bgView addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLine.mas_bottom).offset(0);
        make.right.mas_equalTo(0);
        make.left.equalTo(self.vLine.mas_right).offset(0);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(0);
    }];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = _title;
    // 刷新布局
    [self layoutIfNeeded];
}

- (void)setContent:(NSString *)content {
    _content = content;
    self.contentLabel.text = _content;
}

- (void)setBtnLeftTitle:(NSString *)btnLeftTitle {
    
}

#pragma mark - 点击事件
- (void)clickBtn:(UIButton *)sender {
    self.hidden = YES;
    if (self.callback) {
        switch (sender.tag) {
            case 100:
            {
                self.callback(NO);
            }
                break;
            case 101:
            {
                self.callback(YES);
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark - lazy
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kColorBackground;
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"提示";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 1;
        _titleLabel.font = [UIFont systemFontOfSize:15*kSproportion weight:0.2];
        _titleLabel.textColor = kColorTitle1;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:14*kSproportion];
        _contentLabel.textColor = kColorTitle2;
    }
    return _contentLabel;
}

- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = kColorLine;
    }
    return _topLine;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = kColorLine;
    }
    return _bottomLine;
}

- (UIView *)vLine {
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = kColorLine;
    }
    return _vLine;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:15*kSproportion];
        [_leftButton setTitle:@"取消" forState:UIControlStateNormal];
        [_leftButton setTitleColor:kColorTitle2 forState:UIControlStateNormal];
        _leftButton.tag = 100;
        [_leftButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:15*kSproportion];
        [_rightButton setTitle:@"确定" forState:UIControlStateNormal];
        _rightButton.tag = 101;
        [_rightButton setTitleColor:kColorPrimary forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
