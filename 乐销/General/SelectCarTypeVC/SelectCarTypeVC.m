//
//  SelectCarTypeVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/6/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "SelectCarTypeVC.h"

@interface SelectCarTypeVC ()
@property (nonatomic, strong) NSMutableArray *aryCarID;
@property (nonatomic, strong) NSMutableArray *aryCarType;
@property (nonatomic, strong) SearchShopNavView *searchView;

@end

@implementation SelectCarTypeVC
- (SearchShopNavView *)searchView{
    if (!_searchView) {
        _searchView = [SearchShopNavView new];
        _searchView.top = NAVIGATIONBAR_HEIGHT;
        WEAKSELF
        _searchView.blockSearch = ^(NSString *str) {
            [weakSelf refreshData];
        };
    }
    return _searchView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.searchView];
    self.tableView.top = self.searchView.bottom;
    self.tableView.height = SCREEN_HEIGHT-self.searchView.bottom;

    //table
    [self.tableView registerClass:SelectCarTypeCell.class forCellReuseIdentifier:@"SelectCarTypeCell"];
    //request
    [self exchangeValue];
    [self refreshData];
}
- (void)exchangeValue{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:@"CarType" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:strPath];
    // 对数据进行JSON格式化并返回字典形式
    NSArray * ary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableArray * aryLabel = [NSMutableArray new];
    NSMutableArray * aryID = [NSMutableArray new];
    for (NSDictionary * dic in ary) {
        int status = [dic doubleValueForKey:@"status"];
        if (status != 0) {
            [aryLabel addObject:[dic stringValueForKey:@"label"]];
            [aryID addObject:[dic numberValueForKey:@"value"]];
        }
    }
    self.aryCarType = aryLabel;
    self.aryCarID = aryID;
}
- (void)refreshData{
    [self.aryDatas removeAllObjects];
    NSString * strSearch = self.searchView.tfSearch.text;
    if (isStr(strSearch)) {
        for (NSString * strType in self.aryCarType) {
            if ([strType containsString:strSearch]) {
                [self.aryDatas addObject:strType];
            }
        }
    }else{
        [self.aryDatas addObjectsFromArray:self.aryCarType];
    }
    
    [self.tableView reloadData];

}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"选择车辆类型" rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectCarTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCarTypeCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SelectCarTypeCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [GlobalMethod endEditing];
    if (self.blockSelected) {
        NSString * strTypeSelected = self.aryDatas[indexPath.row];
        NSUInteger index =[self.aryCarType indexOfObject:strTypeSelected];
        self.blockSelected(strTypeSelected, self.aryCarID[index]);
    }
    [GB_Nav popViewControllerAnimated:true];
}
@end



@implementation SelectCarTypeCell
#pragma mark 懒加载
- (UILabel *)typeName{
    if (_typeName == nil) {
        _typeName = [UILabel new];
        _typeName.textColor = COLOR_333;
        _typeName.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _typeName;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.typeName];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(NSString *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
        [self.typeName fitTitle:model variable:0];
    self.typeName.leftTop = XY(W(15),W(20));

    //设置总高度
    self.height = self.typeName.bottom+self.typeName.top;
    [self.contentView addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];

}

@end


@implementation SearchShopNavView

- (UIButton *)btnSearch{
    if (_btnSearch == nil) {
        
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSearch.tag = 1;
        [_btnSearch addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnSearch.backgroundColor = [UIColor clearColor];
        _btnSearch.widthHeight = XY(W(65),NAVIGATIONBAR_HEIGHT-STATUSBAR_HEIGHT);
        STRUCT_XY wh = _btnSearch.widthHeight;
        [_btnSearch addSubview:^(){
            UIImageView * iv = [UIImageView new];
            iv.image = [UIImage imageNamed:@"attachCarTeam_search"];
            iv.widthHeight = XY(W(25), W(25));
            iv.rightCenterY = XY(wh.horizonX-W(30), wh.verticalY/2.0);
            return iv;
        }()];
    }
    return _btnSearch;
}
- (UITextField *)tfSearch{
    if (_tfSearch == nil) {
        _tfSearch = [UITextField new];
        _tfSearch.font = [UIFont systemFontOfSize:F(13)];
        _tfSearch.textAlignment = NSTextAlignmentLeft;
        _tfSearch.placeholder = @"请输入车辆类型";
        _tfSearch.borderStyle = UITextBorderStyleNone;
        _tfSearch.backgroundColor = [UIColor clearColor];
        _tfSearch.delegate = self;
        [_tfSearch addTarget:self action:@selector(textFileAction:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _tfSearch;
}

- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = ^(){
            UIView *view = [[UIView alloc] init];
            view.widthHeight = XY(SCREEN_WIDTH - W(30), W(37));
            view.layer.borderWidth = 0.5;
            view.layer.borderColor = [UIColor colorWithRed:239/255.0 green:242/255.0 blue:241/255.0 alpha:1.0].CGColor;
            
            view.layer.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0].CGColor;
            view.layer.cornerRadius = 10;
            return view;
        }();
        [_viewBG addTarget:self action:@selector(viewBGClick)];
    }
    return _viewBG;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.height = self.viewBG.height +W(20);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBG];
    [self addSubview:self.btnSearch];
    [self addSubview:self.tfSearch];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view

    self.viewBG.leftCenterY = XY(W(15),self.height/2.0);
    
    self.btnSearch.rightCenterY = XY(SCREEN_WIDTH,self.viewBG.centerY);
    self.tfSearch.widthHeight = XY(self.viewBG.width - W(60), self.tfSearch.font.lineHeight);
    self.tfSearch.leftCenterY = XY( self.viewBG.left + W(15),self.viewBG.centerY);
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    [GlobalMethod endEditing];
    NSString * strKey = self.tfSearch.text;

    
    if (self.blockSearch) {
        self.blockSearch(strKey);
    }
}

#pragma mark click
- (void)btnBackClick{
    [GB_Nav popViewControllerAnimated:true];
}
#pragma mark textfield delegate
- (void)textFileAction:(UITextField *)tf{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}
- (void)viewBGClick{
    [self.tfSearch becomeFirstResponder];
}

@end
