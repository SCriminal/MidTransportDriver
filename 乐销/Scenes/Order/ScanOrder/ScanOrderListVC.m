//
//  ScanOrderListVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/11/19.
//Copyright © 2019 ping. All rights reserved.
//

#import "ScanOrderListVC.h"
//cell
#import "ScanListCell.h"
//request
#import "RequestApi+Schedule.h"
//info vc
#import "ScheduleOrderInfoVC.h"
//qrvc
#import "QRCoderVC.h"
//rquest
#import "RequestApi+UserApi.h"

@interface ScanOrderListVC ()
@property (nonatomic, strong) UIImageView *ivScan;

@end

@implementation ScanOrderListVC
@synthesize noResultView = _noResultView;
#pragma mark lazy init
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_scan_list" title:@"暂无扫码运单"];
        _noResultView.backgroundColor = [UIColor clearColor];
    }
    return _noResultView;
}
- (UIImageView *)ivScan{
    if (!_ivScan) {
        _ivScan = [UIImageView new];
        _ivScan.widthHeight = XY(W(117), W(117));
        _ivScan.image = [UIImage imageNamed:@"scan_list"];
        _ivScan.centerXBottom = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT - iphoneXBottomInterval);
        [_ivScan addTarget:self action:@selector(scanClick)];
    }
    return _ivScan;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.ivScan];
    //table
    [self.tableView registerClass:[ScanListCell class] forCellReuseIdentifier:@"ScanListCell"];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, W(10), 0);
    
    self.tableView.backgroundColor = [UIColor clearColor];
    //request
    [self requestList];
    [self addRefreshFooter];
    [self addRefreshHeader];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"扫码运单中心" rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ScanListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ScanListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ScanListCell fetchHeight:self.aryDatas[indexPath.row]];
}


#pragma mark request
- (void)requestList{
    [RequestApi requestScheduleListWithPlannumber:nil waybillNumber:nil driverName:nil driverPhone:nil vehicleNumber:nil startTime:0 endTime:0 states:@"1,21" page:self.pageNum count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelScheduleList"];
        
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

#pragma mark click
- (void)scanClick{
    if ([GlobalData sharedInstance].GB_UserModel.reviewStatus == 3) {
        [self requestCarList];
    }else{
        [RequestApi requestUserInfoWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            ModelBaseInfo * model = [ModelBaseInfo modelObjectWithDictionary:response];
            if (model.reviewStatus == 3) {
                [self requestCarList];
            }else{
                [GlobalMethod showBigAlert:@"审核通过才可以扫码下单"];
            }
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }
}

- (void)requestCarList{
    [RequestApi requestValidCarListWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelValidCar"];
        if (ary.count == 0) {
            [self requestPersonalCar];
            return;
        }
        QRCoderVC * vc = [QRCoderVC new];
        [GB_Nav pushViewController:vc animated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestPersonalCar{
    [RequestApi requestCarListWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self.aryDatas removeAllObjects];
        NSMutableArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelValidCar"];
        if (ary.count) {
            [GlobalMethod showBigAlert:@"车辆信息已经提交，审核通过后请扫码下单"];
            [GB_Nav pushVCName:@"CarListVC" animated:true];
        }else{
            ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
            ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
            modelConfirm.blockClick = ^(void){
                [GB_Nav pushVCName:@"AddCarVC" animated:true];
            };
            [BaseAlertView initWithTitle:@"提示" content:@"挂靠或添加车辆才能扫码下单" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:[UIApplication sharedApplication].keyWindow];
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
