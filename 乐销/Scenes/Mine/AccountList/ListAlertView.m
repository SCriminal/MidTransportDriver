//
//  ListAlertView.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/19.
//Copyright © 2019 ping. All rights reserved.
//

#import "ListAlertView.h"

@interface ListAlertView ()<UIGestureRecognizerDelegate>

@end

@implementation ListAlertView

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT) style:UITableViewStyleGrouped];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (UIImageView *)ivBG{
    if (!_ivBG) {
        _ivBG = [UIImageView new];
        _ivBG.image = IMAGE_WHITE_BG;
        _ivBG.backgroundColor = [UIColor clearColor];
    }
    return _ivBG;
}
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //重置视图坐标
    
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        self.height = SCREEN_HEIGHT;
        [self addTarget:self action:@selector(click)];
        [self addSubView];//添加子视图
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBG];
    [self addSubview:self.tableView];
    [self.tableView registerClass:[ListAlertCell class] forCellReuseIdentifier:@"ListAlertCell"];
    //初始化页面
    [self resetViewWithModel:nil];
}

- (void)showWithPoint:(CGPoint)point width:(CGFloat)width ary:(NSArray *)ary{
    [self removeFromSuperview];
    if (!isAry(ary)) {
        return;
    }
    self.aryDatas = ary.mutableCopy;
    self.tableView.leftTop = XY(point.x, point.y+W(10));
    self.tableView.width = width;
    self.tableView.height = MIN([ListAlertCell fetchHeight:nil]*ary.count, MIN(SCREEN_HEIGHT/3.0*2.0, SCREEN_HEIGHT - W(20) - self.tableView.top));
    [self.tableView reloadData];
    
    self.ivBG.frame = CGRectInset(self.tableView.frame, -W(10), -W(10));
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.aryDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListAlertCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ListAlertCell" forIndexPath:indexPath];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    [cell.labelTitle fitTitle:self.aryDatas[indexPath.row] variable:self.tableView.width - W(30)];

    cell.labelTitle.textColor = COLOR_333;
    cell.line.hidden = indexPath.row == self.aryDatas.count -1;
    cell.line.width = self.tableView.width - W(30);
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ListAlertCell fetchHeight:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.blockSelected) {
        self.blockSelected(indexPath.row);
    }
    [self removeFromSuperview];
}
- (void)click{
    [self removeFromSuperview];
}

#pragma mark gesture delegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    if([NSStringFromClass([touch.view class])isEqual:@"UITableViewCellContentView"]){
        return NO;
    }
    return YES;
}
@end



@implementation ListAlertCell
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelTitle.numberOfLines = 1;
        _labelTitle.lineSpace = 0;
    }
    return _labelTitle;
}
- (UIView *)line{
    if (_line == nil) {
        _line = [UIView new];
        _line.backgroundColor = COLOR_LINE;
        _line.height = 1;
        _line.left = W(15);
    }
    return _line;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.line];
//        [self.contentView addTarget:self action:@selector(click)];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(NSString *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelTitle fitTitle:model variable:0];
    self.labelTitle.leftTop = XY(W(15),W(30));
    
    //设置总高度
    self.height = self.labelTitle.bottom + W(30);
    self.line.top = self.height -1;
}

@end
