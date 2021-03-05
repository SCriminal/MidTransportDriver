//
//  MyMsgListVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/18.
//Copyright © 2020 ping. All rights reserved.
//

#import "MyMsgListVC.h"
#import "ModelLabel.h"
//request
#import "RequestDriver2.h"
@interface MyMsgListVC ()

@end

@implementation MyMsgListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_waybill_default" title:@"暂无消息"];
    }
    return _noResultView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[MyMsgListCell class] forCellReuseIdentifier:@"MyMsgListCell"];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, W(10), 0);
    [self addRefreshHeader];
    [self addRefreshFooter];
    //request
    [self requestList];    //request
}

#pragma mark 添加导航栏
- (void)addNav{
    //    [self.view addSubview:[BaseNavView initNavBackTitle:<#导航栏标题#> rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyMsgListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyMsgListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MyMsgListCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelMsgItem * m = self.aryDatas[indexPath.row];
    if (isStr(m.content)) {
        m.content = nil;
        [self.tableView reloadData];
        
    }else{
        [RequestApi requestMsgDetailWithNumber:m.number delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            m.content = [response stringValueForKey:@"content"];
            m.isRead = 1;
            [self.tableView reloadData];
            
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }
}

#pragma mark request
- (void)requestList{
    [RequestApi requestMsgListWithChannel:self.channel.doubleValue isRead:self.index page:self.pageNum count:20 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelMsgItem"];
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


@implementation MyMsgListCell
#pragma mark 懒加载
- (UILabel *)state{
    if (_state == nil) {
        _state = [UILabel new];
        _state.textColor = [UIColor whiteColor];
        _state.widthHeight = XY(W(28), W(17));
        _state.font =  [UIFont systemFontOfSize:F(10) weight:UIFontWeightMedium];
        _state.textAlignment = NSTextAlignmentCenter;
        [GlobalMethod setRoundView:_state color:[UIColor clearColor] numRound:3 width:0];
    }
    return _state;
}
- (UILabel *)msgTitle{
    if (_msgTitle == nil) {
        _msgTitle = [UILabel new];
        _msgTitle.textColor = COLOR_333;
        _msgTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _msgTitle;
}
- (UILabel *)msgContent{
    if (_msgContent == nil) {
        _msgContent = [UILabel new];
        _msgContent.textColor = COLOR_999;
        _msgContent.numberOfLines = 0;
        _msgContent.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _msgContent;
}
- (UIImageView *)iconArrow{
    if (_iconArrow == nil) {
        _iconArrow = [UIImageView new];
        _iconArrow.image = [UIImage imageNamed:@"msg_up"];
        _iconArrow.highlightedImage = [UIImage imageNamed:@"msg_down"];
        _iconArrow.widthHeight = XY(W(12),W(12));
    }
    return _iconArrow;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.state];
        [self.contentView addSubview:self.msgTitle];
        [self.contentView addSubview:self.msgContent];
        [self.contentView addSubview:self.iconArrow];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelMsgItem *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.state.text = model.isRead?@"已读":@"未读";
    self.state.backgroundColor = model.isRead?[UIColor colorWithHexString:@"#D4DEF0"]:[UIColor colorWithHexString:@"#FF9523"];
    self.state.leftTop = XY(W(15),W(17));
    
    [self.msgTitle fitTitle:UnPackStr(model.title) variable:W(295)];
    self.msgTitle.leftCenterY = XY(W(6)+self.state.right,self.state.centerY);
    
    self.msgContent.hidden = !isStr(model.content);
    if (!self.msgContent.hidden) {
        [self.msgContent resetAttributeStrFixed:W(346) models:@[^(){
            ModelLabel * m = [ModelLabel new];
            m.text = model.content;
            m.textColor = COLOR_999;
            m.font = F(12);
            return m;
        }()
                                                                 //                                                                 ,^(){
                                                                 //            ModelLabel * m = [ModelLabel new];
                                                                 //            m.text = @"2399900020333";
                                                                 //            m.textColor = COLOR_BLUE;
                                                                 //            m.font = F(12);
                                                                 //            return m;
                                                                 //        }()
        ] lineSpace:W(6)];
        self.msgContent.leftTop = XY(W(15),self.state.bottom+W(12));
        
    }
    
    
    self.iconArrow.rightCenterY = XY(SCREEN_WIDTH - W(15),self.state.centerY);
    self.iconArrow.highlighted = self.msgContent.hidden;
    //设置总高度
    self.height = (self.msgContent.hidden?self.state.bottom:self.msgContent.bottom)+W(18);
    [self.contentView addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}

@end
