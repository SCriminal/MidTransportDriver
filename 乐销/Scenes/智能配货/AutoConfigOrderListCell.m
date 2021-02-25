//
//  AutoConfigOrderListCell.m
//  Driver
//
//  Created by 隋林栋 on 2020/11/27.
//Copyright © 2020 ping. All rights reserved.
//

#import "AutoConfigOrderListCell.h"
//order detail vc
#import "OrderDetailVC.h"
//request
#import "RequestApi+Order.h"
#import "NSDate+YYAdd.h"

@interface AutoConfigOrderListCell ()

@end

@implementation AutoConfigOrderListCell

#pragma mark 懒加载
- (AutoNewsView *)newsView{
    if (!_newsView) {
        _newsView = [AutoNewsView new];
    }
    return _newsView;
}
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
        _viewBG.width = SCREEN_WIDTH;
    }
    return _viewBG;
}
- (UILabel *)addressFrom{
    if (_addressFrom == nil) {
        _addressFrom = [UILabel new];
        _addressFrom.textColor = COLOR_333;
        _addressFrom.numberOfLines = 1;
        _addressFrom.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
    }
    return _addressFrom;
}
- (UILabel *)addressTo{
    if (_addressTo == nil) {
        _addressTo = [UILabel new];
        _addressTo.textColor = COLOR_333;
        _addressTo.numberOfLines = 1;
        _addressTo.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
    }
    return _addressTo;
}
- (UIImageView *)iconAddress{
    if (_iconAddress == nil) {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"right_balck"];
        iv.widthHeight = XY(W(17),W(17));
        _iconAddress = iv;
    }
    return _iconAddress;
}
#pragma mark 懒加载
- (UILabel *)goodsInfo{
    if (_goodsInfo == nil) {
        _goodsInfo = [UILabel new];
        _goodsInfo.textColor = COLOR_333;
        _goodsInfo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _goodsInfo;
}
- (UILabel *)goodsName{
    if (_goodsName == nil) {
        _goodsName = [UILabel new];
        _goodsName.textColor = COLOR_666;
        _goodsName.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _goodsName;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_666;
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _time;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = COLOR_666;
        _price.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _price;
}
- (UILabel *)distance{
    if (_distance == nil) {
        _distance = [UILabel new];
        _distance.textColor = COLOR_666;
        _distance.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _distance;
}
- (AutoConfigTimeView *)timeView{
    if (!_timeView) {
        _timeView = [AutoConfigTimeView new];
        WEAKSELF
        _timeView.blockOutTime = ^{
            if (weakSelf.blockOutTime) {
                weakSelf.blockOutTime(weakSelf);
            }
        };
        _timeView.blockClick = ^{
            if (weakSelf.blockDetail) {
                weakSelf.blockDetail(weakSelf.model);
            }
        };
        [_timeView resetView:1];
    }
    return _timeView;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTimer) name:NOTICE_AUTOORDERLIST_REFERSH object:nil];

        self.contentView.backgroundColor = COLOR_BACKGROUND;
        self.backgroundColor = COLOR_BACKGROUND;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = false;
        [self.contentView addSubview:self.viewBG];
        [self.contentView addSubview:self.newsView];
        [self.contentView addSubview:self.addressFrom];
        [self.contentView addSubview:self.addressTo];
        [self.contentView addSubview:self.iconAddress];
        [self.contentView addSubview:self.goodsInfo];
        [self.contentView addSubview:self.goodsName];
        [self.contentView addSubview:self.time];
        [self.contentView addSubview:self.price];
        [self.contentView addSubview:self.distance];
        [self.contentView addSubview:self.timeView];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelAutOrderListItem *)model{
    self.model = model;
       //刷新view
       self.iconAddress.centerXTop = XY(SCREEN_WIDTH/2.0, W(20));
       
       [self.addressFrom fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.startCityName),UnPackStr(model.startCountyName)] variable:W(160)];
       self.addressFrom.centerXCenterY = XY((self.iconAddress.left - W(10))/2.0+W(10), self.iconAddress.centerY);
    [self.addressTo fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.endCityName),UnPackStr(model.endCountyName)] variable:W(160)];

       self.addressTo.centerXCenterY = XY((SCREEN_WIDTH - self.iconAddress.right - W(10))/2.0 + SCREEN_WIDTH/2.0 + self.iconAddress.width/2.0, self.iconAddress.centerY);
       
    CGFloat top = self.addressTo.bottom + W(18);
    self.newsView.hidden = true;
    if (isStr(model.comment)) {
        self.newsView.hidden = false;
        self.newsView.centerXTop = XY(SCREEN_WIDTH/2.0, top);
        [self.newsView resetWithAry:@[model.comment]];
        top = self.newsView.bottom + W(18);
    }
  
    {
        NSString * strRemain = [NSString stringWithFormat:@"（剩%@%@）",model.remainShow,model.unitShow];
        [self.goodsInfo fitTitle:[NSString stringWithFormat:@"%@%@%@%@%@",model.qtyShow,model.unitShow,strRemain,isStr(model.vehicleDescription)?@"/":@"",UnPackStr(model.vehicleDescription)] variable:SCREEN_WIDTH - W(30)];
        
        NSMutableAttributedString * strAttribute = [[NSMutableAttributedString alloc]initWithString:self.goodsInfo.text];
        [strAttribute setAttributes:@{NSForegroundColorAttributeName : COLOR_333,        NSFontAttributeName :  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular]} range:NSMakeRange(0, strAttribute.length)];
        [strAttribute setAttributes:@{NSForegroundColorAttributeName : COLOR_RED,        NSFontAttributeName :  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular]} range:[self.goodsInfo.text rangeOfString:strRemain]];
        self.goodsInfo.attributedText = strAttribute;
        self.goodsInfo.leftTop = XY(W(15), top);
        top = self.goodsInfo.bottom;
    }
    
    [self.goodsName fitTitle:[NSString stringWithFormat:@"%@ %@",isStr(model.cargoName)?model.cargoName:@"暂无货物名称",UnPackStr(model.internalBaseClassDescription)] variable:SCREEN_WIDTH/2.0-W(15)];
      self.goodsName.leftTop = XY(W(15),top+ W(11));
    [self.time fitTitle:[GlobalMethod exchangeTimeStampToDate:model.createTime].timeAgoShow variable:SCREEN_WIDTH/2.0 -W(15)];
      self.time.rightTop = XY(SCREEN_WIDTH - W(15),top+ W(11));
    top = self.time.bottom;
    
    {
        NSString * str1 = @"单价：";
        NSString * str2 = nil;
        if (self.model.mode == 2) {//1 抢单 2 报价
            str2 = @"待报价";
        }else{
            str2 = [NSString stringWithFormat:@"%@元/%@",model.priceShow,model.unitShow];
        }
        [self.price fitTitle:[NSString stringWithFormat:@"%@%@",str1,str2] variable:SCREEN_WIDTH/2.0 -W(15)];
        NSMutableAttributedString * strAttribute = [[NSMutableAttributedString alloc]initWithString:self.price.text];
               [strAttribute setAttributes:@{NSForegroundColorAttributeName : COLOR_666,        NSFontAttributeName :  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular]} range:NSMakeRange(0, strAttribute.length)];
               [strAttribute setAttributes:@{NSForegroundColorAttributeName : COLOR_RED,        NSFontAttributeName :  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular]} range:[self.price.text rangeOfString:str2]];
               self.price.attributedText = strAttribute;
               self.price.leftTop = XY(W(15), top+ W(11));
    }
    [self.distance fitTitle:isStr(model.distanceShow)?[NSString stringWithFormat:@"约%@装货",model.distanceShow]:@"暂无距离" variable:SCREEN_WIDTH/2.0 -W(15)];
      self.distance.rightTop = XY(SCREEN_WIDTH - W(15),top+ W(11));
    top = self.distance.bottom;
      
    self.timeView.date = model.dateStart;
    self.timeView.centerXTop = XY(SCREEN_WIDTH/2.0, top + W(20));
    [self.timeView resetView:self.model.mode];
    [self.timeView resetTime];
    self.viewBG.height = self.timeView.bottom + W(15);
         //设置总高度
    self.height = self.viewBG.bottom + W(12);
