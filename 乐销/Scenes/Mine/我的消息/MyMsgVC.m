//
//  MyMsgVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "MyMsgVC.h"
#import "MyMsgManagementVC.h"

@interface MyMsgVC ()

@end

@implementation MyMsgVC

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[MyMsgCell class] forCellReuseIdentifier:@"MyMsgCell"];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"我的消息" rightView:nil];
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

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     MyMsgCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyMsgCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MyMsgCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
                 MyMsgManagementVC* vc = [MyMsgManagementVC new];
    [GB_Nav pushViewController:vc animated:true];

}
#pragma mark request
- (void)requestList{
    self.aryDatas = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"配";
        m.subTitle = @"配货消息";
        m.color = COLOR_ORANGE;
        m.num = 10;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"运";
        m.subTitle = @"运单消息";
        m.color = COLOR_BLUE_LIGHT;
        m.num = 99;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"认";
        m.subTitle = @"认证消息";
        m.color = COLOR_BLUE;
        m.num = 1011;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"其";
        m.subTitle = @"其他消息";
        m.color = COLOR_GREEN;
        m.num = 0;
        return m;
    }()].mutableCopy;
    [self.tableView reloadData];
}
@end



@implementation MyMsgCell
#pragma mark 懒加载
- (UILabel *)stateKey{
    if (_stateKey == nil) {
        _stateKey = [UILabel new];
        _stateKey.textColor = [UIColor whiteColor];
        _stateKey.font =  [UIFont systemFontOfSize:F(18) weight:UIFontWeightMedium];
        _stateKey.widthHeight = XY(W(40), W(40));
        [_stateKey addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:_stateKey.width/2.0 lineWidth:0 lineColor:[UIColor clearColor]];
        _stateKey.textAlignment = NSTextAlignmentCenter;

    }
    return _stateKey;
}
- (UILabel *)msgTitle{
    if (_msgTitle == nil) {
        _msgTitle = [UILabel new];
        _msgTitle.textColor = COLOR_333;
        _msgTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _msgTitle;
}
- (UILabel *)num{
    if (_num == nil) {
        _num = [UILabel new];
        _num.textColor = [UIColor whiteColor];
        _num.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightMedium];
        _num.textAlignment = NSTextAlignmentCenter;
        _num.widthHeight = XY(W(20),W(20));
        [GlobalMethod setRoundView:_num color:[UIColor clearColor] numRound:_num.width/2.0 width:0];
//        [_num addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:_num.width/2.0 lineColor:[UIColor clearColor]];
        

    }
    return _num;
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
        [self.contentView addSubview:self.stateKey];
    [self.contentView addSubview:self.msgTitle];
    [self.contentView addSubview:self.num];
    [self.contentView addSubview:self.arrow];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.stateKey.text = model.title;
    self.stateKey.backgroundColor = model.color;
    self.stateKey.leftTop = XY(W(15),W(16));
    [self.msgTitle fitTitle:model.subTitle variable:0];
    self.msgTitle.leftCenterY = XY(W(12)+self.stateKey.right,self.stateKey.centerY);
    
    self.num.text = NSNumber.dou(MIN(model.num, 99)).stringValue;
    self.num.rightCenterY = XY(SCREEN_WIDTH - W(32),self.msgTitle.centerY);
    self.num.backgroundColor = model.num == 0?[UIColor colorWithHexString:@"#D4DEF0"]:COLOR_RED;
    
    self.arrow.rightCenterY = XY(SCREEN_WIDTH - W(10),self.num.centerY);

    //设置总高度
    self.height = self.stateKey.bottom + W(16);
    [self.contentView addLineFrame:CGRectMake(self.msgTitle.left, self.height-1, SCREEN_WIDTH - W(15)- self.msgTitle.left, 1)];
}

@end
