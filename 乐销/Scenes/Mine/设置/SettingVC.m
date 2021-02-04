//
//  SettingVC.m
//中车运
//
//  Created by 隋林栋 on 2018/11/13.
//Copyright © 2018 ping. All rights reserved.
//

#import "SettingVC.h"
//cell
#import "SettingCell.h"
//网络加载图片
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDImageCache.h>
//input code
#import "InputCodeVC.h"
//request
#import "RequestDriver2.h"
@interface SettingVC ()
@property (nonatomic, strong) UIView *loginoutView;

@end

@implementation SettingVC

- (UIView *)loginoutView{
    if (!_loginoutView) {
        _loginoutView = [UIView new];
        _loginoutView.backgroundColor = [UIColor clearColor];
        _loginoutView.widthHeight = XY(SCREEN_WIDTH, W(45)+ W(10));
        [_loginoutView addSubview:^(){
            UILabel * label = [UILabel new];
            label.frame = CGRectMake(0, W(10), SCREEN_WIDTH, W(45));
            label.backgroundColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
            label.textColor = COLOR_333;
            label.text = @"退出登录";
            return label;
        }()];
        [_loginoutView addTarget:self action:@selector(requestLogout)];
    }
    return _loginoutView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[SettingCell class] forCellReuseIdentifier:@"SettingCell"];
    [self.tableView registerClass:[SettingEmptyCell class] forCellReuseIdentifier:@"SettingEmptyCell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    //notice
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(configData) name:NOTICE_SELFMODEL_CHANGE object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(configData) name:UIApplicationDidBecomeActiveNotification object:nil];

    //config data
    [self configData];

}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"系统设置" rightView:nil];
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBtn * model = self.aryDatas[indexPath.row];
    if (!isStr(model.title)) {
        SettingEmptyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SettingEmptyCell"];
        [cell resetCellWithModel:nil];
        return cell;
    }
    SettingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell"];
    [cell resetCellWithModel:model];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBtn * model = self.aryDatas[indexPath.row];
    if (!isStr(model.title)) {
        return [SettingEmptyCell fetchHeight:model];
    }
    return [SettingCell fetchHeight:model];
}

#pragma mark request
- (void)configData{
    WEAKSELF
    self.aryDatas = @[^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"投诉建议";
        model.isLineHide = false;
        model.blockClick = ^{
            [GB_Nav pushVCName:@"FeedBackManagementVC" animated:true];
        };
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"清除缓存";
        model.isLineHide = false;
        SDImageCache * cache = [SDImageCache sharedImageCache];
        model.subTitle = [NSString stringWithFormat:@"%.2lfM",[cache getSize]/(1024.0*1024.0)];
        model.blockClick = ^{
            SDImageCache * cache = [SDImageCache sharedImageCache];
            [cache clearDisk];
            [GlobalMethod showAlert:@"清理完毕"];
            [weakSelf configData];
        };
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"消息推送";
        model.isLineHide = false;
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        model.subTitle = [NSString stringWithFormat:@"%@",UIUserNotificationTypeNone != setting.types ?@"已开启":@"未开启"];
        model.blockClick = ^{
            if (UIApplicationOpenSettingsURLString != NULL) {
                UIApplication *application = [UIApplication sharedApplication];
                NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                    [application openURL:URL options:@{} completionHandler:nil];
                } else {
                    [application openURL:URL];
                }
            }
        };
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"关于版本";
        model.isLineHide = true;
        NSString * strVersion = [NSString stringWithFormat:@"当前版本%@",[GlobalMethod getVersion]];
#ifdef DEBUG
        strVersion = [NSString stringWithFormat:@"%@test",strVersion];
#endif
        model.subTitle = strVersion;
        model.blockClick = ^{
            [GlobalMethod requestVersion:^{
                [GlobalMethod showAlert:@"已经是最新版本"];
            }];
        };
        return model;
    }(),].mutableCopy;
    
    self.tableView.tableFooterView =[GlobalMethod isLoginSuccess]?self.loginoutView:nil;
    [self.tableView reloadData];
}

#pragma mark request
- (void)requestLogout{
    [RequestApi requestLogoutWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        [GB_Nav popViewControllerAnimated:true];
    }];
}

#pragma mark 销毁
- (void)dealloc{
    NSLog(@"%s  %@",__func__,self.class);
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
