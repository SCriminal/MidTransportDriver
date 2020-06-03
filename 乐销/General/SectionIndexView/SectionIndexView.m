//
//  SectionIndexView.m
//中车运
//
//  Created by 隋林栋 on 2017/4/1.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "SectionIndexView.h"
@interface SectionIndexView()
@property (nonatomic, assign) CGFloat itemHeight;
@end

@implementation SectionIndexView

#pragma mark lazy init
- (UIColor *)sectionIndexColor{
    if (!_sectionIndexColor) {
        _sectionIndexColor = COLOR_TITLE;
    }
    return _sectionIndexColor;
}

#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
#pragma mark reset
- (void)resetWithAry:(NSArray *)ary tableView:(UITableView *)tableView viewShow:(UIView *)view rightCenterY:(STRUCT_XY)rightCenterY{
    self.tableView = tableView;
    self.aryDatas = ary;
    self.width = W(20);
    [self removeAllSubViews];
    CGFloat top = 0;
    for (int i = 0; i< ary.count; i++) {
        ModelAryIndex * modelSection = ary[i];
        if (modelSection != nil && [modelSection isKindOfClass:[ModelAryIndex class]]) {
            UILabel * label = [UILabel new];
            [GlobalMethod setLabel:label widthLimit:W(15) numLines:0 fontNum:F(10) textColor:self.sectionIndexColor aligent:NSTextAlignmentCenter text:modelSection.strFirst bgColor:[UIColor clearColor]];
            label.width = W(15);
            label.rightTop = XY(self.width, top);
            top = label.bottom + W(3);
            if (i == 0) {
                self.itemHeight = top;
            }
            [self addSubview:label];
        }
    }
    self.height = top;
    self.rightCenterY = rightCenterY;
    [view addSubview:self];
}

#pragma mark btn Click
- (void)tapClick:(UITapGestureRecognizer *)tap{
    CGPoint  point = [tap locationInView:self];
    CGFloat index = point.y / self.itemHeight;
    index = floor(index );
    if (self.tableView.numberOfSections>index) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:true];
    }
}


@end
