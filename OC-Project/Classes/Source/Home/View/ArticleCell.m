//
//  ArticleCell.m
//  OC-Project
//
//  Created by 梓源 on 2021/1/11.
//

#import "ArticleCell.h"
#import "ArticleModel.h"

@interface ArticleCell ()
/// view
@property (nonatomic, strong) UIView *bgView;
/// 线
@property (nonatomic, strong) UIView *lineView;
/// 图片
@property (nonatomic, strong) UIImageView *newsImageView;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ArticleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kColorWhite;
        self.contentView.backgroundColor = kColorWhite;
    }
    return self;
}

- (void)createUI {
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.contentView addSubview:self.newsImageView];
    [self.newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(75);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.equalTo(self.newsImageView.mas_right).offset(15);
        make.right.mas_equalTo(-15);
    }];
}

- (void)updateWithModel:(id)model {
    ArticleModel *article = (ArticleModel *)model;
    self.titleLabel.text = article.title;
    [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:article.picBig] placeholderImage:[UIImage imageNamed:@""]];
}

#pragma mark - 懒加载
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kColorWhite;
    }
    return _bgView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kColorLine;
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = kColorTitle1;
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UIImageView *)newsImageView {
    if (!_newsImageView) {
        _newsImageView = [[UIImageView alloc]init];
        _newsImageView.image = [UIImage imageNamed:@"img_placeholder"];
        _newsImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _newsImageView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
