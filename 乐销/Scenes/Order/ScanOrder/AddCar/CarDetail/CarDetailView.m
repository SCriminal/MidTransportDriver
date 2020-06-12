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

@implementation CarDetailStatusView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelCar *)modelDetail auditRecord:(ModelAuditRecord *)modelAudit{
    [self removeAllSubViews];//移除线
    NSString * strImageName = nil;
    NSString * strStatus = nil;
    
    switch ((int)modelDetail.qualificationState) {
        case 2://ing
        {
            strImageName = @"authority_audit";
            strStatus = @"车辆信息审核中";
            
        }
            break;
        case 3://success
        {
            strStatus = @"您的车辆信息已通过";
            strImageName = @"authority_succeed";
        }
            break;
        case 10://fail
        {
            strImageName = @"authority_defeated";
            strStatus = @"您的车辆信息审核失败";
        }
            break;
        default:
            break;
    }
    CGFloat top = 0;
    {
        
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:strImageName];
        iv.widthHeight = XY(W(100),W(100));
        iv.centerXTop = XY(SCREEN_WIDTH/2.0,top+W(40));
        [self addSubview:iv];
        top = iv.bottom;
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:[NSString stringWithFormat:@"%@",UnPackStr(strStatus)] variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0,top+W(25));
        [self addSubview:l];
        top = l.bottom;
    }
    if (modelDetail.qualificationState == 10)  {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        l.textColor = [UIColor redColor];
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(3);
        [l fitTitle:modelAudit.iDPropertyDescription variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, top+ W(20));
        l.textAlignment = NSTextAlignmentLeft;
        [self addSubview:l];
        top = l.bottom;
    }
    
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_999;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:[GlobalMethod exchangeTimeWithStamp:modelAudit.createTime andFormatter:TIME_MIN_SHOW] variable:0];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, top+ W(20));
        [self addSubview:l];
        top = l.bottom;
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"认证资料" variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0,top + W(40));
        [self addSubview:l];
        top = l.bottom;
        [self addLineFrame:CGRectMake(W(44.5), l.centerY, W(87), 1)];
        [self addLineFrame:CGRectMake(SCREEN_WIDTH - W(44.5) - W(87), l.centerY, W(87), 1)];
    }
    {
        top = [self addDetailSubView:@[^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"车牌号码";
            model.subTitle = modelDetail.vehicleNumber;
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"核定载质量";
            model.subTitle = modelDetail.vehicleLoad?[strDotF(modelDetail.vehicleLoad) stringByAppendingString:@"吨"]:@"暂无";
            
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"车拥有人";
            model.subTitle = modelDetail.vehicleOwner;
            
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"车辆类型";
            model.subTitle = [AddCarVC exchangeVehicleType:strDotF(modelDetail.vehicleType)];
            
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"牌照类型";
            model.subTitle = [AddCarVC exchangeLicenseType:strDotF(modelDetail.licenceType)];
            
            return model;
        }(),
//                                        ^(){
//            ModelBtn * model = [ModelBtn new];
//            model.title = @"车长";
//            model.subTitle =modelDetail.vehicleLength?[AddCarVC exchangeVehicleLength:strDotF(modelDetail.vehicleLength)]:@"暂无";
//            return model;
//        }(),
                                        ^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"档案编号";
            model.subTitle = modelDetail.drivingNumber;
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"运输证号";
            model.subTitle = modelDetail.roadTransportNumber;
            
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"总质量";
            model.subTitle = modelDetail.grossMass?[NSNumber.dou(modelDetail.grossMass).stringValue stringByAppendingString:@"kg"]:@"暂无";
            
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"车辆长度";
            NSString * strLength = modelDetail.length?[NSNumber.dou(modelDetail.length).stringValue stringByAppendingString:@"mm "]:@"";
            NSString * strWidth = modelDetail.weight?[NSNumber.dou(modelDetail.weight).stringValue stringByAppendingString:@"mm "]:@"";
            NSString * strHeight = modelDetail.height?[NSNumber.dou(modelDetail.height).stringValue stringByAppendingString:@"mm "]:@"";
            
            NSString * strAll = [NSString stringWithFormat:@"%@%@%@",strLength,strWidth,strHeight];
            model.subTitle = (modelDetail.length==0&&modelDetail.weight==0&&modelDetail.height==0)?@"暂无":strAll;
            
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"车轴数";
            model.subTitle = modelDetail.axle?NSNumber.dou(modelDetail.axle).stringValue:@"暂无";
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
            model.title = @"品牌型号";
            model.subTitle = modelDetail.model;
            
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"使用性质";
            model.subTitle = modelDetail.useCharacter;
            
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"能源类型";
            model.subTitle = [AddCarVC exchangeEnergeyType:strDotF(modelDetail.energyType)];
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"挂车号码";
            model.subTitle = modelDetail.trailerNumber;
            
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"拖车行驶证号";
            model.subTitle = modelDetail.vehicleLicense;
            
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"发证机关";
            model.subTitle = modelDetail.drivingAgency;
            
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"注册日期";
            model.subTitle = [GlobalMethod exchangeTimeWithStamp:modelDetail.drivingRegisterDate andFormatter:TIME_DAY_SHOW];
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"发证日期";
            model.subTitle = [GlobalMethod exchangeTimeWithStamp:modelDetail.drivingIssueDate andFormatter:TIME_DAY_SHOW];
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"有效日期";
            model.subTitle = [GlobalMethod exchangeTimeWithStamp:modelDetail.drivingEndDate andFormatter:TIME_DAY_SHOW];
            return model;
        }()] top:top+W(30) inView:self];
    }
    
    //设置总高度
    self.height = top;
}
- (CGFloat)addDetailSubView:(NSArray *)aryBtns top:(CGFloat)top inView:(UIView *)viewSuper{
  
    
    for (ModelBtn * model in aryBtns) {
        UILabel * labelTitle = [UILabel new];
        labelTitle.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        labelTitle.textColor = COLOR_666;
        labelTitle.numberOfLines = 1;
        [labelTitle fitTitle:[UnPackStr(model.title) stringByAppendingString:@"："] variable:SCREEN_WIDTH/2.0 - W(60)];
        labelTitle.leftTop = XY(W(45), top);
        [viewSuper addSubview:labelTitle];
        
        UILabel * labelSubTitle = [UILabel new];
        labelSubTitle.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        labelSubTitle.textColor = model.color?model.color:COLOR_666;
        labelSubTitle.numberOfLines = 0;
        labelSubTitle.lineSpace = W(3);
        [labelSubTitle fitTitle:isStr(model.subTitle)?model.subTitle:@"暂无" variable:SCREEN_WIDTH-labelTitle.width-W(80)];
        labelSubTitle.leftTop = XY(labelTitle.right, labelTitle.top);
        [viewSuper addSubview:labelSubTitle];
        
        top = MAX(labelTitle.bottom, labelSubTitle.bottom)+ W(20);
    }
    return top - W(20);
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


@end

@implementation CarDetailImageView

#pragma mark 刷新view
- (void)resetViewWithAryModels:(NSArray *)aryImages{
    [self removeAllSubViews];//移除线
    CGFloat left= W(40);
    CGFloat top = W(20);
    CGFloat bottom = 0;
    //重置视图坐标
    int i= 0;
    NSMutableArray * aryFilterImage = [NSMutableArray array];
    for (ModelImage *model in aryImages) {
        if (!isStr(model.url)) {
            continue;
        }
        [aryFilterImage addObject:model];
        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(left, top, W(67), W(50))];
        [iv sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:model.image];
        [GlobalMethod setRoundView:iv color:[UIColor clearColor] numRound:5 width:0];
        iv.tag = i;
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.userInteractionEnabled = true;
        [iv addTarget:self action:@selector(imageClick:)];
        [self addSubview:iv];
        left = iv.right +W(9);
        bottom = iv.bottom + W(15);
        if ((i+1)%4 ==0) {
            left = W(40);
            top = iv.bottom + W(12);
        }
        i ++;
    }
    self.aryImages = aryFilterImage;

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
