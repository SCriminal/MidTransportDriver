//
//  EditVC_Title.m
//中车运
//
//  Created by 隋林栋 on 2018/7/2.
//Copyright © 2018年 ping. All rights reserved.
//

#import "EditVC_Title.h"

@interface EditVC_Title ()
@property (nonatomic, strong) EditVC_TitleHeaderView *headerView;

@end

@implementation EditVC_Title

- (EditVC_TitleHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [EditVC_TitleHeaderView new];
        _headerView.content = self.content;
        _headerView.title = self.title;
        WEAKSELF
        _headerView.blockTextChange = ^(NSString *content) {
            weakSelf.content = content;
        };
        [_headerView resetView];
    }
    return _headerView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:UnPackStr(self.navTitle) rightTitle:@"保存" rightBlock:^{
        if (weakSelf.blockComplete) {
            weakSelf.blockComplete(weakSelf.content);
        }
        [GB_Nav popViewControllerAnimated:true];
    }]];
}

@end

@interface EditVC_TitleHeaderView()
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) PlaceHolderTextView *textView;
@end

@implementation EditVC_TitleHeaderView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_TITLE;
        _labelTitle.fontNum = F(15);
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineSpace = 0;
    }
    return _labelTitle;
}

- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.textColor = COLOR_SUBTITLE;
        _textView.font = [UIFont systemFontOfSize:F(15)];
        _textView.scrollEnabled = false;
        _textView.textContainerInset = UIEdgeInsetsMake(-W(2), -W(5), 0, -W(5));
        WEAKSELF
        _textView.blockTextChange = ^(PlaceHolderTextView *textView) {
            weakSelf.content = textView.text;
            if (weakSelf.blockTextChange) {
                weakSelf.blockTextChange(weakSelf.content);
            }
        };
        _textView.blockHeightChange  = ^(PlaceHolderTextView *textView) {
            CGFloat heightOrigin = weakSelf.height;
            [weakSelf resetCellWithoutTextView];
            CGFloat heightChange = weakSelf.height - heightOrigin;
            BaseTableVC * tableVC = (BaseTableVC *)[weakSelf fetchVC];
            if ([tableVC isKindOfClass:BaseTableVC.class] && heightChange) {
                [tableVC.tableView reloadCellHeight:heightChange];
            }
        };
        _textView.placeHolder.numberOfLines = 1;
    }
    
    return _textView;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.width = SCREEN_WIDTH;
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = true;
        [self addSubView];
    }
    return self;
}

//添加subview
- (void)addSubView{
    [self addSubview:self.labelTitle];
    [self addSubview:self.textView];
    
    //初始化页面
    [self resetView];
}

#pragma mark 刷新view
- (void)resetView{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelTitle fitTitle:UnPackStr(self.title) variable:0];
    self.labelTitle.leftTop = XY(W(15),W(15)+[self addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, W(10)) color:COLOR_BACKGROUND]);
    self.textView.text = self.content;
    [self resetCellWithoutTextView];
}

- (void)resetCellWithoutTextView{
    self.textView.leftTop = XY(W(15), W(15)+[self addLineFrame:CGRectMake(W(15), self.labelTitle.bottom + W(15), SCREEN_WIDTH-W(15), 1)]);
    self.textView.width = SCREEN_WIDTH - W(30);
    [self.textView changeLinesCallBlock:false];
    self.textView.height = MAX(self.textView.font.lineHeight * 2 + W(5), self.textView.numTextHeight);
    
    [GlobalMethod setLabel:_textView.placeHolder widthLimit:self.textView.width  numLines:0 fontNum:F(15) textColor:[UIColor lightGrayColor] text:@"填写"];
    
    self.height = self.textView.bottom + W(15);
}
@end