//    NSLog(@"sld height:%lf",self.height);
}
- (void)refreshTimer{
    [self.timeView resetTime];
}
#pragma mark 销毁
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end



@implementation AutoConfigOrderListAutoFilterView
#pragma mark 懒加载
- (UILabel *)addressFrom{
    if (_addressFrom == nil) {
        _addressFrom = [UILabel new];
        _addressFrom.textColor = COLOR_666;
        _addressFrom.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        _addressFrom.textAlignment = NSTextAlignmentCenter;
    }
    return _addressFrom;
}
- (UILabel *)addressTo{
    if (_addressTo == nil) {
        _addressTo = [UILabel new];
        _addressTo.textColor = COLOR_666;
        _addressTo.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        _addressTo.textAlignment = NSTextAlignmentCenter;
    }
    return _addressTo;
}
- (UILabel *)labelAuto{
    if (_labelAuto == nil) {
        _labelAuto = [UILabel new];
        _labelAuto.textColor = COLOR_666;
        _labelAuto.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
    }
    return _labelAuto;
}
- (UILabel *)filter{
    if (_filter == nil) {
        _filter = [UILabel new];
        _filter.textColor = COLOR_666;
        _filter.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
    }
    return _filter;
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
    [self addSubview:self.addressTo];
        [self addSubview:self.addressFrom];
    [self addSubview:self.labelAuto];
    [self addSubview:self.filter];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.height = W(50);
    //刷新view
    {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        view.widthHeight = XY(W(64), W(34));
        view.leftTop = XY(W(15), W(8));
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:3 lineWidth:0 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
        [self insertSubview:view belowSubview:self.addressTo];
        
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"arrow_down_gray"];
        iv.widthHeight = XY(W(9),W(9));
        iv.rightCenterY = XY(view.right - W(9),view.centerY);
        [self addSubview:iv];
        
        self.addressFrom.width =  W(46);
        self.addressFrom.height = view.height;
        self.addressFrom.leftCenterY = view.leftCenterY;
        self.addressFrom.text = @"起点";
        
        [view addTarget:self action:@selector(fromClick)];

    }
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"right_gray"];
        iv.widthHeight = XY(W(14),W(14));
        iv.leftCenterY = XY(W(85),self.height/2.0);
        [self addSubview:iv];
    }
    {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        view.widthHeight = XY(W(64), W(34));
        view.leftTop = XY(W(105), W(8));
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:3 lineWidth:0 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
        [self insertSubview:view belowSubview:self.addressTo];
        
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"arrow_down_gray"];
        iv.widthHeight = XY(W(9),W(9));
        iv.rightCenterY = XY(view.right - W(9),view.centerY);
        [self addSubview:iv];
        
        self.addressTo.width =  W(46);
        self.addressTo.height = view.height;
        self.addressTo.leftCenterY = view.leftCenterY;
        self.addressTo.text = @"终点" ;

        [view addTarget:self action:@selector(toClick)];

    }

    {
           UIView * view = [UIView new];
           view.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
           view.widthHeight = XY(W(64), W(34));
           view.leftTop = XY(W(179), W(8));
           [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:3 lineWidth:0 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
           [self insertSubview:view belowSubview:self.addressTo];
           
           UIImageView * iv = [UIImageView new];
           iv.backgroundColor = [UIColor clearColor];
           iv.contentMode = UIViewContentModeScaleAspectFill;
           iv.clipsToBounds = true;
           iv.image = [UIImage imageNamed:@"arrow_down_gray"];
           iv.widthHeight = XY(W(9),W(9));
           iv.rightCenterY = XY(view.right - W(9),view.centerY);
           [self addSubview:iv];
           
               [self.labelAuto fitTitle:@"智能" variable:W(40)];
           self.labelAuto.leftCenterY = XY(W(view.left + W(9)),view.centerY);
           
           [view addTarget:self action:@selector(autoClick)];

       }
    
    {
              UIView * view = [UIView new];
              view.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
              view.widthHeight = XY(W(64), W(34));
              view.leftTop = XY(W(253), W(8));
              [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:3 lineWidth:0 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
              [self insertSubview:view belowSubview:self.addressTo];
              
              UIImageView * iv = [UIImageView new];
              iv.backgroundColor = [UIColor clearColor];
              iv.contentMode = UIViewContentModeScaleAspectFill;
              iv.clipsToBounds = true;
              iv.image = [UIImage imageNamed:@"arrow_down_gray"];
              iv.widthHeight = XY(W(9),W(9));
              iv.rightCenterY = XY(view.right - W(9),view.centerY);
              [self addSubview:iv];
              
                  [self.filter fitTitle:@"筛选" variable:W(40)];
              self.filter.leftCenterY = XY(W(view.left + W(9)),view.centerY);
              
              [view addTarget:self action:@selector(filterClick)];

          }
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"voice"];
        iv.widthHeight = XY(W(23),W(23));
        iv.rightCenterY = XY(SCREEN_WIDTH - W(15),self.height/2.0);
        [self addSubview:iv];
        
        [self addControlFrame:CGRectInset(iv.frame, -W(20), -W(20)) belowView:iv target:self action:@selector(voiceClick)];
    }
    //设置总高度
}

- (void)fromClick{
    if (self.blockStart) {
        self.blockStart();
    }
}
- (void)toClick{
    if (self.blockEnd) {
        self.blockEnd();
    }
}
- (void)autoClick{
    if (self.blockAuto) {
        self.blockAuto();
    }
}
- (void)filterClick{
    if (self.blockFilter) {
        self.blockFilter();
    }
}
- (void)voiceClick{
    if (self.blockVoice) {
        self.blockVoice();
    }
}

- (void)reconfigStart:(ModelProvince *)start{
    self.addressFrom.text = isStr(start.name)? start.name:@"起点";
}
- (void)reconfigEnd:(ModelProvince *)end{
    self.addressTo.text = isStr(end.name)? end.name:@"终点";

}

@end
