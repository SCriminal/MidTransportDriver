//
//  OrderListCellBtnView.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/2.
//Copyright © 2020 ping. All rights reserved.
//

#import "OrderListCellBtnView.h"


@implementation OrderListCellBtnView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        self.height = W(39);
        
    }
    return self;
}


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelTransportOrder *)model{
    self.model = model;
    [self removeAllSubViews];//移除线
    if (model.orderStatus >=4 ) {
        self.height = 0;
        return;
    }
    self.height = W(39);
    NSArray * ary = nil;
    switch ((int)model.orderStatus) {
        case 1://待接单
            ary = @[^(){
                ModelBtn * m = [ModelBtn new];
                m.tag = ENUM_ORDER_LIST_BTN_REJECT;
                return m;
            }(),^(){
                ModelBtn * m = [ModelBtn new];
                m.tag = ENUM_ORDER_LIST_BTN_RECEIVE;
                return m;
            }()];
            break;
        case 2://待装车
            ary = @[^(){
                ModelBtn * m = [ModelBtn new];
                m.tag = ENUM_ORDER_LIST_BTN_NAVIGATION;
                return m;
            }(),^(){
                ModelBtn * m = [ModelBtn new];
                m.tag = ENUM_ORDER_LIST_BTN_LOAD_CAR;
                return m;
            }()];
            break;
        case 3://待卸车
            ary = @[^(){
                ModelBtn * m = [ModelBtn new];
                m.tag = ENUM_ORDER_LIST_BTN_NAVIGATION;
                return m;
            }(),^(){
                ModelBtn * m = [ModelBtn new];
                m.tag = ENUM_ORDER_LIST_BTN_ARRIVE;
                return m;
            }()];
            break;
        default:
            break;
    }
   
    
    CGFloat left = W(15);
    CGFloat width = (SCREEN_WIDTH - W(30) - (ary.count  -1 )*W(15))/ary.count;
    for (ModelBtn * m in ary) {
        UIColor * colorBackground = [UIColor whiteColor];
        BOOL isColor = false;
        NSString * title = @"";
        switch (m.tag) {
            case ENUM_ORDER_LIST_BTN_RECEIVE:
                colorBackground = COLOR_BLUE;
                isColor = true;
                title = @"接单";
                break;
            case ENUM_ORDER_LIST_BTN_LOAD_CAR:
                colorBackground = COLOR_ORANGE;
                isColor = true;
                title = @"装车";
                break;
            case ENUM_ORDER_LIST_BTN_ARRIVE:
                colorBackground = COLOR_GREEN;
                isColor = true;
                title = @"到达";
                break;
            case ENUM_ORDER_LIST_BTN_DISMISS:
                title = @"取消";
                break;
            case ENUM_ORDER_LIST_BTN_REJECT:
                title = @"拒单";
                break;
            case ENUM_ORDER_LIST_BTN_NAVIGATION:
                title = @"路线导航";
                break;
            default:
                break;
        }
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(width, self.height);
        btn.backgroundColor = colorBackground;
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(15);
        [btn setTitleColor:isColor?[UIColor whiteColor]:COLOR_666 forState:UIControlStateNormal];
        btn.tag = m.tag;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:1 lineColor:isColor?colorBackground: [UIColor colorWithHexString:@"#D7DBDA"]];
        [self addSubview:btn];
        btn.left = left;
        left = btn.right + W(15);
        
    }
}


#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    if (self.blockClick) {
        self.blockClick(sender.tag,self.model);
    }
}
@end
