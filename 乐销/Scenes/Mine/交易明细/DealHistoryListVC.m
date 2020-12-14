//
//  DealHistoryListVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/14.
//Copyright © 2020 ping. All rights reserved.
//

#import "DealHistoryListVC.h"
#import "DealHistoryFilterView.h"
#import "DealHistoryDetailVC.h"
@interface DealHistoryListVC ()
@property (nonatomic, strong) DealHistoryFilterView *filterView;

@end

@implementation DealHistoryListVC
- (DealHistoryFilterView *)filterView{
    if (!_filterView) {
        _filterView = [DealHistoryFilterView new];
        WEAKSELF
        _filterView.blockSearchClick = ^(NSInteger index, NSString *billNo, NSDate *dateStart, NSDate *dateEnd) {
            [weakSelf refreshHeaderAll];
        };
    }
    return _filterView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[DealHistoryListCell class] forCellReuseIdentifier:@"DealHistoryListCell"];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    BaseNavView * nav = [BaseNavView initNavBackWithTitle:@"交易明细" rightImageName:@"nav_filter_white" rightImageSize:CGSizeMake(W(23), W(23)) righBlock:^{
        [weakSelf.filterView show];

    }];
   
    [nav configBackBlueStyle];
    [self.view addSubview:nav];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     DealHistoryListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DealHistoryListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DealHistoryListCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DealHistoryDetailVC * vc = [DealHistoryDetailVC new];
    [GB_Nav pushViewController:vc animated:true];
}
#pragma mark request
- (void)requestList{
    self.aryDatas = @[@"",@"",@""].mutableCopy;
    [self.tableView reloadData];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end


@implementation DealHistoryListCell
#pragma mark 懒加载
- (UILabel *)state{
    if (_state == nil) {
        _state = [UILabel new];
        _state.textColor = COLOR_333;
        _state.numberOfLines = 1;
        _state.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _state;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = COLOR_ORANGE;
        _price.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        _price.numberOfLines = 1;
    }
    return _price;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_999;
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _time;
}
- (UILabel *)stateShow{
    if (_stateShow == nil) {
        _stateShow = [UILabel new];
        _stateShow.textColor = [UIColor whiteColor];
        _stateShow.font =  [UIFont systemFontOfSize:F(22) weight:UIFontWeightMedium];
        _stateShow.widthHeight = XY(W(44), W(44));
        _stateShow.textAlignment = NSTextAlignmentCenter;
        [GlobalMethod setRoundView:_stateShow color:[UIColor clearColor] numRound:W(22) width:0];
    }
    return _stateShow;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.state];
    [self.contentView addSubview:self.price];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.stateShow];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model{
    self.height = W(76);

    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.stateShow.text = @"运";
    self.stateShow.leftCenterY = XY(W(15),self.height/2.0);
    self.stateShow.backgroundColor = COLOR_BLUE;
    
        [self.state fitTitle:@"运单成交" variable:W(240)];
    self.state.leftTop = XY(W(71),W(2)+self.stateShow.top);
    [self.price fitTitle:@"+1000.00" variable:W(150)];
    self.price.rightCenterY = XY(SCREEN_WIDTH - W(15),self.height/2.0);
    [self.time fitTitle:@"2020-11-19 12:10:20" variable:0];
    self.time.leftBottom = XY(W(71),self.stateShow.bottom-W(2));
    [self.contentView addLineFrame:CGRectMake(W(71), self.height - 1, SCREEN_WIDTH - W(71), 1)];
}

@end
