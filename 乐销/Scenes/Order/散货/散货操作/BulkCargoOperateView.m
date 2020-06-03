//
//  BulkCargoOperateView.m
//  Driver
//
//  Created by 隋林栋 on 2019/7/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "BulkCargoOperateView.h"


@implementation BulkCargoOperateTopView
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineSpace = 0;
    }
    return _labelTitle;
}
- (UIImageView *)ivLeft{
    if (_ivLeft == nil) {
        _ivLeft = [UIImageView new];
        _ivLeft.image = [UIImage imageNamed:@"back_black"];
        _ivLeft.widthHeight = XY(W(25),W(25));
    }
    return _ivLeft;
}
- (UIImageView *)ivRight{
    if (_ivRight == nil) {
        _ivRight = [UIImageView new];
        _ivRight.image = [UIImage imageNamed:@"orderTopShare"];
        _ivRight.widthHeight = XY(W(25),W(25));
    }
    return _ivRight;
}
- (UIImageView *)ivBg{
    if (_ivBg == nil) {
        _ivBg = [UIImageView new];
        _ivBg.image = [UIImage imageNamed:@"orderOperateTopBg"];
        _ivBg.widthHeight = XY(W(373),W(68));
        _ivBg.backgroundColor = [UIColor clearColor];
    }
    return _ivBg;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.width = SCREEN_WIDTH;
        self.backgroundColor = [UIColor clearColor];
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.labelTitle];
    [self addSubview:self.ivLeft];
    [self addSubview:self.ivRight];
    [self resetViewWithModel:nil];
}


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model{
    self.model = model;
    
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.ivBg.centerXTop = XY(SCREEN_WIDTH/2.0, STATUSBAR_HEIGHT);
    //刷新view
    [self.labelTitle fitTitle:@"运单操作" variable:0];
    self.labelTitle.centerXCenterY = self.ivBg.centerXCenterY;
    
    self.ivLeft.leftCenterY = XY(self.ivBg.left + W(20),self.labelTitle.centerY);
    [self addControlFrame:CGRectInset(self.ivLeft.frame, -W(20), -W(20)) belowView:self.ivLeft target:self action:@selector(backClick)];
    self.ivRight.rightCenterY = XY(self.ivBg.right - W(20),self.labelTitle.centerY);
    [self addControlFrame:CGRectInset(self.ivRight.frame, -W(20), -W(20)) belowView:self.ivRight target:self action:@selector(ShareClick)];
    
    //设置总高度
    self.height = self.ivBg.bottom + W(10);
}

#pragma mark click
- (void)backClick{
    [GB_Nav popViewControllerAnimated:true];
}
- (void)ShareClick{
    if (self.blockClick) {
        self.blockClick();
    }
}
@end

