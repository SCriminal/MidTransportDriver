//
//  AddPathVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/31.
//Copyright © 2020 ping. All rights reserved.
//

#import "AddPathVC.h"
#import "BaseTableVC+Authority.h"
@interface AddPathVC ()
@property (nonatomic, strong) ModelBaseData *modelAddressStart;
@property (nonatomic, strong) ModelBaseData *modelAddressEnd;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation AddPathVC
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UIButton * btn = [UIButton createBottomBtn:@"添加途径地"];
        btn.centerXTop = XY(SCREEN_WIDTH/2.0, W(15));
        [btn addTarget:self action:@selector(addClick)];
        _bottomView.widthHeight = XY(SCREEN_WIDTH, btn.bottom);
        [_bottomView addSubview:btn];
    }
    return _bottomView;
}
- (ModelBaseData *)modelAddressStart{
    if (!_modelAddressStart) {
        _modelAddressStart = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"始发地";
            model.placeHolderString = @"选择始发地";
            WEAKSELF
            model.blocClick = ^(ModelBaseData *item) {
                
                
            };
            return model;
        }();
    }
    return _modelAddressStart;
}

- (ModelBaseData *)modelAddressEnd{
    if (!_modelAddressEnd) {
        WEAKSELF
        _modelAddressEnd = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"目的地";
            model.placeHolderString = @"选择目的地";
            model.blocClick = ^(ModelBaseData *modelClick) {
                [GlobalMethod endEditing];
                
            };
            return model;
        }();
    }
    return _modelAddressEnd;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self registAuthorityCell];
    self.tableView.tableFooterView = self.bottomView;
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"添加路线" rightTitle:@"保存" rightBlock:^{
        
    }];
    [nav configBackBlueStyle];
    [self.view addSubview:nav];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self dequeueAuthorityCell:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self fetchAuthorityCellHeight:indexPath];
}


#pragma mark request
- (void)requestList{
    self.aryDatas = @[self.modelAddressStart,self.modelAddressEnd].mutableCopy;
    [self.tableView reloadData];
}
- (void)addClick{
    ModelBaseData * model = [ModelBaseData new];
    model.enumType = ENUM_PERFECT_CELL_SELECT_DELETE;
    model.imageName = @"";
    model.string = [NSString stringWithFormat:@"途径%ld",self.aryDatas.count - 1];
    model.placeHolderString = @"选择途径地";
    WEAKSELF
    model.blockDeleteClick = ^(ModelBaseData *modelClick) {
        [GlobalMethod endEditing];
        [weakSelf.aryDatas removeObject:modelClick];
        for (int i = 1; i<(weakSelf.aryDatas.count -1); i++) {
            ModelBaseData * m = weakSelf.aryDatas[i];
            m.string = [NSString stringWithFormat:@"途径%ld",i];
        }
        [weakSelf.tableView reloadData];
    };
    [self.aryDatas insertObject:model atIndex:self.aryDatas.count - 1];
    [self.tableView reloadData];
}
@end
