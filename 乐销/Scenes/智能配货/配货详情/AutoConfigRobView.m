//
//  AutoConfigRobView.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/4.
//Copyright © 2020 ping. All rights reserved.
//

#import "AutoConfigRobView.h"
#import "UITextField+Text.h"




@interface AutoConfigRobView ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *tfWeight;
@property (nonatomic, strong) UIView *viewWhitBG;
@property (nonatomic, strong) UILabel *labelPriceAll;

@end

@implementation AutoConfigRobView
- (UITextField *)tfWeight{
    if (_tfWeight == nil) {
        _tfWeight = [UITextField new];
        _tfWeight.font = [UIFont systemFontOfSize:F(15)];
        _tfWeight.textAlignment = NSTextAlignmentLeft;
        _tfWeight.textColor = COLOR_333;
        _tfWeight.borderStyle = UITextBorderStyleNone;
        _tfWeight.backgroundColor = [UIColor clearColor];
        _tfWeight.delegate = self;
        _tfWeight.contentType = ENUM_TEXT_CONTENT_TYPE_PRICE;
        [_tfWeight addTarget:self action:@selector(priceChange) forControlEvents:UIControlEventEditingChanged];
//        _tfWeight.placeholder = @"";
    }
    return _tfWeight;
}
- (UILabel *)labelPriceAll{
    if (!_labelPriceAll) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_RED;
        l.backgroundColor = [UIColor clearColor];
        _labelPriceAll = l;
        
    }
    return _labelPriceAll;
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelAutOrderListItem *)model{
    self.model = model;
    if (model.loadQty) {
        self.tfWeight.text = [model exchangeQtyShow:model.loadQty];
    }
    
    [self removeAllSubViews];//移除线
    //重置视图坐标
    {
        UIView * _viewBlackAlpha = [UIView new];
         _viewBlackAlpha.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
         _viewBlackAlpha.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addSubview:_viewBlackAlpha];
    }
    
      UIView * viewWhiteBG = [UIView new];
    self.viewWhitBG = viewWhiteBG;
          viewWhiteBG.backgroundColor = [UIColor whiteColor];
          viewWhiteBG.widthHeight = XY(SCREEN_WIDTH, W(480)+iphoneXBottomInterval);
          viewWhiteBG.bottom = SCREEN_HEIGHT;
          [viewWhiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:8 lineWidth:0 lineColor:[UIColor clearColor]];
          [self addSubview:viewWhiteBG];
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"提示" variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, W(20));
        [viewWhiteBG addSubview:l];
    }
    NSArray * aryBtn = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"运输路线：";
        NSString * strFrom = [NSString stringWithFormat:@"%@%@",UnPackStr(model.startCityName),UnPackStr(model.startCountyName)];
        NSString * strTo = [NSString stringWithFormat:@"%@%@",UnPackStr(model.endCityName),UnPackStr(model.endCountyName)];

        m.subTitle = [NSString stringWithFormat:@"%@ 至 %@",strFrom,strTo];
        m.colorSelect = nil;
        m.left = W(72);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"车牌号码：";
        m.subTitle = self.modelCarInfo.plateNumber;
        m.colorSelect = nil;
        m.left = W(107);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"剩余量：";
        m.subTitle = [NSString stringWithFormat:@"剩%@%@",model.remainShow,model.unitShow];
        m.colorSelect = COLOR_RED;
        m.left = W(142);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"运输量：";
        m.subTitle = model.unitShow;
        m.colorSelect = nil;
        m.left = W(177);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"合计运费：";
        m.subTitle = nil;
        m.colorSelect = COLOR_RED;
        m.left = W(212);
        return m;
    }()];
    
    [self addLabelAry:aryBtn superView:viewWhiteBG];
    {
        CGFloat unitDistance = [UILabel fetchWidthFontNum:F(15) text:model.unitShow]-[UILabel fetchWidthFontNum:F(15) text:@"米"];
        UIView * viewBorder = [viewWhiteBG generateBorder:CGRectMake(W(248) - unitDistance , W(168), W(88), W(33))];
        [viewBorder addTarget:self action:@selector(weightClick)];
        self.tfWeight.widthHeight = XY(viewBorder.width - W(12),viewBorder.height);
        self.tfWeight.leftCenterY = XY(viewBorder.left + W(10),viewBorder.centerY);
        [self.tfWeight removeFromSuperview];
        [viewWhiteBG addSubview:self.tfWeight];
    }
    {
        [viewWhiteBG addSubview:self.labelPriceAll];
        [self priceChange];
    }
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(157), W(39));
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(15);
        [btn setTitleColor:COLOR_666 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnDismissClick) forControlEvents:UIControlEventTouchUpInside];
        btn.leftTop = XY(W(20), W(252));
        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:1 lineColor:COLOR_BORDER];
        [viewWhiteBG addSubview:btn];
    }
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(157), W(39));
        btn.backgroundColor = COLOR_ORANGE;
        [btn setTitle:@"确认抢单" forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(15);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnConfirmClick) forControlEvents:UIControlEventTouchUpInside];
        btn.rightTop = XY(SCREEN_WIDTH - W(20), W(252));
        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:0 lineColor:COLOR_BORDER];
        [viewWhiteBG addSubview:btn];
    }
    
    [viewWhiteBG addLineFrame:CGRectMake(W(20), W(316), SCREEN_WIDTH - W(40), 1)];
    
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(8);
        [l fitTitle:@"说明：\n1、运输量将根据车辆荷载自动分配，也可手动修改\n2、平台将收取5%（且最高不超过50元）的平台服务费\n3、实际所得费用为实际运输量计算费用减去平台服务费\n4、抢单成功后取消会收取一定比例违约金及信用评分影响。" variable:SCREEN_WIDTH - W(40)];
        l.leftTop = XY(W(20), W(343));
        [viewWhiteBG addSubview:l];
    }
    {
        if ([model.unitShow isEqualToString: @"吨"]||[model.unitShow isEqualToString: @"立方米"]) {
            self.tfWeight.contentType = ENUM_TEXT_CONTENT_TYPE_NUM_3;
        }else{
            self.tfWeight.contentType = ENUM_TEXT_CONTENT_TYPE_NUMBER;
        }
    }
    if ([model.unitShow isEqualToString:@"车"]) {
        self.tfWeight.text = @"1";
        [self priceChange];
        self.tfWeight.userInteractionEnabled = false;
    }
}
- (void)addLabelAry:(NSArray *)ary superView:(UIView *)superView{
    for (ModelBtn *m in ary) {
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:m.title variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(20), m.left);
            [superView addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = m.colorSelect?m.colorSelect:COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:m.subTitle variable: W(250)];
            l.rightTop = XY(SCREEN_WIDTH - W(20), m.left);
            [superView addSubview:l];
        }
    }
 
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        self.height = SCREEN_HEIGHT;
        [self addTarget:self action:@selector(endClick)];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification  object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification  object:nil];

    }
    return self;
}
- (void)keyboardShow:(NSNotification *)notice{
    [UIView animateWithDuration:0.3 animations:^{
        self.viewWhitBG.bottom = SCREEN_HEIGHT - W(80);
    }];
}

