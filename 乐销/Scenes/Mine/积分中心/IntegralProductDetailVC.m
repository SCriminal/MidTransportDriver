//
//  IntegralProductDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/27.
//Copyright © 2020 ping. All rights reserved.
//

#import "IntegralProductDetailVC.h"
//subview
#import "IntegralProductDetailView.h"
#import "AutoScView.h"
//request

@interface IntegralProductDetailVC ()<UIWebViewDelegate>
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) IntegralProductDetailView *titleView;
@property (nonatomic, strong) UIView *viewBottom;
@property (nonatomic, strong) AutoScView *autoSCView;
@property (nonatomic, strong) ModelIntegralProduct *modelDetail;
@property (strong, nonatomic) UIWebView *webDetail;

@end

@implementation IntegralProductDetailVC
- (UIWebView *)webDetail{
    if (!_webDetail) {
        _webDetail = [UIWebView new];
        _webDetail.delegate = self;
        _webDetail.width = SCREEN_WIDTH;
        _webDetail.height = 1;
        _webDetail.left = 0;
        _webDetail.scrollView.showsVerticalScrollIndicator = false;
        _webDetail.scrollView.showsHorizontalScrollIndicator = false;
        _webDetail.scrollView.scrollEnabled = false;
    }
    return _webDetail;
}
- (UIView *)viewBottom{
    if (!_viewBottom) {
        _viewBottom = [UIView new];
        _viewBottom.backgroundColor = [UIColor clearColor];
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.widthHeight = XY(W(355), W(39));
            btn.backgroundColor = COLOR_BLUE;
            [btn setTitle:@"立即兑换" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnChangeClick) forControlEvents:UIControlEventTouchUpInside];
            [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:0 lineColor:[UIColor clearColor]];
            btn.centerXTop = XY(SCREEN_WIDTH/2.0, W(10));
            [_viewBottom addSubview:btn];
        }
        _viewBottom.widthHeight = XY(SCREEN_WIDTH, W(58) +iphoneXBottomInterval);
        _viewBottom.bottom = SCREEN_HEIGHT;
    }
    return _viewBottom;
}
- (IntegralProductDetailView *)titleView{
    if (!_titleView) {
        _titleView = [IntegralProductDetailView new];
    }
    return _titleView;
}
- (UIView *)header{
    if (!_header) {
        _header = [UIView new];
        _header.backgroundColor = [UIColor whiteColor];
    }
    return _header;
}

- (AutoScView *)autoSCView{
    if (!_autoSCView) {
        _autoSCView = [[AutoScView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, W(323)) image:@[]];
        _autoSCView.pageCurrentColor = [UIColor whiteColor];
        _autoSCView.pageDefaultColor = [UIColor colorWithHexString:@"ffffff" alpha:0.5];
        _autoSCView.pageControlToBottom = W(30);
//        _autoSCView.isClickValid = true;
        [_autoSCView timerStart];
    }
    return _autoSCView;
}

- (BaseNavView *)nav{
    if (!_nav) {
        _nav = [BaseNavView initNavTitle:@"" leftImageName:@"nav_black_back" leftImageSize:CGSizeMake(W(30), W(30)) leftBlock:^{
            [GB_Nav popViewControllerAnimated:true];
        } rightImageName:nil rightImageSize:CGSizeZero righBlock:nil];
        _nav.backgroundColor = [UIColor clearColor];
    }
    return _nav;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.viewBottom];
    //table
    self.tableView.top = 0;
    self.tableView.height = SCREEN_HEIGHT- self.viewBottom.height;
//    [self.tableView registerClass:[<#CellName#> class] forCellReuseIdentifier:@"<#CellName#>"];
    //request
    [self requestDetail];
}

- (void)config{
    [self.header removeAllSubViews];
    [self.autoSCView resetWithImageAry:self.modelDetail.urls];
    [self.header addSubview:self.autoSCView];
    
    [self.header addSubview:self.nav];
    self.titleView.top = self.autoSCView.bottom;
    [self.header addSubview:self.titleView];
    
    self.webDetail.top = self.titleView.bottom;
    [self.header addSubview:self.webDetail];
    self.header.height = self.webDetail.bottom;
    self.tableView.tableHeaderView = self.header;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat webViewHeight1 = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    webView.frame = CGRectMake(webView.frame.origin.x,webView.frame.origin.y, SCREEN_WIDTH, webViewHeight1);
    self.header.height = self.webDetail.bottom;
    self.tableView.tableHeaderView = self.header;
    
}


#pragma mark request
- (void)requestDetail{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:@"LocalData_Model" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:strPath];
    // 对数据进行JSON格式化并返回字典形式
    NSDictionary * response = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.modelDetail = [ModelIntegralProduct modelObjectWithDictionary:response[@"ModelIntegralProduct"]];
            [self.titleView resetViewWithModel:self.modelDetail];
    
            [self.webDetail loadHTMLString:[UnPackStr(self.modelDetail.body) fitWebImage] baseURL:nil];
            [self config];

//    [RequestApi requestIntegralProductDetailWithId:self.integralProductID delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
//
//    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
//
//    }];
    
}
- (void)btnChangeClick{
    
}


@end
