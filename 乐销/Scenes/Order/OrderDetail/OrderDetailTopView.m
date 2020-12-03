//
//  OrderDetailTopView.m
//  Driver
//
//  Created by 隋林栋 on 2018/12/6.
//Copyright © 2018 ping. All rights reserved.
//

#import "OrderDetailTopView.h"
#import "BulkCargoListCell.h"
@implementation OrderDetailView
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
        [self resetViewWithModel:nil];
    }
    return self;
}


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderList *)modelOrder{
    [self removeAllSubViews];//移除线
    self.model = modelOrder;
    {
        UIView * view = [UIView new];
        view.backgroundColor = COLOR_BACKGROUND;
        view.widthHeight = XY(SCREEN_WIDTH, W(10));
        [self addSubview:view];
    }
    
}

#pragma mark click
- (void)phoneClick{
                NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",UnPackStr(self.model.startPhone)];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

}
@end
