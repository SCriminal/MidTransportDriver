//
//  AttachedCarTeamListCell.m
//  Driver
//
//  Created by 隋林栋 on 2019/12/3.
//Copyright © 2019 ping. All rights reserved.
//

#import "AttachedCarTeamListCell.h"

@interface AttachedCarTeamListCell ()

@end

@implementation AttachedCarTeamListCell
#pragma mark 懒加载
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        _labelName.textColor = COLOR_333;
        _labelName.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightMedium];
        _labelName.numberOfLines = 0;
        _labelName.lineSpace = 0;
    }
    return _labelName;
}
- (UILabel *)labelAddress{
    if (_labelAddress == nil) {
        _labelAddress = [UILabel new];
        _labelAddress.textColor = COLOR_666;
        _labelAddress.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelAddress.numberOfLines = 0;
        _labelAddress.lineSpace = 0;
    }
    return _labelAddress;
}
-(UIButton *)btnApply{
    if (_btnApply == nil) {
        _btnApply = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnApply.tag = 1;
        [_btnApply addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnApply.backgroundColor = COLOR_BLUE;
        _btnApply.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [GlobalMethod setRoundView:_btnApply color:[UIColor clearColor] numRound:5 width:0];
        [_btnApply setTitle:@"申请挂靠" forState:(UIControlStateNormal)];
        _btnApply.widthHeight = XY(SCREEN_WIDTH - W(30),W(40));
    }
    return _btnApply;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.labelName];
        [self.contentView addSubview:self.labelAddress];
        [self.contentView addSubview:self.btnApply];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelAttachCompany *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelName fitTitle:UnPackStr(model.name) variable:SCREEN_WIDTH - W(30)];
    self.labelName.leftTop = XY(W(15),W(20));
    
    [self.labelAddress fitTitle:[NSString stringWithFormat:@"地址：%@",isStr(model.addressShow)?model.addressShow:@"暂无地址"] variable:SCREEN_WIDTH - W(30)];
    self.labelAddress.leftTop = XY(W(15),self.labelName.bottom+W(20));
    self.btnApply.widthHeight = XY(W(100), W(40));
    self.btnApply.rightTop = XY(SCREEN_WIDTH - W(15),self.labelAddress.bottom+W(20));
    
    //设置总高度
    self.height = self.btnApply.bottom + W(20);
    [self.contentView addLineFrame:CGRectMake(0, self.height - 1, SCREEN_WIDTH , 1)];
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_333];
    ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
    WEAKSELF
    modelConfirm.blockClick = ^(void){
        if (weakSelf.blockClick) {
            weakSelf.blockClick(weakSelf.model);
        }
    };
    [BaseAlertView initWithTitle:@"提示" content:[NSString stringWithFormat:@"你确定申请挂靠%@?",UnPackStr(self.model.name)] aryBtnModels:@[modelDismiss,modelConfirm] viewShow:[UIApplication sharedApplication].keyWindow];
    
}

@end

@implementation AttachedCarTeamSearchView
#pragma mark 懒加载
-(UIButton *)btnSearch{
    if (_btnSearch == nil) {
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSearch.tag = 1;
        [_btnSearch addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnSearch.backgroundColor = [UIColor clearColor];
        [_btnSearch setTitleColor:COLOR_333 forState:UIControlStateNormal];
        _btnSearch.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnSearch setTitle:@"搜索" forState:(UIControlStateNormal)];
        _btnSearch.widthHeight = XY(W(60),W(45));
    }
    return _btnSearch;
}
- (UITextField *)tfSearch{
    if (_tfSearch == nil) {
        _tfSearch = [UITextField new];
        _tfSearch.font = [UIFont systemFontOfSize:F(13)];
        _tfSearch.textAlignment = NSTextAlignmentLeft;
        _tfSearch.placeholder = @"请输入车队名称";
        _tfSearch.borderStyle = UITextBorderStyleNone;
        _tfSearch.backgroundColor = [UIColor clearColor];
        _tfSearch.delegate = self;
        [_tfSearch addTarget:self action:@selector(textFileAction:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _tfSearch;
}
- (UIImageView *)iconSearch{
    if (_iconSearch == nil) {
        _iconSearch = [UIImageView new];
        _iconSearch.image = [UIImage imageNamed:@"attachCarTeam_search"];
        _iconSearch.widthHeight = XY(W(25),W(25));
    }
    return _iconSearch;
}
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.widthHeight = XY(W(300),W(35));
        _viewBG.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [GlobalMethod setRoundView:_viewBG color:[UIColor clearColor] numRound:_viewBG.height/2.0 width:0];
        [_viewBG addTarget:self action:@selector(viewBGClick)];
    }
    return _viewBG;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.height = W(50);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBG];
    [self addSubview:self.btnSearch];
    [self addSubview:self.tfSearch];
    [self addSubview:self.iconSearch];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.viewBG.leftTop = XY(W(14),W(5));

    self.iconSearch.leftCenterY = XY(W(24),self.viewBG.centerY);

    self.btnSearch.rightCenterY = XY(SCREEN_WIDTH,self.viewBG.centerY);
    self.tfSearch.widthHeight = XY(self.viewBG.width - W(50), self.tfSearch.font.lineHeight);
    self.tfSearch.leftCenterY = XY(self.viewBG.left + W(40),self.viewBG.centerY+W(2));
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    [GlobalMethod endEditing];
    NSString * strKey = self.tfSearch.text;
    if (strKey.length <2) {
        [GlobalMethod showAlert:@"请输入有效数据"];
        return;
    }
    NSArray *aryStr = @[@"物流",@"公司",@"运输",@"集装箱",@"海运",@"货代",@"货",@"代",@"运",@"货运",@"货运代理"];
    for (NSString * strItem in aryStr) {
        if ([strItem rangeOfString:strKey].location != NSNotFound) {
            [GlobalMethod showAlert:@"请输入有效数据"];
            return;
        }
    }
   
    if (self.blockSearch) {
        self.blockSearch(strKey);
    }
}

#pragma mark textfield delegate
- (void)textFileAction:(UITextField *)tf{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}
- (void)viewBGClick{
    [self.tfSearch becomeFirstResponder];
}

@end