@implementation BulkCargoOperateMidView
#pragma mark 懒加载
- (UIView *)viewBg{
    if (_viewBg == nil) {
        _viewBg = [UIView new];
        _viewBg.backgroundColor = [UIColor clearColor];
    }
    return _viewBg;
}
- (UIControl *)conClick{
    if (!_conClick) {
        _conClick = [UIControl new];
        [_conClick addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _conClick;
}
- (UILabel *)labelCarNum{
    if (_labelCarNum == nil) {
        _labelCarNum = [UILabel new];
        _labelCarNum.textColor = COLOR_333;
        _labelCarNum.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _labelCarNum.numberOfLines = 1;
    }
    return _labelCarNum;
}
- (UIImageView *)ivHead{
    if (_ivHead == nil) {
        _ivHead = [UIImageView new];
        _ivHead.image = [UIImage imageNamed:IMAGE_HEAD_DEFAULT];
        _ivHead.widthHeight = XY(W(30),W(30));
        [GlobalMethod setRoundView:_ivHead color:[UIColor clearColor] numRound:_ivHead.width/2.0 width:0];
    }
    return _ivHead;
}
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        _labelName.textColor = COLOR_333;
        _labelName.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _labelName.numberOfLines = 1;
    }
    return _labelName;
}
- (UIView *)line{
    if (_line == nil) {
        _line = [UIView new];
        _line.backgroundColor = COLOR_LINE;
    }
    return _line;
}
- (UILabel *)billNo{
    if (_billNo == nil) {
        _billNo = [UILabel new];
        _billNo.textColor = COLOR_333;
        _billNo.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _billNo.numberOfLines = 1;
        
    }
    return _billNo;
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBg];
    [self.viewBg addSubview:self.labelCarNum];
    [self.viewBg addSubview:self.ivHead];
    [self.viewBg addSubview:self.labelName];
    [self.viewBg addSubview:self.line];
    [self.viewBg addSubview:self.billNo];
    [self.viewBg addSubview:self.conClick];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model{
    self.model = model;
    [self.viewBg removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.viewBg.widthHeight = XY(SCREEN_WIDTH,W(110));
    self.viewBg.centerXTop = XY(SCREEN_WIDTH/2.0,W(0));
    self.conClick.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.viewBg.height/2.0);

    [self.labelName fitTitle:[GlobalData sharedInstance].GB_UserModel.nickname variable:0];
    self.labelName.rightCenterY = XY(self.viewBg.width - W(25),self.viewBg.height/4.0);
    
    [self.ivHead sd_setImageWithURL:[NSURL URLWithString:[GlobalData sharedInstance].GB_UserModel.headUrl] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.ivHead.rightCenterY = XY(self.labelName.left - W(10),self.labelName.centerY);
    [self.labelCarNum fitTitle:UnPackStr(model.vehicleNumber) variable:self.ivHead.left - W(30)];
    self.labelCarNum.leftCenterY = XY(W(25),self.ivHead.centerY);
    
    self.line.widthHeight = XY(self.viewBg.width - W(50), 1);
    self.line.centerXCenterY = XY(self.viewBg.width/2.0,self.viewBg.height/2.0);
    
    {//判断是否接单
        
        self.labelName.hidden = model.operateType == ENUM_BULKCARGO_ORDER_OPERATE_WAIT_RECEIVE;
        self.ivHead.hidden = model.operateType == ENUM_BULKCARGO_ORDER_OPERATE_WAIT_RECEIVE;
        self.labelCarNum.hidden = model.operateType == ENUM_BULKCARGO_ORDER_OPERATE_WAIT_RECEIVE;
        self.line.hidden = model.operateType == ENUM_BULKCARGO_ORDER_OPERATE_WAIT_RECEIVE;
        self.viewBg.height = model.operateType == ENUM_BULKCARGO_ORDER_OPERATE_WAIT_RECEIVE?self.viewBg.height/2.0:self.viewBg.height;
    }
    
    
    [self.billNo fitTitle:[NSString stringWithFormat:@"运单号：%@",UnPackStr(model.waybillNumber)] variable:SCREEN_WIDTH - W(50)];
    self.billNo.leftCenterY = XY(W(25),model.operateType == ENUM_BULKCARGO_ORDER_OPERATE_WAIT_RECEIVE?self.viewBg.height/4.0*2.0:self.viewBg.height/4.0*3.0);
    
    [self.viewBg addLineFrame: CGRectMake(W(25), self.viewBg.height -1, self.viewBg.width - W(50), 1)];
    //设置总高度
    self.height = self.viewBg.bottom;
}

#pragma mark click
- (void)click{
    if (self.blockBottomClick ) {
        self.blockBottomClick();
    }
}
@end

@implementation BulkCargoOperateBottomView
#pragma mark 懒加载
-(UIButton *)btnOperate{
    if (_btnOperate == nil) {
        _btnOperate = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnOperate.tag = 1;
        [_btnOperate addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnOperate.backgroundColor = [UIColor redColor];
        _btnOperate.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnOperate setTitle:@"提箱" forState:(UIControlStateNormal)];
        [_btnOperate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnOperate.widthHeight = XY(W(325),W(45));
        [GlobalMethod setRoundView:_btnOperate color:[UIColor clearColor] numRound:5 width:0];
    }
    return _btnOperate;
}
#pragma mark 懒加载
- (UILabel *)labelCargoName{
    if (_labelCargoName == nil) {
        _labelCargoName = [UILabel new];
        _labelCargoName.textColor = COLOR_333;
        _labelCargoName.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelCargoName.numberOfLines = 0;
        _labelCargoName.lineSpace = 0;
    }
    return _labelCargoName;
}
- (UILabel *)labelWeight{
    if (_labelWeight == nil) {
        _labelWeight = [UILabel new];
        _labelWeight.textColor = COLOR_333;
        _labelWeight.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelWeight.numberOfLines = 0;
        _labelWeight.lineSpace = 0;
    }
    return _labelWeight;
}
- (UILabel *)labelDetail{
    if (_labelDetail == nil) {
        _labelDetail = [UILabel new];
        _labelDetail.textColor = COLOR_BLUE;
        _labelDetail.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelDetail.numberOfLines = 0;
        _labelDetail.lineSpace = 0;
    }
    return _labelDetail;
}
- (UIImageView *)ivCargoName{
    if (_ivCargoName == nil) {
        _ivCargoName = [UIImageView new];
        _ivCargoName.image = [UIImage imageNamed:@"bulkCargo_cargoName"];
        _ivCargoName.widthHeight = XY(W(25),W(25));
    }
    return _ivCargoName;
}
- (UIImageView *)ivWeight{
    if (_ivWeight == nil) {
        _ivWeight = [UIImageView new];
        _ivWeight.image = [UIImage imageNamed:@"bulkCargo_weight"];
        _ivWeight.widthHeight = XY(W(25),W(25));
    }
    return _ivWeight;
}
- (UIImageView *)ivArrow{
    if (_ivArrow == nil) {
        _ivArrow = [UIImageView new];
        _ivArrow.image = [UIImage imageNamed:@"bulkCargo_arrow_right"];
        _ivArrow.widthHeight = XY(W(25),W(25));
    }
    return _ivArrow;
}
- (UIControl *)conDetail{
    if (!_conDetail) {
        _conDetail = [UIControl new];
        [_conDetail addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _conDetail;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.labelWeight];
    [self addSubview:self.labelDetail];
    [self addSubview:self.labelCargoName];
    [self addSubview:self.ivCargoName];
    [self addSubview:self.ivWeight];
    [self addSubview:self.ivArrow];
    [self addSubview:self.conDetail];

    [self addSubview:self.btnOperate];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model{
    self.modelOrder = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.ivCargoName.leftTop = XY(W(25),W(15));

    [self.labelCargoName fitTitle:[NSString stringWithFormat:@"货物名称：%@",UnPackStr(model.cargoName)] variable:SCREEN_WIDTH- self.ivCargoName.right - W(80)];
    self.labelCargoName.leftCenterY = XY(self.ivCargoName.right + W(10),self.ivCargoName.centerY);
    
    self.ivWeight.leftTop = XY(self.ivCargoName.left,self.ivCargoName.bottom+W(10));
    [self.labelWeight fitTitle:[NSString stringWithFormat:@"发货量：%@ %@",NSNumber.dou(model.actualLoad),UnPackStr(model.loadUnit)] variable:SCREEN_WIDTH- self.ivCargoName.right - W(80)];
    self.labelWeight.leftCenterY = XY(self.ivWeight.right + W(10),self.ivWeight.centerY);
    
    
    self.ivArrow.rightCenterY = XY(SCREEN_WIDTH -  W(22),self.ivCargoName.bottom+W(5));
    [self.labelDetail fitTitle:@"详情" variable:0];
    self.labelDetail.rightCenterY = XY(self.ivArrow.left - W(4),self.ivArrow.centerY);
    
    
    
    
    BOOL isShowOperateBtn = model.operateType != ENUM_BULKCARGO_ORDER_OPERATE_CLOSE && model.operateType != ENUM_BULKCARGO_ORDER_OPERATE_COMPLETE&&model.operateType != ENUM_BULKCARGO_ORDER_OPERATE_ARRIVE;
    
    if (isShowOperateBtn) {
        [self addLineFrame:CGRectMake(W(25), self.labelWeight.bottom+W(17), SCREEN_WIDTH - W(50), 1)];
    }
    
    {//刷新按钮
        NSString * strTitle = @"";
        UIColor * color = COLOR_BLUE;
        switch (model.operateType) {
            case ENUM_BULKCARGO_ORDER_OPERATE_WAIT_RECEIVE:
                strTitle = @"接单";
                color = COLOR_BLUE;
                break;
            case ENUM_BULKCARGO_ORDER_OPERATE_WAIT_LOAD:
                strTitle = @"装车";
                color = [UIColor colorWithHexString:@"#F97A1B"];
                break;
            case ENUM_BULKCARGO_ORDER_OPERATE_WAIT_UNLOAD:
                strTitle = @"完成";
                color = [UIColor colorWithHexString:@"#66CC00"];
                break;
            default:
                break;
        }
        [self.btnOperate setTitle:strTitle forState:UIControlStateNormal];
        [self.btnOperate setBackgroundColor:color];
        self.btnOperate.hidden = !isShowOperateBtn;
    }
    self.conDetail.frame = CGRectMake(0, self.ivCargoName.top - W(5), SCREEN_WIDTH, self.ivWeight.bottom - self.ivCargoName.top+W(5));
    self.btnOperate.centerXTop = XY(SCREEN_WIDTH/2.0,self.ivWeight.bottom+ W(35));
    //设置总高度
    self.height = isShowOperateBtn?self.btnOperate.bottom + W(20):self.ivWeight.bottom+ W(15);
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    if (self.blockOperateClick) {
        self.blockOperateClick();
    }
}
- (void)detailClick{
    if (self.blockDetailClick) {
        self.blockDetailClick();
    }
}
@end




