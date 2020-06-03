//
//  PerfectSelectCell.m
//中车运
//
//  Created by 隋林栋 on 2018/10/24.
//Copyright © 2018年 ping. All rights reserved.
//

#import "PerfectSelectCell.h"

@interface PerfectSelectCell ()

@end

@implementation PerfectSelectCell
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_666;
        _title.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _title.numberOfLines = 0;
        _title.lineSpace = 0;
    }
    return _title;
}
- (UILabel *)subTitle{
    if (_subTitle == nil) {
        _subTitle = [UILabel new];
        _subTitle.textColor = COLOR_333;
        _subTitle.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _subTitle.numberOfLines = 0;
        _subTitle.lineSpace = 0;
    }
    return _subTitle;
}
- (UIImageView *)ivArrow{
    if (!_ivArrow) {
        _ivArrow = [UIImageView new];
        _ivArrow.image = [UIImage imageNamed:@"arrow_down"];
        _ivArrow.backgroundColor=[UIColor clearColor];
        _ivArrow.widthHeight = XY(W(25), W(25));
    }
    return _ivArrow;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.subTitle];
        [self.contentView addSubview:self.ivArrow];
        [self.contentView addTarget:self action:@selector(cellClick)];
    }
    return self;
}
#pragma mark 刷新cell
/*
 isSelected 是否必填
 isHide 是否隐藏右箭头
 */
- (void)resetCellWithModel:(ModelBaseData *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //设置总高度
    self.height = W(65);
    
    
    [self.title fitTitle:model.string variable:0];
    self.title.leftCenterY = XY(W(15),self.height/2.0);
    self.title.textColor = self.model.isChangeInvalid?COLOR_999:COLOR_666;
    
    self.ivArrow.rightCenterY = XY(SCREEN_WIDTH - W(15), self.height/2.0);
    
    NSString * strPlace = self.model.isChangeInvalid?@"不可修改":model.placeHolderString;
    [self.subTitle fitTitle:isStr(model.subString)?model.subString:strPlace variable:self.ivArrow.left - W(115)];
    self.subTitle.leftCenterY = XY(W(99),self.height/2.0);
    self.subTitle.textColor = isStr(model.subString)?COLOR_333:COLOR_999;
    if (self.model.isChangeInvalid) {
        self.subTitle.textColor = COLOR_999;
    }
    
    if (!model.hideState) {
        [self.contentView addLineFrame:CGRectMake(W(15), self.height -1, SCREEN_WIDTH - W(15), 1)];
    }
    
}
#pragma mark click
- (void)cellClick{
    if (self.model.isChangeInvalid) {
        [GlobalMethod showAlert:@"不可修改"];
        return;
    }
    if (self.model.blocClick) {
        self.model.blocClick(self.model);
    }
}

@end
