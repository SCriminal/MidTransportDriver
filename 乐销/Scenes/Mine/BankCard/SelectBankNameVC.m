//
//  SelectBankNameVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/9/23.
//Copyright © 2020 ping. All rights reserved.
//

#import "SelectBankNameVC.h"
#import "RequestApi+Dictionary.h"

@interface SelectBankNameVC ()
@property (nonatomic, strong) NSMutableArray *aryBanks;
@property (nonatomic, strong) SelectBankNavView *searchView;

@end

@implementation SelectBankNameVC
- (SelectBankNavView *)searchView{
    if (!_searchView) {
        _searchView = [SelectBankNavView new];
        _searchView.top = NAVIGATIONBAR_HEIGHT;
        WEAKSELF
        _searchView.blockSearch = ^(NSString *name) {
            [weakSelf filterBanks:name];
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
    self.tableView.height = SCREEN_HEIGHT - self.searchView.bottom;
    //table
    [self.tableView registerClass:[SelectBankNameCell class] forCellReuseIdentifier:@"SelectBankNameCell"];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"选择银行" rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectBankNameCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectBankNameCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SelectBankNameCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.blockSearch) {
        self.blockSearch(self.aryDatas[indexPath.row]);
    }
    [GB_Nav popViewControllerAnimated:true];
}
#pragma mark request
- (void)requestList{
    [RequestApi requestBankListWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
           NSArray * aryBanks = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelPackageType"];
        self.aryBanks = [aryBanks fetchValues:@"name"];
        [self filterBanks:nil];
        [self.tableView reloadData];
       } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
           
       }];
}
- (void)filterBanks:(NSString *)key{
    [self.aryDatas removeAllObjects];
    if (!isStr(key)) {
        [self.aryDatas addObjectsFromArray:self.aryBanks];
        [self.tableView reloadData];
        return ;
    }
    for (NSString * str in self.aryBanks) {
        if ([str containsString:key]) {
            [self.aryDatas addObject:str];
        }
    }
    [self.tableView reloadData];
}
@end


@implementation SelectBankNavView

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
            iv.image = [UIImage imageNamed:@"shopping_Seach"];
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
        _tfSearch.placeholder = @"请输入商铺名称";
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
    if (self.blockSearch) {
        self.blockSearch(tf.text);
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}
- (void)viewBGClick{
    [self.tfSearch becomeFirstResponder];
}

@end



@implementation SelectBankNameCell
#pragma mark 懒加载
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_666;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _name;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.name];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(NSString *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
        [self.name fitTitle:UnPackStr(model) variable:SCREEN_WIDTH - W(30)];
    self.name.leftTop = XY(W(15),W(15));

    //设置总高度
    self.height = self.name.bottom + W(15);
}

@end

