//
//  CustomAttributeTextView.m
//  乐销
//
//  Created by 隋林栋 on 2017/10/31.
//Copyright © 2017年 ping. All rights reserved.
//

#import "CustomAttributeTextView.h"


@interface CustomAttributeTextView ()<YYTextViewDelegate>


@end

@implementation CustomAttributeTextView

#pragma mark lazy init
- (YYTextView *)textView{
    if (!_textView) {
        _textView = [YYTextView new];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.size = CGSizeMake(SCREEN_WIDTH - W(30), W(80));
        _textView.left = W(15);
        _textView.top = W(15);
        _textView.allowsCopyAttributedString = YES;
        _textView.allowsPasteAttributedString = YES;
        _textView.delegate = self;
        _textView.scrollEnabled = false;
         _textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0 );
        if (@available(iOS 11.0, *)) {
            _textView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _textView.scrollIndicatorInsets = _textView.contentInset;
        _textView.placeholderText = @"填写说明";
        _textView.placeholderFont = [UIFont systemFontOfSize:F(14)];
        _textView.placeholderTextColor = [UIColor lightGrayColor];
        _textView.bounces = false;
        _textView.scrollEnabled = false;

        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@" "];
        text.font = [UIFont systemFontOfSize:F(14)];
        text.lineSpacing = W(7);
        text.color = COLOR_TITLE;
        _textView.attributedText = text;

//        _textView.attributedText = ^(){
//            NSMutableAttributedString *text = [NSMutableAttributedString new];
//            text.lineSpacing = W(7);
//            text.font = [UIFont systemFontOfSize:F(17)];
//            text.color = COLOR_TITLE;
//            return text;
//        }();
    }
    return _textView;
}
- (ModelCell_TextView *)modelTextView{
    if (!_modelTextView) {
        _modelTextView = [ModelCell_TextView new];
    }
    return _modelTextView;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        self.heightMinimum = W(100);//height minimum
        self.textView.height = self.heightMinimum;
        self.height = self.textView.bottom;
        [self addSubview:self.textView];
        [self resetViewWithModel:nil];
    }
    return self;
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelCell_TextView *)model {
    self.modelTextView = model;
    self.textView.attributedText = model.attributeStr;
    
    [self reconfigHeight];
}
#pragma mark text
- (void)textViewDidChange:(YYTextView *)textView{
    self.modelTextView.attributeStr = [[NSMutableAttributedString alloc]initWithAttributedString:textView.attributedText];
    [self changeLinesCallBlock];
}

- (void)changeLinesCallBlock{
    CGFloat heightOrigin = self.height;
    [self reconfigHeight];
    CGFloat heightChange =  self.height - heightOrigin;
    if (heightChange) {
        BaseTableVC * tableVC = (BaseTableVC *)[self fetchVC];
        if ([tableVC isKindOfClass:BaseTableVC.class] && heightChange) {
            [tableVC.tableView reloadCellHeight:heightChange];
        }
    }
}

- (void)reconfigHeight{
//    self.textView.height = MAX(self.heightMinimum, self.textView.textLayout.textBoundingSize.height+W(30));
//    self.height = self.textView.bottom-W(30);
    self.textView.height = MAX(self.heightMinimum, self.textView.textLayout.textBoundingSize.height);
    self.height = self.textView.bottom;
}
@end
