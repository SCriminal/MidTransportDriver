//
//  FeedBackListManagementVC.m
//  Driver
//
//  Created by 隋林栋 on 2021/1/5.
//Copyright © 2021 ping. All rights reserved.
//

#import "FeedBackListManagementVC.h"
//滑动view
#import "SliderView.h"
//list vc
#import "FeedBackHistoryListVC.h"

@interface FeedBackListManagementVC ()<SliderViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *arySliderDatas;
@property (nonatomic, strong) BaseNavView *nav;
@property (strong, nonatomic) SliderView *sliderView;
@property (nonatomic, strong) UIScrollView *scAll;

@end

@implementation FeedBackListManagementVC
#pragma mark lazy init
- (UIScrollView *)scAll{
    if (_scAll == nil) {
        _scAll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.sliderView.bottom +1, SCREEN_WIDTH, SCREEN_HEIGHT - self.sliderView.height-NAVIGATIONBAR_HEIGHT)];
        _scAll.contentSize = CGSizeMake(SCREEN_WIDTH * self.arySliderDatas.count, 0);
        _scAll.backgroundColor = [UIColor clearColor];
        _scAll.delegate = self;
        _scAll.pagingEnabled = true;
        _scAll.scrollEnabled = false;
        _scAll.showsVerticalScrollIndicator = false;
        _scAll.showsHorizontalScrollIndicator = false;
    }
    return _scAll;
}


- (NSArray *)arySliderDatas{
    if (!_arySliderDatas) {
        _arySliderDatas = @[^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"投诉";
            return model;
        }()

                             ,^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"建议";
            return model;
        }()];
    }
    return _arySliderDatas;
}
#pragma mark 初始化子控制器
- (void)setupChildVC
{
    {
        FeedBackHistoryListVC * feedVC =  [FeedBackHistoryListVC new];
        feedVC.view.frame = CGRectMake(SCREEN_WIDTH*0, 0, self.scAll.width, self.scAll.height);
        feedVC.tableView.height = feedVC.view.height;
        [self addChildViewController:feedVC];
        [self.scAll addSubview:feedVC.view];
    }
    {
        SuggestHistoryListVC * feedVC =  [SuggestHistoryListVC new];
        feedVC.view.frame = CGRectMake(SCREEN_WIDTH*1, 0, self.scAll.width, self.scAll.height);
        feedVC.tableView.height = feedVC.view.height;
        [self addChildViewController:feedVC];
        [self.scAll addSubview:feedVC.view];
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
        _nav = [BaseNavView initNavBackTitle:@"历史投诉建议" rightTitle:@"" rightBlock:^{
            
        }];
        [_nav configBackBlueStyle];
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
    self.view.clipsToBounds = true;
    [self setupChildVC];
}

#pragma mark refresh all
- (void)refreshAll{
    for (BaseTableVC * tableVC in self.childViewControllers) {
        if (tableVC && [tableVC isKindOfClass:[BaseTableVC class]]) {
            [tableVC refreshHeaderAll];
        }
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
    [self.view addSubview:self.nav];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
