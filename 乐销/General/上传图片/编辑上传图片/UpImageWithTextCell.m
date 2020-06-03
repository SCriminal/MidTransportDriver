//
//  UpImageWithTextCell.m
//中车运
//
//  Created by 宋晨光 on 17/3/13.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "UpImageWithTextCell.h"
//show image
#import "UIView+SelectImageView.h"
//base image
#import "BaseImage.h"
//up image
#import "AliClient.h"

@implementation UpImageWithTextCell

#pragma mark 懒加载

-(UIButton *)greenAddButton{
    if (_greenAddButton == nil) {
        _greenAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _greenAddButton.tag = 1;
        [_greenAddButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _greenAddButton.backgroundColor = [UIColor clearColor];
        [_greenAddButton setImage:[UIImage imageNamed:@"image_select_tj"] forState:UIControlStateNormal];
        [GlobalMethod setRoundView:_greenAddButton color:[UIColor clearColor] numRound:5 width:0];
        _greenAddButton.widthHeight = XY(SCREEN_WIDTH - W(30),W(40));
    }
    return _greenAddButton;
}

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        [GlobalMethod setRoundView:_bgView color:nil numRound:4 width:0];
    }
    return _bgView;
}

-(UIButton *)redDeleteButton{
    if (_redDeleteButton == nil) {
        _redDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _redDeleteButton.tag = 5;
        [_redDeleteButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _redDeleteButton.backgroundColor = [UIColor clearColor];
        [_redDeleteButton setImage:[UIImage imageNamed:@"image_select_del"] forState:UIControlStateNormal];
        [GlobalMethod setRoundView:_redDeleteButton color:[UIColor clearColor] numRound:5 width:0];
        _redDeleteButton.widthHeight = XY(SCREEN_WIDTH - W(30),W(40));
    }
    return _redDeleteButton;
}

- (UIImageView *)headImgView{
    if (_headImgView == nil) {
        _headImgView = [UIImageView new];
        _headImgView.image = [UIImage imageNamed:@"image_select_add"];
        _headImgView.widthHeight = XY(W(70),W(70));
        _headImgView.userInteractionEnabled = true;
        _headImgView.contentMode = UIViewContentModeScaleAspectFill;
        _headImgView.clipsToBounds = true;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [_headImgView addGestureRecognizer:tap];
    }
    return _headImgView;
}

-(UIButton *)topButton{
    if (_topButton == nil) {
        _topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _topButton.tag = 10;
        [_topButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _topButton.backgroundColor = [UIColor clearColor];
        _topButton.titleLabel.font = [UIFont systemFontOfSize:W(18)];
        [GlobalMethod setRoundView:_topButton color:[UIColor clearColor] numRound:5 width:0];
        [_topButton setImage:[UIImage imageNamed:@"image_select_up"] forState:UIControlStateNormal];
        _topButton.widthHeight = XY(SCREEN_WIDTH - W(30),W(40));
    }
    return _topButton;
}

-(UIButton *)downButton{
    if (_downButton == nil) {
        _downButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _downButton.tag = 11;
        [_downButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _downButton.backgroundColor = [UIColor clearColor];
        _downButton.titleLabel.font = [UIFont systemFontOfSize:W(18)];
        [GlobalMethod setRoundView:_downButton color:[UIColor clearColor] numRound:5 width:0];
        [_downButton setImage:[UIImage imageNamed:@"image_select_down"] forState:UIControlStateNormal];
        _downButton.widthHeight = XY(SCREEN_WIDTH - W(30),W(40));
    }
    return _downButton;
}

- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.delegate = self;
        [GlobalMethod setLabel:_textView.placeHolder widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_SUBTITLE text:@"点击添加文字"];
        [_textView setTextColor:COLOR_TITLE];
    }
    return _textView;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = COLOR_BACKGROUND;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.bgView];
        [self.contentView addSubview:self.greenAddButton];
        self.contentView.backgroundColor = COLOR_BACKGROUND;
        [self.bgView addSubview:self.headImgView];
        [self.bgView addSubview:self.redDeleteButton];
        [self.bgView addSubview:self.topButton];
        [self.bgView addSubview:self.downButton];
        [self.bgView addSubview:self.textView];
    }
    return self;
}


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelImage *)model{
    self.modelImageInfo = model;
    //刷新view
    [self.headImgView sd_setImageWithModel:model placeholderImageName:@"添加照片"];
    self.textView.text = UnPackStr(model.desc);

    [self resetCellLayout];
}


- (void)resetCellLayout{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.greenAddButton.leftTop = XY(W(15),W(0));
    self.bgView.widthHeight = XY(SCREEN_WIDTH - W(15) * 2, W(100));
    self.bgView.leftTop = XY(W(15),self.greenAddButton.bottom+W(0));
    self.redDeleteButton.widthHeight = XY(W(34), W(34));
    self.redDeleteButton.leftTop = XY(W(0),W(0));
    
       self.headImgView.leftTop = XY(self.redDeleteButton.right,W(15));
    
    self.textView.leftTop = XY(self.headImgView.right + W(10),self.headImgView.y);
    self.textView.widthHeight = XY(self.bgView.width - self.headImgView.right - W(40),self.headImgView.height);
    
    self.topButton.widthHeight = XY(W(40), W(40));
    self.topButton.rightTop = XY(self.bgView.width, 0);
    
    self.downButton.widthHeight = XY(W(40), W(40));
    self.downButton.rightBottom = XY(self.bgView.width,self.bgView.height);
    
    self.height = self.bgView.bottom;
}
#pragma mark 点击事件
/**
 *  tag值
 *  1   添加
 *  5   删除
 *  10  向上      11 向下
 */
- (void)btnClick:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(protocolUpImageWithTextButton:cell:)]) {
        [self.delegate protocolUpImageWithTextButton:sender.tag cell:self];
    }
}

- (void)tapClick{
    [self showImageVC:1];
}

- (void)imageSelect:(BaseImage *)image{
    //case 4:
    [[AliClient sharedInstance] updateImageAry:@[image]  
 storageSuccess:nil upSuccess:nil fail:nil];
    self.headImgView.image = image;
    self.modelImageInfo.url = image.imageURL;
    self.modelImageInfo.image = image;
    self.modelImageInfo.width = image.size.width;
    self.modelImageInfo.height = image.size.height;

}


#pragma mark text view delegate
- (void)textViewDidChange:(UITextView *)textView{
    self.modelImageInfo.desc = textView.text;
    
//    // 判断是否有候选字符，如果不为nil，代表有候选字符
//    if(textView.markedTextRange == nil){
//        //保存光标的位置
//        NSRange rangeSelect = textView.selectedRange;
//        if (rangeSelect.location == NSNotFound) {
//            rangeSelect.location = textView.text.length;
//        }
//        textView.attributedText = [[NSAttributedString alloc]initWithString:UnPackStr(textView.text) attributes:self.attributes];
//        textView.selectedRange = rangeSelect;
//    }else if([textView isKindOfClass:[PlaceHolderTextView class]] ){
//        PlaceHolderTextView * textViewPlace = (PlaceHolderTextView *)textView;
//        textViewPlace.placeHolder.hidden = true;
//    }
}
@end

