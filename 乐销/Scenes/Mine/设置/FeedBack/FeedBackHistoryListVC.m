//
//  FeedBackHistoryListVC.m
//  Driver
//
//  Created by 隋林栋 on 2021/1/6.
//Copyright © 2021 ping. All rights reserved.
//

#import "FeedBackHistoryListVC.h"
#import "SuggestDetailVC.h"
//request
#import "RequestDriver2.h"
@interface FeedBackHistoryListVC ()

@end

@implementation FeedBackHistoryListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_waybill_default" title:@"暂无记录"];
    }
    return _noResultView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.tableView.contentInset = UIEdgeInsetsMake(W(10), 0, 0, 0);
    //table
    [self.tableView registerClass:[FeedBackHistoryListCell class] forCellReuseIdentifier:@"FeedBackHistoryListCell"];
    //request
    [self requestList];
}


#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FeedBackHistoryListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FeedBackHistoryListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [FeedBackHistoryListCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SuggestDetailVC * vc = [SuggestDetailVC new];
    vc.modelItem = self.aryDatas[indexPath.row];
    [GB_Nav pushViewController:vc animated:true];
}
#pragma mark request
- (void)requestList{
    [RequestApi requestProblemListWithPage:self.pageNum count:20
                                      type:self.type delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelProblemHistoryItem"];
        if (self.isRemoveAll) {
            [self.aryDatas removeAllObjects];
        }
        if (!isAry(aryRequest)) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.aryDatas addObjectsFromArray:aryRequest];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];

}
@end


@implementation FeedBackHistoryListCell
#pragma mark 懒加载
- (UILabel *)num{
    if (_num == nil) {
        _num = [UILabel new];
        _num.textColor = COLOR_333;
        _num.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _num;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_999;
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _time;
}
- (UIImageView *)arrow{
    if (_arrow == nil) {
        _arrow = [UIImageView new];
        _arrow.image = [UIImage imageNamed:@"setting_RightArrow"];
        _arrow.widthHeight = XY(W(25),W(25));
    }
    return _arrow;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.num];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.arrow];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelProblemHistoryItem *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.num fitTitle:[NSString stringWithFormat:@"编号：%@",model.number] variable:W(300)];
    self.num.leftTop = XY(W(15),W(18));
    
    [self.time fitTitle:[NSString stringWithFormat:@"提交时间：%@",[GlobalMethod exchangeTimeWithStamp:model.submitterTime andFormatter:TIME_SEC_SHOW]] variable:0];
    self.time.leftTop = XY(W(15),self.num.bottom+W(13));

    //设置总高度
    self.height = self.time.bottom + W(18);
    self.arrow.rightCenterY = XY(SCREEN_WIDTH - W(10),self.height/2.0);
    [self.contentView addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}

@end


