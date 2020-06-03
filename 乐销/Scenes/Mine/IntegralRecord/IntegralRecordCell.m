//
//  IntegralRecordCell.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/11.
//Copyright © 2019 ping. All rights reserved.
//

#import "IntegralRecordCell.h"

@interface IntegralRecordCell ()
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) UILabel *labelIntegral;

@end

@implementation IntegralRecordCell
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];

    }
    return _labelTitle;
}
- (UILabel *)labelTime{
    if (_labelTime == nil) {
        _labelTime = [UILabel new];
        _labelTime.textColor = COLOR_666;
        _labelTime.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
    }
    return _labelTime;
}
- (UILabel *)labelIntegral{
    if (_labelIntegral == nil) {
        _labelIntegral = [UILabel new];
        _labelIntegral.textColor = COLOR_333;
        _labelIntegral.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
    }
    return _labelIntegral;
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
        [self.contentView addSubview:self.labelIntegral];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelTitle fitTitle:@"购买周边服务-免费交通限时活1交通限时活1" variable:W(250)];
    self.labelTitle.leftTop = XY(W(15),W(20));
    [self.labelTime fitTitle:@"2019-03-14  12:20:19" variable:0];
    self.labelTime.leftTop = XY(self.labelTitle.left,self.labelTitle.bottom+W(15));
    
    //设置总高度
    self.height = self.labelTime.bottom +W(20);
    
    [self.labelIntegral fitTitle:@"+200" variable:0];
    self.labelIntegral.rightCenterY = XY(SCREEN_WIDTH - W(15),self.height/2.0);
    
    [self.contentView addLineFrame:CGRectMake(0, self.height -1, SCREEN_WIDTH, 1)];
}

@end
