//
//  CardListCell.m
//  Driver
//
//  Created by 隋林栋 on 2019/9/20.
//Copyright © 2019 ping. All rights reserved.
//

#import "CardListCell.h"

@interface CardListCell ()

@end

@implementation CardListCell
#pragma mark 懒加载
- (UILabel *)labelBankName{
    if (_labelBankName == nil) {
        _labelBankName = [UILabel new];
        _labelBankName.textColor = [UIColor whiteColor];
        _labelBankName.font =  [UIFont systemFontOfSize:F(18) weight:UIFontWeightRegular];
    }
    return _labelBankName;
}
- (UILabel *)labelCardNum{
    if (_labelCardNum == nil) {
        _labelCardNum = [UILabel new];
        _labelCardNum.textColor = [UIColor whiteColor];
        _labelCardNum.font =  [UIFont systemFontOfSize:F(22) weight:UIFontWeightRegular];
    }
    return _labelCardNum;
}
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        _labelName.textColor = [UIColor whiteColor];
        _labelName.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _labelName;
}
- (UIImageView *)iconEdit{
    if (_iconEdit == nil) {
        _iconEdit = [UIImageView new];
        _iconEdit.image = [UIImage imageNamed:@"card_edit"];
        _iconEdit.widthHeight = XY(W(25),W(25));
    }
    return _iconEdit;
}
- (UILabel *)labelEdit{
    if (_labelEdit == nil) {
        _labelEdit = [UILabel new];
        _labelEdit.textColor = [UIColor whiteColor];
        _labelEdit.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _labelEdit;
}
- (UIImageView *)iconDelete{
    if (_iconDelete == nil) {
        _iconDelete = [UIImageView new];
        _iconDelete.image = [UIImage imageNamed:@"card_del"];
        _iconDelete.widthHeight = XY(W(25),W(25));
    }
    return _iconDelete;
}
- (UILabel *)labelDelete{
    if (_labelDelete == nil) {
        _labelDelete = [UILabel new];
        _labelDelete.textColor = [UIColor whiteColor];
        _labelDelete.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _labelDelete;
}
- (UIImageView *)ivBG{
    if (!_ivBG) {
        _ivBG = [UIImageView new];
        _ivBG.image = [UIImage imageNamed:@"card_bg"];
        _ivBG.widthHeight = XY(W(375),W(240));
    }
    return _ivBG;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.ivBG];
        [self.contentView addSubview:self.labelBankName];
        [self.contentView addSubview:self.labelCardNum];
        [self.contentView addSubview:self.labelName];
        [self.contentView addSubview:self.iconEdit];
        [self.contentView addSubview:self.labelEdit];
        [self.contentView addSubview:self.iconDelete];
        [self.contentView addSubview:self.labelDelete];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBank *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    [self.labelBankName fitTitle:UnPackStr(model.bankName) variable:SCREEN_WIDTH - W(80)];
    self.labelBankName.leftTop = XY(W(40),W(50));
    [self.labelCardNum fitTitle:[self fetchBankNum] variable:SCREEN_WIDTH - W(80)];
    self.labelCardNum.leftTop = XY(self.labelBankName.left,W(101));
    [self.labelName fitTitle:UnPackStr(model.accountName) variable:W(120)];
    self.labelName.leftTop = XY(self.labelBankName.left,W(166));
    
    [self.labelDelete fitTitle:@"删除" variable:0];
    self.labelDelete.rightCenterY = XY(SCREEN_WIDTH - W(40),self.labelName.centerY);
    self.iconDelete.rightCenterY = XY(self.labelDelete.left - W(2),self.labelName.centerY);
    [self.contentView addControlFrame:CGRectInset(self.labelDelete.frame, -W(20), -W(30)) belowView:self.labelDelete target:self action:@selector(deleteClick)];
    
    [self.labelEdit fitTitle:@"编辑" variable:0];
    self.labelEdit.rightCenterY = XY(self.iconDelete.left- W(20),self.labelName.centerY);
    self.iconEdit.rightCenterY = XY(self.labelEdit.left- W(2),self.labelName.centerY);
    [self.contentView addControlFrame:CGRectInset(self.labelEdit.frame, -W(20), -W(30)) belowView:self.labelEdit target:self action:@selector(editClick)];

    self.height = self.ivBG.height;
}

- (NSString *)fetchBankNum{
    if (!isStr(self.model.accountNumber)) {
        return @"";
    }
    NSString * strNumber = self.model.accountNumber;
    if (strNumber.length <4 ) {
        return strNumber;
    }
    NSString * strPre = [strNumber substringToIndex:4];
    NSString * strSuf = [strNumber substringFromIndex:strNumber.length - 3];
    
    return [NSString stringWithFormat:@"%@ **** **** **** %@",strPre,strSuf];
}

#pragma mark click
- (void)deleteClick{
    if (self.blockDeleteClick) {
        self.blockDeleteClick(self.model);
    }
}

- (void)editClick{
    if (self.blockEditClick) {
        self.blockEditClick(self.model);
    }
}
@end
