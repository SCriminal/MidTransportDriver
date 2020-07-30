//
//  CarListCell.m
//  Driver
//
//  Created by 隋林栋 on 2020/5/29.
//Copyright © 2020 ping. All rights reserved.
//

#import "CarListCell.h"
#import "AddCarVC.h"
#import "BulkCargoListCell.h"

@implementation CarListCell
#pragma mark 懒加载
- (UILabel *)carNumber{
    if (_carNumber == nil) {
        _carNumber = [UILabel new];
        _carNumber.textColor = COLOR_333;
        _carNumber.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightMedium];
    }
    return _carNumber;
}
- (UIImageView *)deleteIcon{
    if (_deleteIcon == nil) {
        _deleteIcon = [UIImageView new];
        _deleteIcon.image = [UIImage imageNamed:@"car_delete"];
        _deleteIcon.widthHeight = XY(W(25),W(25));
    }
    return _deleteIcon;
}
- (UIImageView *)editIcon{
    if (_editIcon == nil) {
        _editIcon = [UIImageView new];
        _editIcon.image = [UIImage imageNamed:@"car_edit"];
        _editIcon.widthHeight = XY(W(25),W(25));
    }
    return _editIcon;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.carNumber];
        [self.contentView addSubview:self.deleteIcon];
        [self.contentView addSubview:self.editIcon];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCar *)model{
    self.model = model;
    
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.carNumber fitTitle:UnPackStr(model.vehicleNumber) variable:W(260)];
    self.carNumber.leftTop = XY(W(15),W(20));
    
    CGFloat top = 0;
    __block int tag = 100;
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"车所有人";
        m.subTitle = model.vehicleOwner;
        m.tag = ++tag;
        m.left = W(15);
        m.right = W(15);
        return m;
    }() view:self.contentView top:self.carNumber.bottom + W(20)];

    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"核定载质量";
        m.subTitle = NSNumber.dou(model.vehicleLoad).stringValue;
        m.tag = ++tag;
        m.left = W(15);
        m.right = W(15);
        return m;
    }() view:self.contentView top:top + W(15)];

    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"当前状态";
        m.subTitle = model.authStatusShow;
        m.color = model.authStatusColorShow;
        m.tag = ++tag;
        m.left = W(15);
        m.right = W(15);
        return m;
    }() view:self.contentView top:top + W(15)];

    
    self.deleteIcon.rightCenterY = XY(SCREEN_WIDTH -  W(15),self.carNumber.centerY);
   UIView * view = [self.contentView addControlFrame:CGRectInset(self.deleteIcon.frame, -W(10), -W(10)) belowView:self.deleteIcon target:self action:@selector(deleteClick)];
    view.tag = TAG_LINE;
    
    self.editIcon.rightCenterY = XY(self.deleteIcon.left - W(20),self.carNumber.centerY);
    self.editIcon.hidden = self.model.qualificationState != 10;
    if (!self.editIcon.hidden) {
         view = [self.contentView addControlFrame:CGRectInset(self.editIcon.frame, -W(10), -W(10)) belowView:self.editIcon target:self action:@selector(editClick)];
        view.tag = TAG_LINE;
    }
    
    //设置总高度
    self.height = top + W(20);

    [self.contentView addLineFrame:CGRectMake(0, self.height -1, SCREEN_WIDTH, 1)];
}

#pragma mark click
- (void)deleteClick{
    WEAKSELF
    ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
    ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
    modelConfirm.blockClick = ^(void){
        if (weakSelf.blockDelete) {
            weakSelf.blockDelete(weakSelf.model);
        }
    };
    [BaseAlertView initWithTitle:@"确认删除？" content:@"确认删除当前车辆" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:[UIApplication sharedApplication].keyWindow];
    
}
- (void)editClick{
    if (self.blockEdit) {
        self.blockEdit(self.model);
    }
}
@end
