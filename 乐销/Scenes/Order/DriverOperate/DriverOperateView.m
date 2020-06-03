//
//  DriverOperateView.m
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import "DriverOperateView.h"

@implementation DriverOperateTopView
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
- (void)resetViewWithModel:(ModelOrderList *)model{
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

@implementation DriverOperateMidView
#pragma mark 懒加载
- (UIView *)viewBg{
    if (_viewBg == nil) {
        _viewBg = [UIView new];
        _viewBg.backgroundColor = [UIColor clearColor];
    }
    return _viewBg;
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
- (UIControl *)conClick{
    if (!_conClick) {
        _conClick = [UIControl new];
        [_conClick addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _conClick;
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
- (void)resetViewWithModel:(ModelOrderList *)model{
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
    [self.labelCarNum fitTitle:UnPackStr(model.truckNumber) variable:self.ivHead.left - W(30)];
    self.labelCarNum.leftCenterY = XY(W(25),self.ivHead.centerY);
    
    self.line.widthHeight = XY(self.viewBg.width - W(50), 1);
    self.line.centerXCenterY = XY(self.viewBg.width/2.0,self.viewBg.height/2.0);
    
    {//判断是否接单
        self.labelName.hidden = model.operateType == ENUM_ORDER_OPERATE_WAIT_RECEIVE;
        self.ivHead.hidden = model.operateType == ENUM_ORDER_OPERATE_WAIT_RECEIVE;
        self.labelCarNum.hidden = model.operateType == ENUM_ORDER_OPERATE_WAIT_RECEIVE;
        self.line.hidden = model.operateType == ENUM_ORDER_OPERATE_WAIT_RECEIVE;
        self.viewBg.height = model.operateType == ENUM_ORDER_OPERATE_WAIT_RECEIVE?self.viewBg.height/2.0:self.viewBg.height;
    }
  
    
    [self.billNo fitTitle:[NSString stringWithFormat:@"提单号：%@",UnPackStr(model.blNumber)] variable:SCREEN_WIDTH - W(50)];
    self.billNo.leftCenterY = XY(W(25),model.operateType == ENUM_ORDER_OPERATE_WAIT_RECEIVE?self.viewBg.height/4.0*2.0:self.viewBg.height/4.0*3.0);
    
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

@implementation DriverOperateBottomView
#pragma mark 懒加载
- (DriverOperateBtn *)btnRecordPackageNo{
    if (!_btnRecordPackageNo) {
        _btnRecordPackageNo = [DriverOperateBtn new];
        ModelBtn * model = [ModelBtn new];
        model.title = @"录入箱号";
        model.imageName = @"orderOperate_particulars";
        WEAKSELF
        model.blockClick = ^{
            if (weakSelf.blockInputPackageNoClick) {
                weakSelf.blockInputPackageNoClick();
            }
        };
        [_btnRecordPackageNo resetViewWithModel:model];
    }
    return _btnRecordPackageNo;
}
- (DriverOperateBtn *)btnRecordPlumbumNo{
    if (!_btnRecordPlumbumNo) {
        _btnRecordPlumbumNo = [DriverOperateBtn new];
        ModelBtn * model = [ModelBtn new];
        model.title = @"录入铅封号";
        model.imageName = @"orderOperate_seal";
        WEAKSELF
        model.blockClick = ^{
            if (weakSelf.blockInputPlumbumNoNoClick) {
                weakSelf.blockInputPlumbumNoNoClick();
            }
        };
        [_btnRecordPlumbumNo resetViewWithModel:model];
    }
    return _btnRecordPlumbumNo;
}
- (DriverOperateBtn *)btnAccountBook{
    if (!_btnAccountBook) {
        _btnAccountBook = [DriverOperateBtn new];
        ModelBtn * model = [ModelBtn new];
        model.title = @"记账本";
        model.imageName = @"orderOperate_book";
        WEAKSELF
        model.blockClick = ^{
            if (weakSelf.blockInputAccountClick) {
                weakSelf.blockInputAccountClick();
            }
        };
        [_btnAccountBook resetViewWithModel:model];
    }
    return _btnAccountBook;
}
- (DriverOperateBtn *)btnCallDriverTeam{
    if (!_btnCallDriverTeam) {
        _btnCallDriverTeam = [DriverOperateBtn new];
        ModelBtn * model = [ModelBtn new];
        model.title = @"订单详情";
        model.imageName = @"orderOperate_detail";
        WEAKSELF
        model.blockClick = ^{
            if (weakSelf.blockDetailClick) {
                weakSelf.blockDetailClick();
            }
        };
        [_btnCallDriverTeam resetViewWithModel:model];
    }
    return _btnCallDriverTeam;
}
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
    [self addSubview:self.btnRecordPackageNo];
    [self addSubview:self.btnRecordPlumbumNo];
    [self addSubview:self.btnAccountBook];
    [self addSubview:self.btnCallDriverTeam];
    [self addSubview:self.btnOperate];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderList *)model{
    self.modelOrder = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.btnRecordPackageNo.leftTop = XY(W(18),0);
    self.btnRecordPlumbumNo.leftTop = XY(SCREEN_WIDTH/2.0,0);
    self.btnAccountBook.rightTop = XY(self.btnRecordPackageNo.right,self.btnRecordPackageNo.bottom);
    self.btnCallDriverTeam.leftTop = XY(self.btnRecordPlumbumNo.left,self.btnAccountBook.top);
    
    [self addLineFrame:CGRectMake(W(25), self.btnRecordPackageNo.bottom, SCREEN_WIDTH - W(50), 1)];
    [self addLineFrame:CGRectMake(SCREEN_WIDTH/2.0, self.btnRecordPackageNo.top +W(17), 1, W(20))];

    if (model.operateType != ENUM_ORDER_OPERATE_COMPLETE) {
        [self addLineFrame:CGRectMake(W(25), self.btnCallDriverTeam.bottom, SCREEN_WIDTH - W(50), 1)];
    }
    [self addLineFrame:CGRectMake(SCREEN_WIDTH/2.0, self.btnAccountBook.top +W(17), 1, W(20))];

    {//刷新按钮
        NSString * strTitle = @"";
        UIColor * color = COLOR_BLUE;
        switch (model.operateType) {
            case ENUM_ORDER_OPERATE_WAIT_RECEIVE:
                strTitle = @"接单";
                color = COLOR_BLUE;
                break;
            case ENUM_ORDER_OPERATE_BACK_PACKAGE:
                strTitle = @"提箱";
                color = [UIColor colorWithHexString:@"#F97A1B"];
                break;
            case ENUM_ORDER_OPERATE_ARRIVE_FACTORY:
                strTitle = @"到厂";
                color = [UIColor colorWithHexString:@"#66CC00"];
                break;
            case ENUM_ORDER_OPERATE_LOAD_COMPLETE:
                strTitle = model.orderType == ENUM_ORDER_TYPE_INPUT?@"卸货":@"装货";
                color = [UIColor colorWithHexString:@"#4395F4"];
                break;
            case ENUM_ORDER_OPERATE_RETURN_PACKAGE:
                strTitle = @"还箱";
                color = [UIColor redColor];
                break;
            default:
                break;
        }
        [self.btnOperate setTitle:strTitle forState:UIControlStateNormal];
        [self.btnOperate setBackgroundColor:color];
        self.btnOperate.hidden = model.operateType ==ENUM_ORDER_OPERATE_COMPLETE;
    }
    self.btnOperate.centerXTop = XY(SCREEN_WIDTH/2.0,self.btnCallDriverTeam.bottom+ W(20));
    //设置总高度
    self.height = model.operateType ==ENUM_ORDER_OPERATE_COMPLETE?self.btnCallDriverTeam.bottom+ W(0):self.btnOperate.bottom + W(20);
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    if (self.blockOperateClick) {
        self.blockOperateClick();
    }
}

@end




@implementation DriverOperateBtn
#pragma mark 懒加载

- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
    }
    return _labelTitle;
}
- (UIImageView *)ivIcon{
    if (_ivIcon == nil) {
        _ivIcon = [UIImageView new];
        _ivIcon.image = [UIImage imageNamed:@"orderOperate_book"];
        _ivIcon.widthHeight = XY(W(25),W(25));
    }
    return _ivIcon;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.widthHeight = XY(W(161),W(55));
        self.clipsToBounds = false;
        [self addSubView];
        [self addTarget:self action:@selector(click)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.labelTitle];
    [self addSubview:self.ivIcon];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBtn *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.ivIcon.image = [UIImage imageNamed:model.imageName];
    self.ivIcon.leftCenterY = XY(W(20),self.centerY);

    [self.labelTitle fitTitle:model.title variable:0];
    self.labelTitle.leftCenterY = XY(self.ivIcon.right + W(15),self.ivIcon.centerY);
}

- (void)click{
    if (self.model.blockClick) {
        self.model.blockClick();
    }
}
@end
