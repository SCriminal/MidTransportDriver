//
//  IntegralProductDetailView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/27.
//Copyright © 2020 ping. All rights reserved.
//

#import "IntegralProductDetailView.h"

@interface IntegralProductDetailView ()

@end

@implementation IntegralProductDetailView
#pragma mark 懒加载
- (UILabel *)scoreNum{
    if (_scoreNum == nil) {
        _scoreNum = [UILabel new];
        _scoreNum.textColor = COLOR_RED;
        _scoreNum.font =  [UIFont systemFontOfSize:F(25) weight:UIFontWeightMedium];
        _scoreNum.numberOfLines = 1;
        _scoreNum.lineSpace = 0;
    }
    return _scoreNum;
}
- (UILabel *)score{
    if (_score == nil) {
        _score = [UILabel new];
        _score.textColor = COLOR_RED;
        _score.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _score.numberOfLines = 1;
        _score.lineSpace = 0;
    }
    return _score;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = COLOR_333;
        _price.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _price.numberOfLines = 1;
        _price.lineSpace = 0;
    }
    return _price;
}
- (UILabel *)remain{
    if (_remain == nil) {
        _remain = [UILabel new];
        _remain.textColor = COLOR_999;
        _remain.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _remain.numberOfLines = 1;
        _remain.lineSpace = 0;
    }
    return _remain;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _title.numberOfLines = 1;
        _title.lineSpace = 0;
    }
    return _title;
}
- (UIView *)grayBG{
    if (_grayBG == nil) {
        _grayBG = [UIView new];
        _grayBG.backgroundColor = COLOR_BACKGROUND;
    }
    return _grayBG;
}
- (UILabel *)detail{
    if (_detail == nil) {
        _detail = [UILabel new];
        _detail.textColor = COLOR_333;
        _detail.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        _detail.numberOfLines = 1;
        _detail.lineSpace = 0;
    }
    return _detail;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.scoreNum];
    [self addSubview:self.score];
//    [self addSubview:self.price];
    [self addSubview:self.remain];
    [self addSubview:self.title];
    [self addSubview:self.grayBG];
    [self addSubview:self.detail];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelIntegralProduct *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.scoreNum fitTitle:[NSString stringWithFormat:@"%.f",model.point] variable:0];
    self.scoreNum.leftTop = XY(W(15),W(17));
    [self.score fitTitle:@"积分" variable:0];
    self.score.leftBottom = XY(self.scoreNum.right + W(2),self.scoreNum.bottom-W(2));

    [self.remain fitTitle:[NSString stringWithFormat:@"%.f件已兑换",model.saleAmount]  variable:0];
    self.remain.rightCenterY = XY(SCREEN_WIDTH - W(15),self.scoreNum.centerY);
    
    [self.title fitTitle:UnPackStr(model.name) variable:0];
    self.title.leftTop = XY(W(15),self.scoreNum.bottom+W(15));
    
    self.grayBG.widthHeight = XY(SCREEN_WIDTH, W(10));
    self.grayBG.leftTop = XY(0,self.title.bottom+W(17));
    [self.detail fitTitle:@"商品说明" variable:0];
    self.detail.leftTop = XY(W(15),self.grayBG.bottom+W(17));
    
    //设置总高度
    self.height = self.detail.bottom+ W(17);
}


@end
