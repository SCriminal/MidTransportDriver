//
//  AuthortiyExampleVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/8/23.
//Copyright © 2019 ping. All rights reserved.
//

#import "AuthortiyExampleVC.h"

@interface AuthortiyExampleVC()

@end

@implementation AuthortiyExampleVC

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[AuthortiyExampleCell class] forCellReuseIdentifier:@"AuthortiyExampleCell"];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"认证资料示例" rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AuthortiyExampleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AuthortiyExampleCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    cell.line.hidden = (self.aryDatas.count-1) == indexPath.row;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AuthortiyExampleCell fetchHeight:self.aryDatas[indexPath.row]];
}


#pragma mark request
- (void)requestList{
    
}
@end



@implementation AuthortiyExampleCell
#pragma mark 懒加载
- (UIImageView *)ivImage{
    if (_ivImage == nil) {
        _ivImage = [UIImageView new];
        _ivImage.image = [UIImage imageNamed:@"zzrs_qyzz"];
        _ivImage.widthHeight = XY(W(201),W(129));
    }
    return _ivImage;
}
- (UILabel *)labelExplain{
    if (_labelExplain == nil) {
        _labelExplain = [UILabel new];
        _labelExplain.textColor = COLOR_666;
        _labelExplain.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        _labelExplain.numberOfLines = 0;
        _labelExplain.lineSpace = 0;
    }
    return _labelExplain;
}
- (UIView *)line{
    if (!_line) {
        _line = [UIView new];
        _line.widthHeight = XY(W(305), 1);
        _line.backgroundColor = COLOR_LINE;
    }
    return _line;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.ivImage];
        [self.contentView addSubview:self.labelExplain];
        [self.contentView addSubview:self.line];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelExplain fitTitle:UnPackStr(model.string) variable:0];
    self.labelExplain.centerXTop = XY(SCREEN_WIDTH/2.0,W(20));

    self.ivImage.image = [UIImage imageNamed:model.imageName];
    self.ivImage.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelExplain.bottom+W(14));
    
    //设置总高度
    self.height = self.ivImage.bottom + W(20);
    self.line.centerXBottom = XY(SCREEN_WIDTH/2.0, self.height -1);
}

@end
