//
//  PerfectAddressDetailCell.m
//中车运
//
//  Created by 隋林栋 on 2018/10/24.
//Copyright © 2018年 ping. All rights reserved.
//

#import "PerfectAddressDetailCell.h"


@implementation PerfectAddressDetailCell
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_666;
        _title.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        [_title fitTitle:@"个性签名" variable:0];
    }
    return _title;
}


- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.textColor = COLOR_333;
        _textView.placeHolder.fontNum = F(16);
        _textView.placeHolder.textColor = COLOR_999;
        [_textView.placeHolder fitTitle:@"简单介绍一下自己吧" variable:0];
        _textView.font = [UIFont systemFontOfSize:F(16)];
        _textView.scrollEnabled = false;
        _textView.textContainerInset = UIEdgeInsetsMake(-W(2), -W(5), 0, -W(5));
        WEAKSELF
        _textView.blockTextChange = ^(PlaceHolderTextView *textView) {
            weakSelf.model.subString = textView.text;
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
        
    }
    return _textView;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.textView];
        //初始化页面
        [self resetCellWithModel:nil];
    }
    return self;
}


#pragma mark 刷新view
- (void)resetCellWithModel:(ModelBaseData *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.title.leftTop = XY(W(15),  W(25));
    
    self.textView.leftTop = XY(W(99),self.title.top);
    self.textView.text = model.subString;
    [self resetCellWithoutTextView];
}

- (void)resetCellWithoutTextView{
    
    self.textView.leftTop = XY(W(99),self.title.top);
    self.textView.width = SCREEN_WIDTH - W(99) - W(15);
    [self.textView changeLinesCallBlock:false];
    self.textView.height = MAX(self.textView.font.lineHeight , self.textView.numTextHeight);
    [self.textView changeLinesCallBlock:false];
    
    self.height = self.textView.bottom + W(25);
}

@end
