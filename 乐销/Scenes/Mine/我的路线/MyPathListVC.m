//
//  MyPathListVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/30.
//Copyright © 2020 ping. All rights reserved.
//

#import "MyPathListVC.h"
#import "AddPathVC.h"
//request
#import "RequestDriver2.h"
@interface MyPathListVC ()

@end

@implementation MyPathListVC

#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_path" title:@"暂无路线"];
    }
    return _noResultView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[MyPathListCell class] forCellReuseIdentifier:@"MyPathListCell"];
    //request
    [self requestList];
    [self addRefreshHeader];
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"我的路线" rightTitle:@"添加" rightBlock:^{
        AddPathVC * vc = [AddPathVC new];
        vc.blockBack = ^(UIViewController *vc) {
            [weakSelf refreshHeaderAll];
        };
        [GB_Nav pushViewController:vc animated:true];
    }];
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
    MyPathListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyPathListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockEditClick = ^(ModelPathListItem *item) {
        AddPathVC * pathVC  = [AddPathVC new];
        pathVC.modelList = item;
        pathVC.blockBack = ^(UIViewController *vc) {
            [weakSelf requestList];
        };
        [GB_Nav pushViewController:pathVC animated:true];
    };
    cell.blockDeleteClick  = ^(ModelPathListItem *item) {
        ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
        ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
        modelConfirm.blockClick = ^(void){
            [weakSelf requestDelete:item];
        };
        [BaseAlertView initWithTitle:@"确认删除？" content:@"确认删除此路线" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:[UIApplication sharedApplication].keyWindow];
    };
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MyPathListCell fetchHeight:self.aryDatas[indexPath.row]];
}


#pragma mark request
- (void)requestList{
    [RequestApi requestPathListDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.aryDatas = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelPathListItem"];        
        [self.tableView reloadData];

        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
}
- (void)requestDelete:(ModelPathListItem *)item{
    [RequestApi requestDeletePathWithId:item.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [self requestList];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
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
- (void)resetCellWithModel:(ModelPathListItem *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.btnDelete.rightTop = XY(SCREEN_WIDTH,0);

    self.btnEdit.rightTop = XY(self.btnDelete.left,0);

    CGFloat top = W(18);
    NSMutableArray * ary = @[^(){
        ModelBaseData * m = [ModelBaseData new];
        m.string = @"始发地：";
        m.subString = model.startShow;
        return m;
    }(),^(){
        ModelBaseData * m = [ModelBaseData new];
        m.string = @"目的地：";
               m.subString = model.endShow;
        return m;
    }()].mutableCopy;
    
    if (isStr(model.routePass3)) {
        [ary insertObject:^(){
            ModelBaseData * m = [ModelBaseData new];
            m.string = @"途径3：";
            m.subString = model.routePass3;
            return m;
        }() atIndex:1];
    }
    if (isStr(model.routePass2)) {
        [ary insertObject:^(){
            ModelBaseData * m = [ModelBaseData new];
            m.string = @"途径2：";
            m.subString = model.routePass2;
            return m;
        }() atIndex:1];
    }
    if (isStr(model.routePass1)) {
        [ary insertObject:^(){
            ModelBaseData * m = [ModelBaseData new];
            m.string = @"途径1：";
            m.subString = model.routePass1;
            return m;
        }() atIndex:1];
    }
    
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
