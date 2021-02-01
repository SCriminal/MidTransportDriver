//
//  DealHistoryDetailVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/14.
//Copyright © 2020 ping. All rights reserved.
//

#import "DealHistoryDetailVC.h"

@interface DealHistoryDetailVC ()

@end

@implementation DealHistoryDetailVC

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configView];
}
-(void)configView{
    [self.view removeSubViewWithTag:TAG_LINE];
    
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
    view.top = NAVIGATIONBAR_HEIGHT;
    view.tag = TAG_LINE;
    [self.view addSubview:view];
    {
         UILabel *_stateShow = [UILabel new];
              _stateShow.textColor = [UIColor whiteColor];
              _stateShow.font =  [UIFont systemFontOfSize:F(25) weight:UIFontWeightMedium];
              _stateShow.widthHeight = XY(W(70), W(70));
              _stateShow.textAlignment = NSTextAlignmentCenter;
        _stateShow.backgroundColor = self.modelItem.chargeColorShow;
        _stateShow.text = [self.modelItem.chargeTitleShow substringToIndex:1];
        [GlobalMethod setRoundView:_stateShow color:[UIColor clearColor] numRound:_stateShow.width/2.0 width:0];
        _stateShow.centerXTop = XY(SCREEN_WIDTH/2.0, W(40));
        [view addSubview:_stateShow];
    }
    {
           UILabel * l = [UILabel new];
           l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
           l.textColor = COLOR_333;
           l.backgroundColor = [UIColor clearColor];
           l.numberOfLines = 0;
           l.lineSpace = W(0);
           [l fitTitle:self.modelItem.chargeTypeShow variable:SCREEN_WIDTH - W(30)];
           l.centerXTop = XY(SCREEN_WIDTH/2.0, W(130));
           [view addSubview:l];
       }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(35) weight:UIFontWeightMedium];
        l.textColor = COLOR_ORANGE;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:[NSString stringWithFormat:@"%@%@",self.modelItem.direction==1?@"+":@"-",NSNumber.dou(self.modelItem.amt/100.0).stringValue] variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, W(165));
        [view addSubview:l];
    }
    [view addLineFrame:CGRectMake(W(30), W(240), SCREEN_WIDTH - W(60), 1)];
    NSArray * ary = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"交易单号：";
        m.subTitle = self.modelItem.flowNumber;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"交易时间：";
        m.subTitle = [GlobalMethod exchangeTimeWithStamp:self.modelItem.flowTime andFormatter:TIME_SEC_SHOW];
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"交易说明：";
        m.subTitle = isStr(self.modelItem.internalBaseClassDescription)?self.modelItem.internalBaseClassDescription:@"暂无";
        return m;
    }()];
    CGFloat top = W(273);
    for (ModelBtn *m in ary) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:m.title variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(30), top);
        [view addSubview:l];
        
        UILabel * subL = [UILabel new];
               subL.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
               subL.textColor = COLOR_666;
               subL.backgroundColor = [UIColor clearColor];
               [subL fitTitle:UnPackStr(m.subTitle) variable:SCREEN_WIDTH - W(30)];
        subL.leftTop = XY(l.right, top);
               [view addSubview:subL];
        top = l.bottom + W(15);
    }
}
#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"明细详情" rightView:nil];
    [nav configBackBlueStyle];
    [self.view addSubview:nav];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
