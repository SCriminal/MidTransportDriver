//
//  SelectAddressCell.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "SelectAddressCell.h"

@interface SelectAddressCell ()

@end

@implementation SelectAddressCell
#pragma mark 懒加载
-(UIButton *)btnEdit{
    if (_btnEdit == nil) {
        _btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnEdit addTarget:self action:@selector(btnEditClick) forControlEvents:UIControlEventTouchUpInside];
        _btnEdit.backgroundColor = [UIColor clearColor];
        _btnEdit.widthHeight = XY(W(25+30),W(60+25));
        [_btnEdit addSubview:^(){
            UIImageView *icon = [UIImageView new];
            icon.image = [UIImage imageNamed:@"address_edit"];
            icon.widthHeight = XY(W(25),W(25));
            icon.centerXCenterY = XY(W(55)/2.0, W(85)/2.0);
            return icon;
        }()];
    }
    return _btnEdit;
}
- (UIImageView *)iconSelected{
    if (_iconSelected == nil) {
        _iconSelected = [UIImageView new];
        _iconSelected.image = [UIImage imageNamed:@"select_default"];
        _iconSelected.highlightedImage = [UIImage imageNamed:@"select_highlighted"];
        _iconSelected.widthHeight = XY(W(19),W(19));
    }
    return _iconSelected;
}- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _name.numberOfLines = 1;
        _name.lineSpace = 0;
    }
    return _name;
}
- (UILabel *)address{
    if (_address == nil) {
        _address = [UILabel new];
        _address.textColor = COLOR_333;
        _address.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _address.numberOfLines = 0;
        _address.lineSpace = W(4);
    }
    return _address;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.btnEdit];
        [self.contentView addSubview:self.iconSelected];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.address];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelShopAddress *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.iconSelected.leftTop = XY(W(15),W(32));
    
    self.btnEdit.rightTop = XY(SCREEN_WIDTH,0);
    
    [self.name fitTitle:[NSString stringWithFormat:@"%@ %@",UnPackStr(model.contact),UnPackStr(model.phone)] variable:self.btnEdit.left- self.iconSelected.right - W(15)];
    self.name.leftTop = XY(self.iconSelected.right + W(15),W(20));
    [self.address fitTitle:model.addressDetailShow variable:self.btnEdit.left - W(15)];
    self.address.leftTop = XY(self.iconSelected.right + +W(15),self.name.bottom+W(15));
    
    //设置总高度
    self.height = MAX(self.address.bottom + W(20), self.btnEdit.height);
}
#pragma mark 点击事件
- (void)btnEditClick{
    if (self.blockEdit) {
        self.blockEdit(self.model);
    }
}


@end
