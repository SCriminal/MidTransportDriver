//
//  AccountListCell.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/16.
//Copyright © 2019 ping. All rights reserved.
//

#import "OrderAccountListCell.h"

@interface OrderAccountListCell ()

@end

@implementation OrderAccountListCell
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _labelTitle.numberOfLines = 1;
        _labelTitle.lineSpace = 0;
    }
    return _labelTitle;
}
- (UILabel *)labelTime{
    if (_labelTime == nil) {
        _labelTime = [UILabel new];
        _labelTime.textColor = COLOR_666;
        _labelTime.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        _labelTime.numberOfLines = 1;
        _labelTime.lineSpace = 0;
    }
    return _labelTime;
}
- (UIImageView *)ivSelected{
    if (!_ivSelected) {
        _ivSelected = [UIImageView new];
        _ivSelected.image = [UIImage imageNamed:@"account_choose_default"];
        _ivSelected.highlightedImage = [UIImage imageNamed:@"account_choose_selected"];
        _ivSelected.widthHeight = XY(W(25),W(25));
    }
    return _ivSelected;
}
- (UILabel *)labelPrice{
    if (_labelPrice == nil) {
        _labelPrice = [UILabel new];
        _labelPrice.textColor = COLOR_333;
        _labelPrice.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightSemibold];
        _labelPrice.numberOfLines = 1;
        _labelPrice.lineSpace = 0;
    }
    return _labelPrice;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.labelTime];
        [self.contentView addSubview:self.labelPrice];
        [self.contentView addSubview:self.ivSelected];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelAccountList *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    
    self.ivSelected.hidden = !self.isEditing;
    self.ivSelected.highlighted = self.model.isSelected;
    self.ivSelected.left = W(10);
    //刷新view
    [self.labelPrice fitTitle: [NSString stringWithFormat:@"%@%.2f",model.type == 1?@"+":@"-",model.fee/100.0] variable:0];
    self.labelPrice.right = SCREEN_WIDTH -  W(15);
    
    [self.labelTitle fitTitle:UnPackStr(model.iDPropertyDescription) variable:self.labelPrice.left - W(30) - (self.ivSelected.hidden?0:self.ivSelected.right)];
    self.labelTitle.leftTop = XY(self.ivSelected.hidden?W(15):self.ivSelected.right + W(15),W(20));
    
    
    [self.labelTime fitTitle:[NSString stringWithFormat:@"记账时间：%@",[GlobalMethod exchangeTimeWithStamp:model.createTime andFormatter:TIME_SEC_SHOW]] variable:self.labelPrice.left - W(30)];
    self.labelTime.leftTop = XY(self.labelTitle.left,self.labelTitle.bottom+W(13));
    
    //设置总高度
    self.height = self.labelTime.bottom + W(20);
    
    self.ivSelected.centerY = self.height/2.0;
    self.labelPrice.centerY = self.height/2.0;
    
    [self.contentView addLineFrame:CGRectMake(0, self.height - 1, SCREEN_WIDTH, 1)];
}

@end


@implementation OrderAccountBottomView
#pragma mark 懒加载
- (UILabel *)labelSum{
    if (_labelSum == nil) {
        _labelSum = [UILabel new];
        _labelSum.textColor = COLOR_333;
        _labelSum.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelSum.numberOfLines = 1;
        _labelSum.lineSpace = 0;
    }
    return _labelSum;
}

