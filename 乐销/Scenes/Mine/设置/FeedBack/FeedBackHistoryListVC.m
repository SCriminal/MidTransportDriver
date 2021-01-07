//
//  FeedBackHistoryListVC.m
//  Driver
//
//  Created by 隋林栋 on 2021/1/6.
//Copyright © 2021 ping. All rights reserved.
//

#import "FeedBackHistoryListVC.h"
#import "SuggestDetailVC.h"
@interface FeedBackHistoryListVC ()

@end

@implementation FeedBackHistoryListVC

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
    [GB_Nav pushViewController:vc animated:true];
}
#pragma mark request
- (void)requestList{
    self.aryDatas = @[@"",@"",@""].mutableCopy;
    [self.tableView reloadData];
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
- (void)resetCellWithModel:(id)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
        [self.num fitTitle:@"编号：20399993002999999" variable:W(300)];
    self.num.leftTop = XY(W(15),W(18));
    [self.time fitTitle:@"提交时间：2020-11-19 12:10:20" variable:0];
    self.time.leftTop = XY(W(15),self.num.bottom+W(13));


    //设置总高度
    self.height = self.time.bottom + W(18);
    self.arrow.rightCenterY = XY(SCREEN_WIDTH - W(10),self.height/2.0);
    [self.contentView addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}

@end


@implementation SuggestHistoryListVC

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
    [GB_Nav pushViewController:vc animated:true];
}
#pragma mark request
- (void)requestList{
    self.aryDatas = @[@"",@"",@""].mutableCopy;
    [self.tableView reloadData];

}
@end
