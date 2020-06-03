//
//  LeftMenuVC.m
//  Driver
//
//  Created by 隋林栋 on 2018/11/29.
//Copyright © 2018 ping. All rights reserved.
//

#import "LeftMenuVC.h"
//cell
#import "LeftMenuCell.h"
//deck view
#import "UIViewController+IIViewDeckAdditions.h"
#import "IIViewDeckController.h"
//top view
#import "LeftMenuTopView.h"
//request
#import "RequestApi+UserApi.h"
@interface LeftMenuVC ()
@property (nonatomic, strong) LeftMenuTopView *topView;

@end

@implementation LeftMenuVC

#pragma mark lazy init
- (LeftMenuTopView *)topView{
    if (!_topView) {
        _topView = [LeftMenuTopView new];
        WEAKSELF
        _topView.blockClick = ^{
            [weakSelf.viewDeckController closeSide:true];
            //            [GlobalMethod judgeLoginState:^{
            [GB_Nav pushVCName:@"DriverDetailVC" animated:true];
            //            }];
        };
    }
    return _topView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(W(250), SCREEN_HEIGHT);
    self.viewBG.backgroundColor = [UIColor clearColor];
    //bg
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableBackgroundView.backgroundColor = [UIColor whiteColor];
    self.tableView.top = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(STATUSBAR_HEIGHT, 0, 0, 0);
    self.tableView.widthHeight = XY(self.preferredContentSize.width, SCREEN_HEIGHT - STATUSBAR_HEIGHT);
    //table
    [self.tableView registerClass:[LeftMenuCell class] forCellReuseIdentifier:@"LeftMenuCell"];
    self.tableView.tableHeaderView = self.topView;
    //request
    [self configData];
}



#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBtn * model = self.aryDatas[indexPath.row];
    
    LeftMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LeftMenuCell"];
    [cell resetCellWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBtn * model = self.aryDatas[indexPath.row];
    return [LeftMenuCell fetchHeight:model];
}


#pragma mark request
- (void)configData{
    WEAKSELF
    self.aryDatas = @[
                      //                      ^(){
                      //        ModelBtn * model = [ModelBtn new];
                      //        model.title = @"兴趣周边";
                      //        model.imageName = @"setting_surrounding";
                      //        model.subTitle = @"";
                      //        model.blockClick = ^{
                      //            [weakSelf.viewDeckController closeSide:true];
                      //
                      //        };
                      //        return model;
                      //    }(),
                      ^(){
                          ModelBtn * model = [ModelBtn new];
                          model.title = @"运单";
                          model.imageName = @"setting_waybill";
                          model.blockClick = ^{
                              [weakSelf.viewDeckController closeSide:true];
                              
                          };
                          return model;
                      }(),
//                       ^(){
//                           ModelBtn * model = [ModelBtn new];
//                           model.title = @"散货运单";
//                           model.imageName = @"setting_bulk";
//                           model.blockClick = ^{
//                               [weakSelf.viewDeckController closeSide:true];
//                               [GB_Nav pushVCName:@"BulkCargoListManageVC" animated:true];
//
//                           };
//                           return model;
//                       }(),
                       ^(){
                           ModelBtn * model = [ModelBtn new];
                           model.title = @"记账本";
                           model.imageName = @"setting_charge";
                           model.blockClick = ^{
                               [weakSelf.viewDeckController closeSide:true];
                               [GB_Nav pushVCName:@"AccountListVC" animated:true];
                           };
                           return model;
                       }(),^(){
                           ModelBtn * model = [ModelBtn new];
                           model.title = @"设置";
                           model.imageName = @"setting_set";
                           model.subTitle = @"";
                           model.blockClick = ^{
                               [weakSelf.viewDeckController closeSide:true];
                               [GB_Nav pushVCName:@"SettingVC" animated:true];
                           };
                           return model;
                       }()].mutableCopy;
    [self.tableView reloadData];
}


@end
