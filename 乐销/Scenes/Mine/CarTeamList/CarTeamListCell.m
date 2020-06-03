//
//  CarTeamListCell.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/11.
//Copyright © 2019 ping. All rights reserved.
//

#import "CarTeamListCell.h"

@interface CarTeamListCell ()
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) UILabel *labelCode;
@property (nonatomic, strong) UILabel *labelCopy;
@property (nonatomic, strong) UILabel *labelState;
@property (nonatomic, strong) UILabel *labelStatus;

@property (nonatomic, strong) UILabel *labelCarNum;

@end

@implementation CarTeamListCell
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        
    }
    return _labelTitle;
}
- (UILabel *)labelCode{
    if (_labelCode == nil) {
        _labelCode = [UILabel new];
        _labelCode.textColor = COLOR_333;
        _labelCode.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        
    }
    return _labelCode;
}
- (UILabel *)labelCopy{
    if (_labelCopy == nil) {
        _labelCopy = [UILabel new];
        _labelCopy.textColor = COLOR_666;
        _labelCopy.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        
    }
    return _labelCopy;
}
- (UILabel *)labelState{
    if (_labelState == nil) {
        _labelState = [UILabel new];
        _labelState.textColor = COLOR_666;
        _labelState.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
    }
    return _labelState;
}
- (UILabel *)labelStatus{
    if (_labelStatus == nil) {
        _labelStatus = [UILabel new];
        _labelStatus.textColor = COLOR_BLUE;
        _labelStatus.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        
    }
    return _labelStatus;
}
- (UILabel *)labelTime{
    if (_labelTime == nil) {
        _labelTime = [UILabel new];
        _labelTime.textColor = COLOR_666;
        _labelTime.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _labelTime;
}
- (UILabel *)labelCarNum{
    if (_labelCarNum == nil) {
        _labelCarNum = [UILabel new];
        _labelCarNum.textColor = COLOR_666;
        _labelCarNum.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _labelCarNum;
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
        [self.contentView addSubview:self.labelCarNum];
        [self.contentView addSubview:self.labelState];
        [self.contentView addSubview:self.labelStatus];
        [self.contentView addSubview:self.labelCode];
        [self.contentView addSubview:self.labelCopy];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelAttaceedCompany *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelTitle fitTitle:UnPackStr(model.nameShow) variable:W(250)];
    self.labelTitle.leftTop = XY(W(15),W(20));
    
    [self.labelCode fitTitle:[NSString stringWithFormat:@"企业码：%@",UnPackStr(model.codeShow)] variable:0];
    self.labelCode.leftTop = XY(self.labelTitle.left,self.labelTitle.bottom + W(13));

    [self.labelCopy fitTitle:@"点击复制" variable:0];
    self.labelCopy.rightCenterY = XY(SCREEN_WIDTH - W(15),self.labelTitle.centerY);

    [self.labelCarNum fitTitle:[NSString stringWithFormat:@"车牌号码：%@",isStr(model.vehicleNumber)?model.vehicleNumber:@"暂未绑定车辆"] variable:0];
    self.labelCarNum.leftTop = XY(self.labelTitle.left,self.labelCode.bottom + W(13));
    
    [self.labelState fitTitle:@"当前状态：" variable:0];
    self.labelState.leftTop = XY(self.labelTitle.left,self.labelCarNum.bottom+W(13));
    
    [self.labelStatus fitTitle:model.isAttached?@"已挂靠":@"已申请" variable:0];
    self.labelStatus.textColor = model.isAttached?COLOR_GREEN:COLOR_ORANGE;
    self.labelStatus.leftTop = XY(self.labelState.right,self.labelState.top);

    
    NSString * strTime = [NSString stringWithFormat:@"%@：%@",model.isAttached?@"绑定时间":@"申请时间",[GlobalMethod exchangeTimeWithStamp:model.isAttached?model.createTime:model.applyTime andFormatter:TIME_SEC_SHOW]];
    [self.labelTime fitTitle:strTime variable:0];
    self.labelTime.leftTop = XY(self.labelTitle.left,self.labelState.bottom+W(13));
    
//    self.labelTime.hidden = !model.isAttached;
    
    //设置总高度
    self.height = self.labelTime.hidden?self.labelStatus.bottom+W(20): self.labelTime.bottom +W(20);
    
    [self.contentView addLineFrame:CGRectMake(0, self.height -1, SCREEN_WIDTH, 1)];
}


@end
