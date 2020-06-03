//
//  SettingCell.m
//中车运
//
//  Created by 隋林栋 on 2018/10/16.
//Copyright © 2018年 ping. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell
#pragma mark 懒加载
- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [UIImageView new];
        _icon.widthHeight = XY(W(18),W(18));
    }
    return _icon;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
    }
    return _labelTitle;
}
- (UILabel *)subTitle{
    if (_subTitle == nil) {
        _subTitle = [UILabel new];
        _subTitle.textColor = COLOR_666;
        _subTitle.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _subTitle.numberOfLines = 0;
        _subTitle.lineSpace = 0;
    }
    return _subTitle;
}
- (UILabel *)labelAlert{
    if (!_labelAlert) {
        _labelAlert = [UILabel new];
        _labelAlert.hidden = true;
    }
    return _labelAlert;
}
- (UIImageView *)arrow{
    if (_arrow == nil) {
        _arrow = [UIImageView new];
        _arrow.image = [UIImage imageNamed:@"setting_RightArrow"];
        _arrow.widthHeight = XY(W(25),W(25));
    }
    return _arrow;
}
- (UIView *)line{
    if (_line == nil) {
        _line = [UIView new];
        _line.backgroundColor = COLOR_LINE;
        _line.widthHeight = XY(SCREEN_WIDTH , 1);
    }
    return _line;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.arrow];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.subTitle];
        [self.contentView addSubview:self.labelAlert];
        [self.contentView addTarget:self action:@selector(cellClick)];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model{
    self.model = model;
    //设置总高度
    self.height = W(66);

    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.icon.image = [UIImage imageNamed:model.imageName];
    self.icon.leftCenterY = XY(W(15),self.height/2.0);
    
    [self.labelTitle fitTitle:model.title variable:0];
    self.labelTitle.leftCenterY = XY(isStr(model.imageName)?self.icon.right + W(15):W(15),self.icon.centerY);
    
    self.arrow.rightCenterY = XY(SCREEN_WIDTH - W(10),self.labelTitle.centerY);
    self.arrow.hidden = model.isHide;

    [self.subTitle fitTitle:model.subTitle variable:0];
    self.subTitle.rightCenterY = XY(self.arrow.hidden?SCREEN_WIDTH - W(15):(self.arrow.left - W(10)), self.icon.centerY);
    
    self.labelAlert.hidden = !model.num;
    [GlobalMethod exchangeLabel:self.labelAlert count:model.num];
    self.labelAlert.rightCenterY = XY(self.arrow.left - W(10), self.icon.centerY);
    
    self.line.hidden = model.isLineHide;
    self.line.bottom = self.height;
}

#pragma mark click
- (void)cellClick{
    if (self.model.blockClick) {
        self.model.blockClick();
    }
}
@end


@implementation SettingEmptyCell
#pragma mark 懒加载
- (UIView *)line{
    if (_line == nil) {
        _line = [UIView new];
        _line.backgroundColor = COLOR_LINE;
    }
    return _line;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = COLOR_BACKGROUND;
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        [self.contentView addSubview:self.line];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //设置总高度
    self.height = W(10);

    //刷新view
    self.line.widthHeight = XY(SCREEN_WIDTH, 1);
    self.line.leftTop = XY(0,self.height -1);
}

@end

