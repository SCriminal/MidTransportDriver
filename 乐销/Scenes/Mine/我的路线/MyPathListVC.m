//
//  MyPathListVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/30.
//Copyright © 2020 ping. All rights reserved.
//

#import "MyPathListVC.h"
#import "AddPathVC.h"
@interface MyPathListVC ()

@end

@implementation MyPathListVC


#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[MyPathListCell class] forCellReuseIdentifier:@"MyPathListCell"];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"我的路线" rightTitle:@"添加" rightBlock:^{
        AddPathVC * vc = [AddPathVC new];
        [GB_Nav pushViewController:vc animated:true];
    }];
    [nav configBackBlueStyle];
    [self.view addSubview:nav];
//    [self.view addSubview:[BaseNavView initNavBackTitle:<#导航栏标题#> rightView:nil]];
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
    MyPathListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyPathListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MyPathListCell fetchHeight:self.aryDatas[indexPath.row]];
}


#pragma mark request
- (void)requestList{
    self.aryDatas = @[@"",@"",@""].mutableCopy;
    [self.tableView reloadData];
}
@end


@implementation MyPathListCell
#pragma mark 懒加载
-(UIButton *)btnEdit{
    if (_btnEdit == nil) {
        _btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnEdit addTarget:self action:@selector(btnEditClick) forControlEvents:UIControlEventTouchUpInside];
        _btnEdit.backgroundColor = [UIColor clearColor];
        _btnEdit.widthHeight = XY(W(23+10),W(28+23));
        [_btnEdit addSubview:^(){
            UIImageView *icon = [UIImageView new];
            icon.image = [UIImage imageNamed:@"address_edit"];
            icon.widthHeight = XY(W(23),W(23));
            icon.rightCenterY = XY(W(23+10 -5), W(28+23)/2.0);
            return icon;
        }()];
    }
    return _btnEdit;
}
-(UIButton *)btnDelete{
    if (_btnDelete == nil) {
        _btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDelete addTarget:self action:@selector(btnDeleteClick) forControlEvents:UIControlEventTouchUpInside];
        _btnDelete.backgroundColor = [UIColor clearColor];
        _btnDelete.widthHeight = XY(W(23+30),W(28+23));
        [_btnDelete addSubview:^(){
            UIImageView *icon = [UIImageView new];
            icon.image = [UIImage imageNamed:@"address_delete"];
            icon.widthHeight = XY(W(23),W(23));
            icon.rightCenterY = XY(W(23+30 -15), W(28+23)/2.0);
            return icon;
        }()];
    }
    return _btnDelete;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.btnEdit];
        [self.contentView addSubview:self.btnDelete];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelShopAddress *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.btnDelete.rightTop = XY(SCREEN_WIDTH,0);

    self.btnEdit.rightTop = XY(self.btnDelete.left,0);

    CGFloat top = W(18);
    NSArray * ary = @[^(){
        ModelBaseData * m = [ModelBaseData new];
        m.string = @"始发地：";
        m.subString = @"山东省潍坊市青州市";
        return m;
    }(),^(){
        ModelBaseData * m = [ModelBaseData new];
        m.string = @"途径1：";
               m.subString = @"安徽省合肥市肥东区";
        return m;
    }(),^(){
        ModelBaseData * m = [ModelBaseData new];
        m.string = @"目的地：";
               m.subString = @"广东省广州市天河区";
        return m;
    }()];
    for (ModelBaseData * m in ary) {
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:m.string variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(15), top);
            l.tag = TAG_LINE;
            [self.contentView addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:m.subString variable: W(200)];
            l.numberOfLines = 0;
            l.lineSpace = W(5);
            l.leftTop = XY(W(75), top);
            l.tag = TAG_LINE;
            [self.contentView addSubview:l];
            top = l.bottom + W(14);
        }
    }
    //设置总高度
    self.height = top + W(4);
    [self.contentView addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}
#pragma mark 点击事件
- (void)btnEditClick{
    if (self.blockEditClick) {
        self.blockEditClick(self.model);
    }
}
- (void)btnDeleteClick{
    if (self.blockDeleteClick) {
        self.blockDeleteClick(self.model);
    }
}

@end
