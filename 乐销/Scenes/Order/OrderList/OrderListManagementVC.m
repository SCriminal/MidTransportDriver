//
//  OrderListManagementVC.m
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import "OrderListManagementVC.h"
//滑动view
#import "SliderView.h"
//list vc
#import "OrderListVC.h"
//deck view
#import "UIViewController+IIViewDeckAdditions.h"
#import "IIViewDeckController.h"
//top slider view
#import "OrderManagementBottomView.h"
#import "BulkCargoListManageVC.h"
@interface OrderListManagementVC ()<SliderViewDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) SliderView *sliderView;
@property (nonatomic, strong) UIScrollView *scAll;
@property (nonatomic, assign) BOOL isNotFirstLoad;
@property (nonatomic, strong) NSArray *arySliderDatas;
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) UIImageView *ivHead;
@property (nonatomic, strong) UIControl *conHead;
@property (nonatomic, strong) OrderManagementBottomView *bottomTypeSwitchView;
@property (nonatomic, strong) BulkCargoListManageVC *bulkManageVC;

@end

@implementation OrderListManagementVC
#pragma mark lazy init
- (UIScrollView *)scAll{
    if (_scAll == nil) {
        _scAll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.sliderView.bottom +1, SCREEN_WIDTH, SCREEN_HEIGHT - self.sliderView.height-NAVIGATIONBAR_HEIGHT - HEIGHT_ORDERMANAGEMENTBOTTOMVIEW)];
        _scAll.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
        _scAll.backgroundColor = [UIColor clearColor];
        _scAll.delegate = self;
        _scAll.pagingEnabled = true;
        _scAll.showsVerticalScrollIndicator = false;
        _scAll.showsHorizontalScrollIndicator = false;
    }
    return _scAll;
}
- (UIImageView *)ivHead{
    if (!_ivHead) {
        _ivHead = [UIImageView new];
        _ivHead.backgroundColor = [UIColor clearColor];
        _ivHead.widthHeight = XY(W(30), W(30));
        [GlobalMethod setRoundView:_ivHead color:[UIColor clearColor] numRound:_ivHead.width/2.0 width:0];
        [_ivHead sd_setImageWithURL:[NSURL URLWithString:[GlobalData sharedInstance].GB_UserModel.headUrl] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    }
    return _ivHead;
}
- (UIControl *)conHead {
    if (!_conHead) {
        _conHead = [UIControl new];
        _conHead.frame = CGRectMake(0, STATUSBAR_HEIGHT, W(100), NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT);
        [_conHead addSubview:self.ivHead];
        self.ivHead.leftCenterY = XY(W(20), _conHead.height/2.0);
        [_conHead addTarget:self action:@selector(headClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _conHead;
}
- (BulkCargoListManageVC *)bulkManageVC{
    if (!_bulkManageVC) {
        _bulkManageVC = [BulkCargoListManageVC new];
        _bulkManageVC.view.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - HEIGHT_ORDERMANAGEMENTBOTTOMVIEW);
//        _bulkManageVC.view.hidden = true;
    }
    return _bulkManageVC;
}
- (NSArray *)arySliderDatas{
    if (!_arySliderDatas) {
        _arySliderDatas = @[^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"进行中";
            model.num = ENUM_ORDER_LIST_SORT_GOING;
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"待接单";
            model.num = ENUM_ORDER_LIST_SORT_WAIT_RECEIVE;
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"已完成";
            model.num = ENUM_ORDER_LIST_SORT_COMPLETE;
            return model;
        }()];
    }
    return _arySliderDatas;
}
- (OrderManagementBottomView *)bottomTypeSwitchView{
    if (!_bottomTypeSwitchView) {
        _bottomTypeSwitchView = [OrderManagementBottomView new];
        _bottomTypeSwitchView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        _bottomTypeSwitchView.blockIndexChange = ^(int index) {
                weakSelf.bulkManageVC.view.hidden = index == 1;
        };
        _bottomTypeSwitchView.blockMainClick = ^(void) {
            [GB_Nav pushVCName:@"ScanOrderListVC" animated:true];
        };
    }
    return _bottomTypeSwitchView;
}
#pragma mark 初始化子控制器
- (void)setupChildVC
{
    WEAKSELF
    for (int i = 0; i <self.arySliderDatas.count; i++) {
        ModelBtn * model = self.arySliderDatas[i];
        OrderListVC *sourceVC = [[OrderListVC alloc] init];
        sourceVC.blockTotal = ^(ENUM_ORDER_LIST_SORT type, int total) {
            NSString * strTotal = total?[NSString stringWithFormat:@"(%d)",total]:@"";
//            if (total>99) {
//                strTotal = @"(99+)";
//            }
            if (type == ENUM_ORDER_LIST_SORT_GOING) {
                [weakSelf.sliderView refreshBtn:0 title:[NSString stringWithFormat:@"进行中%@",strTotal]];
            }
            if (type == ENUM_ORDER_LIST_SORT_WAIT_RECEIVE) {
                [weakSelf.sliderView refreshBtn:1 title:[NSString stringWithFormat:@"待接单%@",strTotal]];
            }
            
            if (type == ENUM_ORDER_LIST_SORT_COMPLETE) {
                [weakSelf.sliderView refreshBtn:2 title:[NSString stringWithFormat:@"已完成%@",strTotal]];
            }
        };
        sourceVC.sortType = model.num;
        sourceVC.view.frame = CGRectMake(SCREEN_WIDTH*i, 0, self.scAll.width, self.scAll.height);
        sourceVC.tableView.height = sourceVC.view.height;
        [self addChildViewController:sourceVC];
        [self.scAll addSubview:sourceVC.view];
    }
}
- (SliderView *)sliderView{
    if (_sliderView == nil) {
        _sliderView = ^(){
            SliderView * sliderView = [SliderView new];
            sliderView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, W(50));
            sliderView.isHasSlider = true;
            sliderView.isScroll = false;
            sliderView.isLineVerticalHide = true;
            sliderView.viewSlidColor = [UIColor colorWithHexString:@"4E4745"];
            sliderView.viewSlidWidth = W(45);
            sliderView.delegate = self;
            sliderView.line.hidden = true;
            [sliderView resetWithAry:self.arySliderDatas];
            return sliderView;
        }();
    }
    return _sliderView;
}
- (BaseNavView *)nav{
    if (!_nav) {
        _nav = [BaseNavView initNavTitle:@"运单中心" leftView:self.conHead rightView:nil];
        _nav.line.hidden = true;
    }
    return _nav;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.sliderView];
    [self.view addSubview:self.scAll];
    [self setupChildVC];
    [self addBulkVC];
    [self.view addSubview:self.bottomTypeSwitchView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reconfigView) name:NOTICE_SELFMODEL_CHANGE object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshAll) name:NOTICE_ORDER_REFERSH object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshAll) name:UIApplicationDidBecomeActiveNotification object:nil];
    //request extend token
    [GlobalMethod requestExtendToken];
    
}
#pragma mark view did appear
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!self.isNotFirstLoad) {
        self.isNotFirstLoad = true;
        return;
    }
    [self refreshAll];
}

