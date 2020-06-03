//
//  CarTeamListManagementVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/12/10.
//Copyright © 2019 ping. All rights reserved.
//

#import "CarTeamListManagementVC.h"
//滑动view
#import "SliderView.h"
//attact list vc
#import "AttachedCarTeamListVC.h"
//list vc
#import "CarTeamListVC.h"

@interface CarTeamListManagementVC ()<SliderViewDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) SliderView *sliderView;
@property (nonatomic, strong) UIScrollView *scAll;
@property (nonatomic, strong) NSArray *arySliderDatas;

@end

@implementation CarTeamListManagementVC
#pragma mark lazy init
- (UIScrollView *)scAll{
    if (_scAll == nil) {
        _scAll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.sliderView.bottom +1, SCREEN_WIDTH, SCREEN_HEIGHT - self.sliderView.height-NAVIGATIONBAR_HEIGHT)];
        _scAll.contentSize = CGSizeMake(SCREEN_WIDTH * self.arySliderDatas.count, 0);
        _scAll.backgroundColor = [UIColor clearColor];
        _scAll.delegate = self;
        _scAll.pagingEnabled = true;
        _scAll.showsVerticalScrollIndicator = false;
        _scAll.showsHorizontalScrollIndicator = false;
    }
    return _scAll;
}
- (NSArray *)arySliderDatas{
    if (!_arySliderDatas) {
        _arySliderDatas = @[^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"已申请";
            model.colorSelect = COLOR_333;
            model.color = COLOR_666;
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"已挂靠";
            model.colorSelect = COLOR_333;
            model.color = COLOR_666;
            return model;
        }()];
    }
    return _arySliderDatas;
}
- (SliderView *)sliderView{
    if (_sliderView == nil) {
        _sliderView = ^(){
            SliderView * sliderView = [SliderView new];
            sliderView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, W(50));
            sliderView.isHasSlider = true;
            sliderView.isScroll = false;
            sliderView.viewSlidColor = [UIColor colorWithHexString:@"4E4745"];
            sliderView.isLineVerticalHide = true;
            sliderView.viewSlidWidth = W(45);
            sliderView.delegate = self;
            [sliderView resetWithAry:self.arySliderDatas];
            return sliderView;
        }();
    }
    return _sliderView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self.view addSubview:^(){
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.clipsToBounds = true;
        iv.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.sliderView.bottom);
        iv.image = [UIImage imageNamed:@"nav_Bar"];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        return iv;
    }()];
    [self addNav];
    [self.view addSubview:self.sliderView];
    [self.view addSubview:self.scAll];
    [self setupChildVC];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshAll) name:NOTICE_MSG_REFERSH object:nil];
    
    [GlobalMethod requestBindDeviceToken];
    [GlobalMethod requestExtendToken];
}

#pragma mark 初始化子控制器
- (void)setupChildVC
{
    for (int i = 0; i <self.arySliderDatas.count; i++) {
        CarTeamListVC *sourceVC = [[CarTeamListVC alloc] init];
        sourceVC.isAttached = i == 1;
        sourceVC.view.frame = CGRectMake(SCREEN_WIDTH*i, 0, self.scAll.width, self.scAll.height);
        sourceVC.tableView.height = sourceVC.view.height;
        [self addChildViewController:sourceVC];
        [self.scAll addSubview:sourceVC.view];
    }
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
    WEAKSELF
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"我的车队" rightTitle:@"申请挂靠" rightBlock:^{
        AttachedCarTeamListVC * vc= [AttachedCarTeamListVC new];
        vc.blockBack = ^(UIViewController *vc) {
            if (vc.requestState) {
                [weakSelf refreshAll];
            }
        };
        [GB_Nav pushViewController:vc animated:true];
    }];
    nav.line.hidden = true;
    [self.view addSubview:nav];
    
}
#pragma mark refresh all
- (void)refreshAll{
    for (BaseTableVC * tableVC in self.childViewControllers) {
        if (tableVC && [tableVC isKindOfClass:[BaseTableVC class]]) {
            [tableVC refreshHeaderAll];
        }
    }
}

@end


