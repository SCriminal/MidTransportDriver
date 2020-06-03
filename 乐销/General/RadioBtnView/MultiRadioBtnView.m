//
//  MultiRadioBtnView.m
//中车运
//
//  Created by 隋林栋 on 2017/5/2.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "MultiRadioBtnView.h"

@implementation MultiRadioBtnView
@synthesize selectedIndexs = _selectedIndexs;

- (NSMutableArray *)selectedIndexs{
    if (!_selectedIndexs) {
        _selectedIndexs = [NSMutableArray new];
    }
    return _selectedIndexs;
}


- (void)setSelectedIndexs:(NSMutableArray *)selectedIndexs{
    _selectedIndexs = selectedIndexs;
    NSMutableDictionary * dic = [selectedIndexs exchangeStrAryToDic];
    
    for (int i = 0; i< self.aryModels.count; i++) {
        UIView * view = [self viewWithTag:i + 10];
        if ([view isKindOfClass:[RadioBtnViewControl class]]) {
            RadioBtnViewControl * con = (RadioBtnViewControl *)view;
            con.selected = [dic objectForKey:[NSString stringWithFormat:@"%d",i]];
        }
    }
}
/*

*/
//创建
+ (instancetype)initWithAry:(NSArray *)ary{
    return  [[self alloc]initWithAry:ary];
}
- (instancetype)initWithAry:(NSArray *)ary{
    self = [super init];
    if (self) {
        [self resetWithAry:ary];
    }
    return self;
}

- (void)resetWithAry:(NSArray *)ary{
    [self removeAllSubViews];
    CGFloat numLeft = 0;
    CGFloat numTop = 0;
    self.width = 0;
    NSMutableDictionary * dicSelected = [self.selectedIndexs exchangeStrAryToDic];

    for (int i = 0; i < ary.count; i++) {
        ModelBtn * model = ary[i];
        RadioBtnViewControl * con = [RadioBtnViewControl initWithTitle:model.title tag:i+10];
        con.imageSelect = [UIImage imageNamed:@"fx_xz"];
        con.imageDefault = [UIImage imageNamed:@"fx_wxz"];
        if (numLeft + con.width > SCREEN_WIDTH) {
            self.width = SCREEN_WIDTH;
            numTop = numTop + con.height;
            numLeft = 0;
        }
        con.leftTop = XY(numLeft,numTop);
        [con addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:con];
        con.selected = [dicSelected objectForKey:[NSString stringWithFormat:@"%d",i]];
        
        numLeft = con.right + W(15);
        self.height = con.bottom;
        self.width = MAX(self.width, numLeft);
    }
    
    self.aryModels = ary;
}


#pragma mark 点击事件
- (void)btnClick:(RadioBtnViewControl *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        //加入
        [self.selectedIndexs addObject:[NSString stringWithFormat:@"%ld",(sender.tag - 10)]];
    }else {
        //移除
        NSDictionary * dic = [self.selectedIndexs exchangeStrAryToDic];
        if ([dic objectForKey:[NSString stringWithFormat:@"%ld",(sender.tag - 10)]]) {
            [self.selectedIndexs removeObject:[dic objectForKey:[NSString stringWithFormat:@"%ld",(sender.tag - 10)]]];
        }
    }
    if (self.blockSelectIndex != nil) {
        self.blockSelectIndex(sender.tag-10);
    }
}

@end