#pragma mark refresh all
- (void)refreshAll{
    for (BaseTableVC * tableVC in self.childViewControllers) {
        if (tableVC && [tableVC isKindOfClass:[BaseTableVC class]]) {
            [tableVC refreshHeaderAll];
        }
    }
}
#pragma mark refonfig view
- (void)reconfigView{
    [self.ivHead sd_setImageWithURL:[NSURL URLWithString:[GlobalData sharedInstance].GB_UserModel.headUrl] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
}
#pragma mark click
- (void)headClick{
    [self.viewDeckController openSide:IIViewDeckSideLeft animated:YES];
}
#pragma mark scrollview delegat
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self fetchCurrentView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self fetchCurrentView];
    }
}
- (void)fetchCurrentView {
    // 获取已经滚动的比例
    double ratio = self.scAll.contentOffset.x / SCREEN_WIDTH;
    int    page  = (int)(ratio + 0.5);
    // scrollview 到page页时 将toolbar调至对应按钮
    [self.sliderView sliderToIndex:page noticeDelegate:NO];
}
#pragma mark slider delegate
- (void)protocolSliderViewBtnSelect:(NSUInteger)tag btn:(CustomSliderControl *)control{
    [UIView animateWithDuration:0.5 animations:^{
        self.scAll.contentOffset = CGPointMake(SCREEN_WIDTH * tag, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:self.nav];
  
}
- (void)addBulkVC{
    [self addChildViewController:self.bulkManageVC];
    [self.view addSubview:self.bulkManageVC.view];
}
#pragma mark status bar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

@end
