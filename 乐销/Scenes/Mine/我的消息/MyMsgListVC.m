//
//  MyMsgListVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/18.
//Copyright © 2020 ping. All rights reserved.
//

#import "MyMsgListVC.h"
#import "ModelLabel.h"

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
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无消息"];
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
    ModelBaseData * m = self.aryDatas[indexPath.row];
    m.isSelected = !m.isSelected;
    [self.tableView reloadData];
}

#pragma mark request
- (void)requestList{
    self.aryDatas = @[^(){
        ModelBaseData * m = [ModelBaseData new];
        return m;
    }(),^(){
        ModelBaseData * m = [ModelBaseData new];
        return m;
    }(),^(){
        ModelBaseData * m = [ModelBaseData new];
        return m;
    }(),^(){
        ModelBaseData * m = [ModelBaseData new];
        return m;
    }(),^(){
        ModelBaseData * m = [ModelBaseData new];
        return m;
    }(),^(){
        ModelBaseData * m = [ModelBaseData new];
        return m;
    }()].mutableCopy;
    [self.tableView reloadData];
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
        _iconArrow.image = [UIImage imageNamed:@"msg_down"];
        _iconArrow.highlightedImage = [UIImage imageNamed:@"msg_up"];
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
- (void)resetCellWithModel:(ModelBaseData *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.state.text = @"未读";
    self.state.backgroundColor = model.isSelected?[UIColor colorWithHexString:@"#D4DEF0"]:[UIColor colorWithHexString:@"#FF9523"];
    self.state.leftTop = XY(W(15),W(17));
    
    [self.msgTitle fitTitle:@"恭喜您，抢单成功" variable:W(295)];
    self.msgTitle.leftCenterY = XY(W(6)+self.state.right,self.state.centerY);
    
    self.msgContent.hidden = !model.isSelected;
    if (model.isSelected) {
        [self.msgContent resetAttributeStrFixed:W(346) models:@[^(){
            ModelLabel * m = [ModelLabel new];
            m.text = @"您报价的编号：";
            m.textColor = COLOR_999;
            m.font = F(12);
            return m;
        }(),^(){
            ModelLabel * m = [ModelLabel new];
            m.text = @"2399900020333";
            m.textColor = COLOR_BLUE;
            m.font = F(12);
            return m;
        }(),^(){
            ModelLabel * m = [ModelLabel new];
            m.text = @"您报价的编号123：";
            m.textColor = COLOR_999;
            m.font = F(12);
            return m;
        }(),^(){
            ModelLabel * m = [ModelLabel new];
            m.text = @"2399900020333";
            m.textColor = COLOR_BLUE;
            m.font = F(12);
            return m;
        }(),^(){
            ModelLabel * m = [ModelLabel new];
            m.text = @"您报价的编号123：";
            m.textColor = COLOR_999;
            m.font = F(12);
            return m;
        }(),^(){
            ModelLabel * m = [ModelLabel new];
            m.text = @"2399900020333";
            m.textColor = COLOR_BLUE;
            m.font = F(12);
            return m;
        }()] lineSpace:W(6)];
        self.msgContent.leftTop = XY(W(15),self.state.bottom+W(12));

    }
    

    self.iconArrow.rightCenterY = XY(SCREEN_WIDTH - W(15),self.state.centerY);
    self.iconArrow.highlighted = model.isSelected;
    //设置总高度
    self.height = (model.isSelected?self.msgContent.bottom:self.state.bottom)+W(18);
    [self.contentView addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}

@end
