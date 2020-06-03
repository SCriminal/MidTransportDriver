//
//  BaseVC.m
//中车运
//
//  Created by 隋林栋 on 2016/12/13.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "BaseVC.h"

//无结果页
#import "NoResultView.h"
//keyboard hide
#import "BaseVC+KeyboardObserve.h"

@interface BaseVC ()

@end

@implementation BaseVC



- (UIView *)viewBG{
    if (!_viewBG) {
        _viewBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _viewBG.backgroundColor = COLOR_BACKGROUND;
    }
    return _viewBG;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //增加侧滑
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:self.viewBG atIndex:0];
    
}
#pragma mark - add observe of keyboard
- (void)addObserveOfKeyboard{
    self.isKeyboardObserve = true;
}

#pragma mark view appear
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = [GlobalMethod canLeftSlide];
    if (self.isKeyboardObserve) {
        [self addKeyboardObserve];
    }
#ifdef DEBUG
    NSLog(@"current vc - %@",NSStringFromClass(self.class));
#endif
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.isKeyboardObserve) {
        [self removeKeyboardObserve];
    }
}

#pragma mark 懒加载
- (LoadingView *)loadingView{
    if (_loadingView == nil) {
        _loadingView = [LoadingView new];
    }
    return _loadingView;
}

- (NoticeView *)noticeView{
    if (_noticeView == nil) {
        _noticeView = [NoticeView new];
    }
    return _noticeView;
}

- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
    }
    return _noResultView;
}
- (NoResultView *)noResultLoadingView{
    if (!_noResultLoadingView) {
        _noResultLoadingView = [NoResultView new];
    }
    return _noResultLoadingView;
}
#pragma mark 请求过程回调
- (void)protocolWillRequest{
    [self showNoResultLoadingView];
    [self showLoadingView];
}
//show loading view
- (void)showLoadingView{
    [self.loadingView hideLoading];
    if (self.isNotShowLoadingView) {
        return;
    }
    [self.loadingView resetFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT) viewShow:self.view];
}
#pragma mark noresult before request
- (void)showNoResultLoadingView{
    [self.noResultLoadingView removeFromSuperview];
    if(!self.isShowNoResultLoadingView)return;
    [self.noResultLoadingView showInView:self.view frame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT)];
}
- (void)showNoResult{
    [self.noResultLoadingView removeFromSuperview];
    [self.noResultView removeFromSuperview];
    
    if(!self.isShowNoResult)return;
    [self.noResultView showInView:self.view frame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT)];
}
- (void)protocolDidRequestSuccess{
    [self.loadingView hideLoading];
}
- (void)protocolDidRequestFailure:(NSString *)errorStr{
    [self.loadingView hideLoading];
    if (self.isNotShowNoticeView) {
        return;
    }
    [GlobalMethod endEditing];
    if ([self.view isShowInScreen]&&isStr(errorStr)) {
        [self.noticeView showNotice:errorStr time:1 frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) viewShow:[UIApplication sharedApplication].keyWindow];
    }
}

#pragma mark textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:true];
    return true;
}

#pragma mark 销毁
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark 改变statusbar颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return [GlobalData sharedInstance].statusBarStyle;
}
- (BOOL)prefersStatusBarHidden{
    return [GlobalData sharedInstance].statusHidden;
}


@end