- (void)keyboardHide:(NSNotification *)notice{
    [UIView animateWithDuration:0.3 animations:^{
        self.viewWhitBG.bottom = SCREEN_HEIGHT;
    }];
}
#pragma mark text delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)weightClick{
    if ([self.model.unitShow isEqualToString:@"车"]) {
    
    }else{
        [self.tfWeight becomeFirstResponder];
    }
}
- (void)priceChange{
    NSString * price = nil;
    if (self.tfWeight.text.doubleValue) {
        price = [NSNumber bigDecimal:self.model.unitPrice divide:100 multiply:self.tfWeight.text.doubleValue];
    }
    [self.labelPriceAll fitTitle:[NSString stringWithFormat:@"%@元",price?:@"0"] variable:0];
    self.labelPriceAll.rightTop = XY(SCREEN_WIDTH - W(20),W(212));
}

- (void)endClick{
    [GlobalMethod endEditing];
}
- (void)btnDismissClick{
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}
- (void)btnConfirmClick{
    if (self.tfWeight.text.doubleValue == 0) {
        [GlobalMethod showAlert:@"请输入数量"];
        return;
    }
    if (self.blockConfirm) {
        self.blockConfirm(self.tfWeight.text.doubleValue, self.labelPriceAll.text.doubleValue);
    }
    [self btnDismissClick];
}
@end


