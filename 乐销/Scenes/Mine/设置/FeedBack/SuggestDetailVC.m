//
//  SuggestDetailVC.m
//  Driver
//
//  Created by 隋林栋 on 2021/1/6.
//Copyright © 2021 ping. All rights reserved.
//

#import "SuggestDetailVC.h"
//图片选择collection
#import "Collection_Image.h"

@interface SuggestDetailVC ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation SuggestDetailVC
- (UIView *)topView{
    if (!_topView) {
        _topView = [UIView new];
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(SCREEN_WIDTH, W(0));
        _topView = view;
        
    }
    return _topView;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(SCREEN_WIDTH, W(0));
        _bottomView = view;
    }
    return _bottomView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    //    [self.tableView registerClass:[<#CellName#> class] forCellReuseIdentifier:@"<#CellName#>"];
    //request
    [self requestList];
    [self reconfigTopView];
    [self reconfigBottomView];
}
- (void)reconfigTopView{
    [self.topView removeAllSubViews];
    CGFloat top = 0;
    if (isStr(self.modelItem.waybillNumber)) {
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
            l.textColor = COLOR_999;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:@"运单编号" variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(15),top + W(20));
            [self.topView addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_BLUE;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:self.modelItem.waybillNumber variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(15), top + W(47));
            [self.topView addSubview:l];
        }
       top =  [self.topView addLineFrame:CGRectMake(W(15),top + W(82), SCREEN_WIDTH - W(30), 1)];
    }
   
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_999;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"投诉内容" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15),top + W(20));
        [self.topView addSubview:l];
        top = l.bottom;
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(5);
        [l fitTitle:UnPackStr(self.modelItem.internalBaseClassDescription) variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15),top + W(15));
        [self.topView addSubview:l];
        top = l.bottom;
    }
    top = [self.topView addLineFrame:CGRectMake(W(15), W(20) + top, SCREEN_WIDTH - W(30), 1)];

    if (self.modelItem.urls.count) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_999;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"投诉附件" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), W(20) + top);
        [self.topView addSubview:l];
        top = l.bottom;
        
        Collection_Image * _collection_Image = [Collection_Image new];
        _collection_Image.isEditing = false;
        _collection_Image.width =  SCREEN_WIDTH - W(30);
        [_collection_Image resetWithAry:self.modelItem.urls];
        [self.topView addSubview:_collection_Image];
        _collection_Image.leftTop = XY(W(15), top + W(15));
        top = _collection_Image.bottom;
    }
    {
        UIView * view = [UIView new];
        view.backgroundColor = COLOR_BACKGROUND;
        view.widthHeight = XY(SCREEN_WIDTH, W(10));
        view.leftTop = XY(W(0), top + W(20));
        [self.topView addSubview:view];
        top = view.bottom;
    }
    self.topView.height = top;
    self.tableView.tableHeaderView = self.topView;
}
- (void)reconfigBottomView{
    [self.bottomView removeAllSubViews];
    if (!isStr(self.modelItem.replyMessage)) {
        return;
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_999;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"平台回复" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), W(20));
        [self.bottomView addSubview:l];
    }
    NSArray * ary = @[^(){
        ModelBaseData * m = [ModelBaseData new];
        m.string = self.modelItem.replyMessage;
        m.subString = [GlobalMethod exchangeTimeWithStamp:self.modelItem.replyTime andFormatter:TIME_SEC_SHOW];
        return m;
    }()];
    CGFloat top = W(52);
    CGFloat centerY = 0;
    for (int i = 0; i<ary.count; i++) {
        ModelBaseData *m = ary[i];
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(3);
        [l fitTitle:m.string variable:W(315)];
        l.leftTop = XY(W(37), top);
        [self.bottomView addSubview:l];
        
        UILabel * time = [UILabel new];
        time.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        time.textColor = COLOR_999;
        time.backgroundColor = [UIColor clearColor];
        [time fitTitle:m.subString variable:W(315)];
        time.leftTop = XY(W(37), l.bottom + W(10));
        [self.bottomView addSubview:time];
        
        top = time.bottom + W(20);
        
        //add dot
        UIView * view = [UIView new];
        view.backgroundColor = COLOR_BLUE;
        view.widthHeight = XY(W(5), W(5));
        view.leftTop = XY(W(20), l.top + ([UIFont fetchHeight:F(15)]/2.0)-W(2.5));
        [GlobalMethod setRoundView:view color:[UIColor clearColor] numRound:view.width/2.0 width:0];
        [self.bottomView addSubview:view];
        if (i !=0) {
            UIView * line = [UIView new];
            line.backgroundColor = COLOR_BLUE;
            line.widthHeight = XY(1, view.centerY - centerY);
            line.centerXBottom = XY(view.centerX, view.top);
            [self.bottomView addSubview:line];
        }
        centerY = view.centerY;
    }
    self.bottomView.height = top;
    self.tableView.tableFooterView = self.bottomView;
    
}
#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"投诉建议详情" rightView:nil];
    [nav configBackBlueStyle];
    [self.view addSubview:nav];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFLOAT_MIN;
}
//table header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
//table footer
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark request
- (void)requestList{
    
}
@end
