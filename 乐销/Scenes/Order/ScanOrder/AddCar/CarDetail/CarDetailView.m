//
//  CarDetailView.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/12/3.
//Copyright © 2019 ping. All rights reserved.
//

#import "CarDetailView.h"
//exchange type
#import "AddCarVC.h"
//image detail
#import "ImageDetailBigView.h"

@implementation CarDetailView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelCar *)modelDetail{
    [self removeAllSubViews];//移除线
    //重置视图坐标
    CGFloat bottom =  [self addDetailSubView:@[^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"行驶证号";
        model.subTitle = modelDetail.vehicleLicense;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"当前状态";
        model.subTitle = modelDetail.authStatusShow;
        model.color = modelDetail.authStatusColorShow;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"车所有人";
        model.subTitle = modelDetail.vehicleOwner;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"关联司机";
        model.subTitle = [NSString stringWithFormat:@"%@ %@",modelDetail.driverName,modelDetail.driverPhone];
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"识别代码";
        model.subTitle = modelDetail.vin;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"发动机号";
        model.subTitle = modelDetail.engineNumber;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"挂车号码";
        model.subTitle = modelDetail.trailerNumber;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"车辆长度";
        model.subTitle = [NSString stringWithFormat:@"%@",[AddCarVC exchangeVehicleLength:strDotF(modelDetail.vehicleLength)]];
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"车辆类型";
        model.subTitle = [AddCarVC exchangeVehicleType:strDotF(modelDetail.vehicleType)];
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"标准载重";
        model.subTitle = [NSString stringWithFormat:@"%@吨",strDotF(modelDetail.vehicleLoad)];
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"车轴数";
        model.subTitle = strDotF(modelDetail.axle);
        return model;
    }(),] inView:self title:modelDetail.vehicleNumber];
    //设置总高度
    self.height = [self addLineFrame:CGRectMake(W(15), bottom, SCREEN_WIDTH - W(30), 1)];
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}
- (CGFloat)addDetailSubView:(NSArray *)aryBtns inView:(UIView *)viewSuper title:(NSString *)title{
    UILabel * labelTitle = [UILabel new];
    labelTitle.font = [UIFont systemFontOfSize:F(16) weight:UIFontWeightMedium];
    labelTitle.textColor = COLOR_333;
    labelTitle.numberOfLines = 1;
    [labelTitle fitTitle:UnPackStr(title) variable:SCREEN_WIDTH - W(30)];
    labelTitle.leftTop = XY(W(15), W(25));
    [viewSuper addSubview:labelTitle];
    CGFloat bottom = labelTitle.bottom + W(25);
    
    for (ModelBtn * model in aryBtns) {
        UILabel * labelTitle = [UILabel new];
        labelTitle.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        labelTitle.textColor = COLOR_666;
        labelTitle.numberOfLines = 1;
        [labelTitle fitTitle:UnPackStr(model.title) variable:SCREEN_WIDTH/2.0 - W(60)];
        labelTitle.leftTop = XY(W(15), bottom);
        [viewSuper addSubview:labelTitle];
        
        UILabel * labelSubTitle = [UILabel new];
        labelSubTitle.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        labelSubTitle.textColor = model.color?model.color:COLOR_666;
        labelSubTitle.numberOfLines = 1;
        [labelSubTitle fitTitle:UnPackStr(model.subTitle) variable:SCREEN_WIDTH/2.0 + W(25)];
        labelSubTitle.rightCenterY = XY(SCREEN_WIDTH - W(15), labelTitle.centerY);
        [viewSuper addSubview:labelSubTitle];
        
        bottom = labelTitle.bottom + W(20);
    }
    return bottom+ W(5);
}


@end


@implementation CarDetailImageView

#pragma mark 刷新view
- (void)resetViewWithAryModels:(NSArray *)aryImages{
    self.aryImages = aryImages;
    [self removeAllSubViews];//移除线
    CGFloat left= W(15);
    CGFloat top = W(24);
    CGFloat bottom = 0;
    //重置视图坐标
    for (int i = 0; i<aryImages.count; i++) {
        ModelImage *model = aryImages[i];
        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(left, top, W(107), W(90))];
        [iv sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:model.image];
        [GlobalMethod setRoundView:iv color:[UIColor clearColor] numRound:5 width:0];
        iv.tag = i;
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.userInteractionEnabled = true;
        [iv addTarget:self action:@selector(imageClick:)];
        [self addSubview:iv];
        left = iv.right +W(12);
        bottom = iv.bottom + W(25);
        if ((i+1)%3 ==0) {
            left = W(15);
            top = iv.bottom + W(12);
        }
    }
    self.height = bottom;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}

#pragma mark click
- (void)imageClick:(UITapGestureRecognizer *)tap{
    UIImageView * view = (UIImageView *)tap.view;
    if (![view isKindOfClass:UIImageView.class]) {
        return;
    }
    ImageDetailBigView * detailView = [ImageDetailBigView new];
    [detailView resetView:self.aryImages.mutableCopy isEdit:false index: view.tag];
    [detailView showInView:[GB_Nav.lastVC view] imageViewShow:view];
}
@end
