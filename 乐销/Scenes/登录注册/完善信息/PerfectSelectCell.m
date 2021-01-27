//
//  PerfectSelectCell.m
//中车运
//
//  Created by 隋林栋 on 2018/10/24.
//Copyright © 2018年 ping. All rights reserved.
//

#import "PerfectSelectCell.h"
#import "ImageDetailBigView.h"
@interface PerfectSelectCell ()

@end

@implementation PerfectSelectCell
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _title.numberOfLines = 0;
        _title.lineSpace = 0;
    }
    return _title;
}
- (UILabel *)subTitle{
    if (_subTitle == nil) {
        _subTitle = [UILabel new];
        _subTitle.textColor = COLOR_333;
        _subTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _subTitle.numberOfLines = 0;
        _subTitle.lineSpace = 0;
    }
    return _subTitle;
}
- (UIImageView *)ivArrow{
    if (!_ivArrow) {
        _ivArrow = [UIImageView new];
        _ivArrow.image = [UIImage imageNamed:@"setting_RightArrow"];
        _ivArrow.backgroundColor=[UIColor clearColor];
        _ivArrow.widthHeight = XY(W(25), W(25));
    }
    return _ivArrow;
}
- (UILabel *)essential{
    if (_essential == nil) {
        _essential = [UILabel new];
        _essential.textColor = [UIColor redColor];
        _essential.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_essential fitTitle:@"*" variable:0];
    }
    return _essential;
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
        [self.contentView addSubview:self.essential];

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
    self.height = W(49);
    
    
    [self.title fitTitle:model.string variable:0];
    self.title.leftCenterY = XY(W(15),self.height/2.0);
    
    self.essential.rightCenterY = XY(self.title.left-W(2), self.title.centerY);
    self.essential.hidden = !model.isRequired;

    self.ivArrow.rightCenterY = XY(SCREEN_WIDTH - W(15), self.height/2.0);
    self.ivArrow.hidden = model.isArrowHide;
    NSString * strPlace = self.model.isChangeInvalid?@"不可修改":model.placeHolderString;
    [self.subTitle fitTitle:isStr(model.subString)?model.subString:strPlace variable:self.ivArrow.left - W(5)-(model.subLeft?model.subLeft:W(99))];
    self.subTitle.leftCenterY = XY(model.subLeft?model.subLeft:W(99),self.height/2.0);
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
//        [GlobalMethod showAlert:@"不可修改"];
        return;
    }
    if (self.model.blocClick) {
        self.model.blocClick(self.model);
    }
}

@end


@implementation PerfectSelectCell_Path
- (UIButton *)btnDelete{
    if (_btnDelete == nil) {
        _btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDelete addTarget:self action:@selector(btnDeleteClick) forControlEvents:UIControlEventTouchUpInside];
        _btnDelete.backgroundColor = [UIColor clearColor];
        _btnDelete.widthHeight = XY(W(23+30),W(30+23));
        [_btnDelete addSubview:^(){
            UIImageView *icon = [UIImageView new];
            icon.image = [UIImage imageNamed:@"address_delete"];
            icon.widthHeight = XY(W(23),W(23));
            icon.rightCenterY = XY(W(23+30 -15), W(30+23)/2.0);
            return icon;
        }()];
        _btnDelete.hidden = true;
    }
    return _btnDelete;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.btnDelete];
    }
    return self;
}
#pragma mark 刷新cell
    
/*
 isSelected 是否必填
 isHide 是否隐藏右箭头
 */
- (void)resetCellWithModel:(ModelBaseData *)model{
    [super resetCellWithModel:model];
    {
           self.btnDelete.hidden = false;
           self.btnDelete.rightCenterY = XY(SCREEN_WIDTH - W(59)+ W(15), self.height/2.0);
    }
    NSString * strPlace = self.model.isChangeInvalid?@"不可修改":model.placeHolderString;
    [self.subTitle fitTitle:isStr(model.subString)?model.subString:strPlace variable:self.ivArrow.left - W(45)-(model.subLeft?model.subLeft:W(99))];

}
    
#pragma mark click
- (void)btnDeleteClick{
    if (self.model.blockDeleteClick) {
        self.model.blockDeleteClick(self.model);
    }
}
@end


@implementation PerfectSelectCell_Logo
- (UIImageView *)iconLogo{
    if (!_iconLogo) {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.widthHeight = XY(W(49),W(31));
        _iconLogo = iv;
    }
    return _iconLogo;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.iconLogo];
    }
    return self;
}
#pragma mark 刷新cell
    
/*
 isSelected 是否必填
 isHide 是否隐藏右箭头
 */
- (void)resetCellWithModel:(ModelBaseData *)model{
    [super resetCellWithModel:model];
    if (isStr(model.identifier)) {
        NSLog(@"sldcell_%@,",model.identifier);
        [self.subTitle fitTitle:@"上传成功" variable:0];
        self.subTitle.textColor =COLOR_333;
    }
    self.iconLogo.hidden = !isStr(model.identifier);
    self.iconLogo.rightCenterY = XY(SCREEN_WIDTH - W(44), self.height/2.0);
    [self.iconLogo sd_setImageWithURL:[NSURL URLWithString:model.identifier] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT ]];
    
    self.subTitle.hidden = self.model.isChangeInvalid;
}
#pragma mark click
- (void)cellClick{
    if (self.model.isChangeInvalid) {
        ImageDetailBigView * detailView = [ImageDetailBigView new];
        [detailView resetView:^(){
            NSMutableArray * aryImages = [NSMutableArray new];
            ModelImage * model = [ModelImage new];
            model.url = self.model.identifier;
            [aryImages addObject:model];
            return aryImages;
        }() isEdit:false index:0];
        [detailView showInView:[GB_Nav.lastVC view] imageViewShow:self.iconLogo];
        return;
    }
    if (self.model.blocClick) {
        self.model.blocClick(self.model);
    }
}
@end