@interface AutoConfigOfferPriceView ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *tfWeight;
@property (nonatomic, strong) UITextField *tfPrice;
@property (nonatomic, strong) UIView *viewWhitBG;

@end

@implementation AutoConfigOfferPriceView
- (UITextField *)tfWeight{
    if (_tfWeight == nil) {
        _tfWeight = [UITextField new];
        _tfWeight.font = [UIFont systemFontOfSize:F(15)];
        _tfWeight.textAlignment = NSTextAlignmentLeft;
        _tfWeight.textColor = COLOR_333;
        _tfWeight.borderStyle = UITextBorderStyleNone;
        _tfWeight.backgroundColor = [UIColor clearColor];
        _tfWeight.delegate = self;
        _tfWeight.contentType = ENUM_TEXT_CONTENT_TYPE_PRICE;
//        _tfWeight.placeholder = @"";
    }
    return _tfWeight;
}
- (UITextField *)tfPrice{
    if (_tfPrice == nil) {
        _tfPrice = [UITextField new];
        _tfPrice.font = [UIFont systemFontOfSize:F(15)];
        _tfPrice.textAlignment = NSTextAlignmentLeft;
        _tfPrice.textColor = COLOR_333;
        _tfPrice.borderStyle = UITextBorderStyleNone;
        _tfPrice.backgroundColor = [UIColor clearColor];
        _tfPrice.delegate = self;
        _tfPrice.contentType = ENUM_TEXT_CONTENT_TYPE_PRICE;
//        _tfPrice.placeholder = @"";
    }
    return _tfPrice;
}
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelAutOrderListItem *)model{
    self.model = model;
    if (model.loadQty) {
        self.tfWeight.text = [model exchangeQtyShow:model.loadQty];
    }
    [self removeAllSubViews];//移除线
    //重置视图坐标
    {
        UIView * _viewBlackAlpha = [UIView new];
         _viewBlackAlpha.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
         _viewBlackAlpha.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addSubview:_viewBlackAlpha];
    }
    
      UIView * viewWhiteBG = [UIView new];
    self.viewWhitBG = viewWhiteBG;
          viewWhiteBG.backgroundColor = [UIColor whiteColor];
          viewWhiteBG.widthHeight = XY(SCREEN_WIDTH, W(480)+iphoneXBottomInterval);
          viewWhiteBG.bottom = SCREEN_HEIGHT;
          [viewWhiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:8 lineWidth:0 lineColor:[UIColor clearColor]];
          [self addSubview:viewWhiteBG];
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"提示" variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, W(20));
        [viewWhiteBG addSubview:l];
    }
    NSArray * aryBtn = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"运输路线：";
        NSString * strFrom = [NSString stringWithFormat:@"%@%@",UnPackStr(model.startCityName),UnPackStr(model.startCountyName)];
        NSString * strTo = [NSString stringWithFormat:@"%@%@",UnPackStr(model.endCityName),UnPackStr(model.endCountyName)];

        m.subTitle = [NSString stringWithFormat:@"%@ 至 %@",strFrom,strTo];
        m.colorSelect = nil;
        m.left = W(72);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"车牌号码：";
        m.subTitle = self.modelCarInfo.plateNumber;
        m.colorSelect = nil;
        m.left = W(107);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"剩余量：";
        m.subTitle = [NSString stringWithFormat:@"剩%@%@",model.remainShow,model.unitShow];
        m.colorSelect = COLOR_RED;
        m.left = W(142);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"运输量：";
        m.subTitle = model.unitShow;
        m.colorSelect = nil;
        m.left = W(177);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"运费报价：";
        m.subTitle = @"元";
        m.colorSelect = nil;
        m.left = W(220);
        return m;
    }()];
    [self addLabelAry:aryBtn superView:viewWhiteBG];
    {
        CGFloat unitDistance = [UILabel fetchWidthFontNum:F(15) text:model.unitShow]-[UILabel fetchWidthFontNum:F(15) text:@"米"];
        UIView * viewBorder = [viewWhiteBG generateBorder:CGRectMake(W(248)-unitDistance, W(168), W(88), W(33))];
        [viewBorder addTarget:self action:@selector(weightClick)];
        self.tfWeight.widthHeight = XY(viewBorder.width - W(12),viewBorder.height);
        self.tfWeight.leftCenterY = XY(viewBorder.left + W(10),viewBorder.centerY);
        [self.tfWeight removeFromSuperview];
        [viewWhiteBG addSubview:self.tfWeight];
    }
    {
           UIView * viewBorder = [viewWhiteBG generateBorder:CGRectMake(W(248), W(211), W(88), W(33))];
           [viewBorder addTarget:self action:@selector(priceClick)];
           self.tfPrice.widthHeight = XY(viewBorder.width - W(12),viewBorder.height);
           self.tfPrice.leftCenterY = XY(viewBorder.left + W(10),viewBorder.centerY);
        [self.tfPrice removeFromSuperview];
           [viewWhiteBG addSubview:self.tfPrice];
       }
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(157), W(39));
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(15);
        [btn setTitleColor:COLOR_666 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnDismissClick) forControlEvents:UIControlEventTouchUpInside];
        btn.leftTop = XY(W(20), W(269));
        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:1 lineColor:COLOR_BORDER];
        [viewWhiteBG addSubview:btn];
    }
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(157), W(39));
        btn.backgroundColor = COLOR_BLUE;
        [btn setTitle:@"确认报价" forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(15);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnConfirmClick) forControlEvents:UIControlEventTouchUpInside];
        btn.rightTop = XY(SCREEN_WIDTH - W(20), W(269));
        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:0 lineColor:COLOR_BORDER];
        [viewWhiteBG addSubview:btn];
    }
    
    [viewWhiteBG addLineFrame:CGRectMake(W(20), W(333), SCREEN_WIDTH - W(40), 1)];
    
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(8);
        [l fitTitle:@"说明：\n1、运输量请结合您车的实际荷载量填写报价\n2、平台将收取5%（且最高不超过50元）\n3、实际所得费用为实际运输量计算费用减去" variable:SCREEN_WIDTH - W(40)];
        l.leftTop = XY(W(20), W(360));
        [viewWhiteBG addSubview:l];
    }
    {
        if ([model.unitShow isEqualToString: @"吨"]||[model.unitShow isEqualToString: @"立方米"]) {
            self.tfWeight.contentType = ENUM_TEXT_CONTENT_TYPE_NUM_3;
        }else{
            self.tfWeight.contentType = ENUM_TEXT_CONTENT_TYPE_NUMBER;
        }
    }
    if ([model.unitShow isEqualToString:@"车"]) {
        self.tfWeight.text = @"1";
        self.tfWeight.userInteractionEnabled = false;
    }
}
- (void)addLabelAry:(NSArray *)ary superView:(UIView *)superView{
    for (ModelBtn *m in ary) {
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:m.title variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(20), m.left);
            [superView addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = m.colorSelect?m.colorSelect:COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:m.subTitle variable: W(250)];
            l.rightTop = XY(SCREEN_WIDTH - W(20), m.left);
            [superView addSubview:l];
        }
    }
 
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        self.height = SCREEN_HEIGHT;
        [self addTarget:self action:@selector(endClick)];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification  object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification  object:nil];

    }
    return self;
}
- (void)keyboardShow:(NSNotification *)notice{
    [UIView animateWithDuration:0.3 animations:^{
        self.viewWhitBG.bottom = SCREEN_HEIGHT - W(80);
    }];
}

- (void)keyboardHide:(NSNotification *)notice{
    [UIView animateWithDuration:0.3 animations:^{
        self.viewWhitBG.bottom = SCREEN_HEIGHT;
    }];
}
#pragma mark text delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)weightClick{
    if ([self.model.unitShow isEqualToString:@"车"]) {
    
    }else{
        [self.tfWeight becomeFirstResponder];
    }
    
}

- (void)priceClick{
    [self.tfPrice becomeFirstResponder];
}
- (void)endClick{
    [GlobalMethod endEditing];
}
- (void)btnDismissClick{
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}
- (void)btnConfirmClick{
    if (self.tfWeight.text.doubleValue == 0) {
        [GlobalMethod showAlert:@"请输入数量"];
        return;
    }
    if (self.blockConfirm) {
        self.blockConfirm(self.tfWeight.text.doubleValue, self.tfPrice.text.doubleValue);
    }
    [self btnDismissClick];
}
@end