-(UIButton *)btnManage{
    if (_btnManage == nil) {
        _btnManage = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnManage addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        _btnManage.backgroundColor = COLOR_BLUE;
        _btnManage.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnManage setTitle:@"记录一笔" forState:(UIControlStateNormal)];
        [_btnManage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnManage.widthHeight = XY(W(125),W(40));
        [GlobalMethod setRoundView:_btnManage color:[UIColor clearColor] numRound:_btnManage.height/2.0 width:0];
    }
    return _btnManage;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.widthHeight = XY(SCREEN_WIDTH, W(54)+iphoneXBottomInterval);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.labelSum];
    [self addSubview:self.btnManage];
    
    //初始化页面
    [self resetViewWithModel:0];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(double)fee{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.btnManage.rightCenterY = XY(SCREEN_WIDTH - W(15),(self.height-iphoneXBottomInterval)/2.0);
    
    //刷新view
    NSString * str1 = @"合计：";
    NSString * str2 =  [NSString stringWithFormat:@"%.2f",fee/100.0];
    NSMutableAttributedString *strAttribute = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str1,str2]];
    [strAttribute setAttributes:@{NSForegroundColorAttributeName : COLOR_333,        NSFontAttributeName : [UIFont systemFontOfSize:F(15)]} range:NSMakeRange(0, str1.length)];
    [strAttribute setAttributes:@{NSForegroundColorAttributeName : COLOR_RED,        NSFontAttributeName : [UIFont systemFontOfSize:F(15)]} range:NSMakeRange(str1.length, str2.length)];
    self.labelSum.attributedText = strAttribute;
    self.labelSum.widthHeight = XY(self.btnManage.left - W(30), [UIFont fetchHeight:F(15)]);
    
    self.labelSum.leftCenterY = XY(W(15),(self.height-iphoneXBottomInterval)/2.0);
    
    
    [self addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
}
#pragma mark 点击事件
- (void)btnClick{
    if (self.blockClick) {
        self.blockClick();
    }
}

@end


@implementation OrderAccountBottomEditView
#pragma mark 懒加载
- (UILabel *)labelSum{
    if (_labelSum == nil) {
        _labelSum = [UILabel new];
        _labelSum.textColor = COLOR_333;
        _labelSum.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelSum.numberOfLines = 1;
        _labelSum.lineSpace = 0;
    }
    return _labelSum;
}

-(UIButton *)btnManage{
    if (_btnManage == nil) {
        _btnManage = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnManage addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        _btnManage.backgroundColor = [UIColor whiteColor];
        _btnManage.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnManage setTitle:@"删除" forState:(UIControlStateNormal)];
        [_btnManage setTitleColor:COLOR_RED forState:UIControlStateNormal];
        _btnManage.widthHeight = XY(W(125),W(40));
        [GlobalMethod setRoundView:_btnManage color:COLOR_RED numRound:_btnManage.height/2.0 width:1];
    }
    return _btnManage;
}

- (UIImageView *)ivSelected{
    if (!_ivSelected) {
        _ivSelected = [UIImageView new];
        _ivSelected.image = [UIImage imageNamed:@"account_choose_default"];
        _ivSelected.highlightedImage = [UIImage imageNamed:@"account_choose_selected"];
        _ivSelected.widthHeight = XY(W(25),W(25));
    }
    return _ivSelected;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.widthHeight = XY(SCREEN_WIDTH, W(54)+iphoneXBottomInterval);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.labelSum];
    [self addSubview:self.btnManage];
    [self addSubview:self.ivSelected];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.btnManage.rightCenterY = XY(SCREEN_WIDTH - W(15),(self.height-iphoneXBottomInterval)/2.0);
    
    //刷新view
    self.ivSelected.leftCenterY = XY(W(10), (self.height-iphoneXBottomInterval)/2.0);
    [self addControlFrame:CGRectInset(self.ivSelected.frame, -W(50), -W(10)) belowView:self.ivSelected target:self action:@selector(selectAllClick)];
    
    [self.labelSum fitTitle:@"全选" variable:0];
    self.labelSum.leftCenterY = XY(self.ivSelected.right + W(10),self.ivSelected.centerY);
    
    
    [self addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
}
#pragma mark 点击事件
- (void)btnClick{
    if (self.blockClick) {
        self.blockClick();
    }
}
- (void)selectAllClick{
    self.ivSelected.highlighted = !self.ivSelected.highlighted;
    if (self.blockSelectAllClick) {
        self.blockSelectAllClick(self.ivSelected.highlighted);
    }
}
- (void)refreshStatus:(NSArray *)ary{
    self.ivSelected.highlighted = true;
    
    for (ModelAccountList * modelItem in ary) {
        if (!modelItem.isSelected) {
            self.ivSelected.highlighted = false;
            break;
        }
    }
}
@end
