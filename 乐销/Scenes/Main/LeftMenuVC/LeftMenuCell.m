//
//  LeftMenuCell.m
//  Driver
//
//  Created by 隋林栋 on 2018/11/30.
//Copyright © 2018 ping. All rights reserved.
//

#import "LeftMenuCell.h"

@interface LeftMenuCell ()

@end

@implementation LeftMenuCell
#pragma mark 懒加载
- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [UIImageView new];
        _icon.widthHeight = XY(W(25),W(25));
    }
    return _icon;
}
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


#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addTarget:self action:@selector(cellClick)];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model{
    self.model = model;
    
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.icon.image = [UIImage imageNamed:model.imageName];
    self.icon.leftTop = XY(W(35),W(25));
    
    [self.labelTitle fitTitle:model.title variable:0];
    self.labelTitle.leftCenterY = XY(self.icon.right + W(15),self.icon.centerY);
    
    self.height = self.icon.bottom + W(25);
}

#pragma mark click
- (void)cellClick{
    if (self.model.blockClick) {
        self.model.blockClick();
    }
}

@end
