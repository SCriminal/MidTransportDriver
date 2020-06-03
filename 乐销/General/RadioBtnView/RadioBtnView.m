//
//  RadioBtnView.m
//中车运
//
//  Created by 隋林栋 on 2016/12/22.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "RadioBtnView.h"

@interface RadioBtnView()
@property (nonatomic, assign) NSInteger indexSelect;

@end

@implementation RadioBtnView


- (NSInteger)selectedIndex{
    for (int i = 0; i< self.aryModels.count; i++) {
        UIView * view = [self viewWithTag:i + 10];
        if ([view isKindOfClass:[RadioBtnViewControl class]]) {
            RadioBtnViewControl * con = (RadioBtnViewControl *)view;
            if (con.isSelected) {
                return con.tag - 10;
            }
        }
    }
    return -1;
}
- (void)setSelectedIndex:(NSInteger)index{
    self.indexSelect = index;
    for (int i = 0; i< self.aryModels.count; i++) {
        UIView * view = [self viewWithTag:i + 10];
        if ([view isKindOfClass:[RadioBtnViewControl class]]) {
            RadioBtnViewControl * con = (RadioBtnViewControl *)view;
            if (index == -1) {
                con.selected = false;
            }else{
                con.selected = con.tag == index + 10;
            }
        }
    }
}

#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubView];
    }
    return self;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubView];
    }
    return self;
}
- (void)addSubView{
    self.widthLimit = SCREEN_WIDTH;
}

#pragma mark reset
- (void)resetWithAry:(NSArray *)ary{
    [self removeAllSubViews];
    CGFloat numLeft = 0;
    CGFloat numTop = 0;
    self.lineNum = 1;
    for (int i = 0; i < ary.count; i++) {
        ModelBtn * model = ary[i];
        RadioBtnViewControl * con = [RadioBtnViewControl initWithTitle:model.title tag:i+10];
        if (numLeft + con.width > self.widthLimit) {
            self.lineNum ++;
            numTop = numTop + con.height;
            numLeft = 0;
        }
        con.leftTop = XY(numLeft,numTop);
        [con addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:con];
        con.selected = i == self.indexSelect;
        
        numLeft = con.right + W(15);
        self.height = con.bottom;
    }
    self.width = self.lineNum>1? self.widthLimit:numLeft;
    self.aryModels = ary;
    
}


#pragma mark 点击事件
- (void)btnClick:(RadioBtnViewControl *)sender{
    for (int i = 0; i< self.aryModels.count; i++) {
        UIView * view = [self viewWithTag:i + 10];
        if ([view isKindOfClass:[RadioBtnViewControl class]]) {
            RadioBtnViewControl * con = (RadioBtnViewControl *)view;
            con.selected = false;
        }
    }
    sender.selected = true;
    self.indexSelect = sender.tag-10;
    if (self.blockSelectIndex != nil) {
        self.blockSelectIndex(sender.tag-10);
    }
}

@end

@implementation RadioBtnViewControl


- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.imageViewDiot.image = selected ? self.imageSelect:self.imageDefault;
    self.labelTitle.textColor = selected ? COLOR_SUBTITLE : COLOR_TITLE;
}

#pragma mark 懒加载
- (UIImageView *)imageViewDiot{
    if (_imageViewDiot == nil) {
        _imageViewDiot = [UIImageView new];
        _imageViewDiot.backgroundColor = [UIColor clearColor];
        _imageViewDiot.image = self.imageDefault;
        _imageViewDiot.widthHeight = XY(W(15),W(15));
    }
    return _imageViewDiot;
}
- (UIImage *)imageDefault{
    if (!_imageDefault) {
        _imageDefault = [UIImage imageNamed:@"未选"];
    }
    return _imageDefault;
}
- (UIImage *)imageSelect{
    if (!_imageSelect) {
        _imageSelect = [UIImage imageNamed:@"选中"];
    }
    return _imageSelect;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(13) textColor:COLOR_TITLE text:@""];
    }
    return _labelTitle;
}

#pragma mark 初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.imageViewDiot];
        [self addSubview:self.labelTitle];
        self.backgroundColor = [UIColor clearColor];
        self.height = W(44);
    }
    return self;
}
//创建
+ (instancetype)initWithTitle:(NSString *)title
                          tag:(int)tag{
    RadioBtnViewControl * control = [RadioBtnViewControl new];
    [control resetWithTitle:title tag:tag];
    return control;
}
- (void)resetWithTitle:(NSString *)title
                   tag:(int)tag{
    self.tag = tag;
    self.imageViewDiot.leftCenterY = XY(0,self.height/2.0);
    
    [self.labelTitle  fitTitle:title  variable:0];
    self.labelTitle.leftCenterY = XY(self.imageViewDiot.right + W(10),self.height/2.0);
    self.width = self.labelTitle.right;
}
@end

