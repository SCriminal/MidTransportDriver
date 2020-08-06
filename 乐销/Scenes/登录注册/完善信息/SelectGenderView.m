//
//  SelectGenderView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/25.
//Copyright © 2020 ping. All rights reserved.
//

#import "SelectGenderView.h"

@interface SelectGenderView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) NSMutableArray *aryDatas0;

@property (strong, nonatomic) UIPickerView *pickView;

@end

@implementation SelectGenderView

#pragma mark lazy init

- (NSMutableArray *)aryDatas0{
    if (!_aryDatas0) {
//        1东 2南 3西 4北 5东南 6西南 7西北  8东北
        _aryDatas0 = @[@"男",@"女"].mutableCopy;
    }
    return _aryDatas0;
}


- (UIPickerView *)pickView{
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 180 , SCREEN_WIDTH,  180)];
        _pickView.delegate   = self;
        _pickView.dataSource = self;
        _pickView.backgroundColor = [UIColor colorWithRed:242/255.0 green:243/255.0 blue:249/255.0 alpha:1];
    }
    return _pickView;
}
#pragma mark  init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self setBaseView];
        [self addTarget:self action:@selector(cancelClick)];
        [GlobalMethod endEditing];
    }
    return self;
}
- (void)setBaseView {
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    UIColor *color = [UIColor colorWithRed:242/255.0 green:243/255.0 blue:249/255.0 alpha:1];
    UIColor *btnColor = [UIColor colorWithRed:65.0/255 green:164.0/255 blue:249.0/255 alpha:1];
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, height - 210, width, 30)];
    selectView.backgroundColor = color;
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取消" forState:0];
    [cancleBtn setTitleColor:btnColor forState:0];
    cancleBtn.titleLabel.fontNum = F(16);
    cancleBtn.frame = CGRectMake(0, 0, 60, 40);
    [cancleBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:cancleBtn];
    
    UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ensureBtn setTitle:@"确定" forState:0];
    [ensureBtn setTitleColor:btnColor forState:0];
    ensureBtn.titleLabel.fontNum = F(16);
    ensureBtn.frame = CGRectMake(width - 60, 0, 60, 40);
    [ensureBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:ensureBtn];
    [self addSubview:selectView];
    
    [self addSubview:self.pickView];
}






#pragma picker view delegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    switch (component) {
        case 0:
        {
            if (row <= self.aryDatas0.count-1) {
                pickerLabel.text = self.aryDatas0[row];
            }
        }
            break;
            
        default:
            break;
    }
    
    return pickerLabel;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return  self.aryDatas0.count;
            break;
      
            
        default:
            break;
    }
    return  0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.frame.size.width;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}



#pragma mark click
- (void)cancelClick{
    [self removeFromSuperview];
}
- (void)confirmClick{
    if (self.blockSelect ) {
        self.blockSelect([self.pickView selectedRowInComponent:0]+1);
    }
    [self removeFromSuperview];
}
@end
