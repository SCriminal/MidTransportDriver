//
//中车运
//
//  Created by 隋林栋 on 2018/11/7.
//Copyright © 2018 ping. All rights reserved.
//

#import "SelectDistrictView.h"
#import "RequestApi+Dictionary.h"
@interface SelectDistrictView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) NSMutableArray *provinceArray;
@property (strong, nonatomic) NSMutableArray *cityArray;
@property (strong, nonatomic) NSMutableArray *districtArray;
@property (strong, nonatomic) UIPickerView *pickView;

@end

@implementation SelectDistrictView

#pragma mark lazy init

- (NSMutableArray *)provinceArray{
    if (!_provinceArray) {
        _provinceArray = [GlobalMethod readAry:LOCAL_PROVINCE_LIST modelName:@"ModelProvince"];
    }
    return _provinceArray;
}
- (NSMutableArray *)cityArray{
    if (!_cityArray) {
        _cityArray = [NSMutableArray new];
    }
    return _cityArray;
}
- (NSMutableArray *)districtArray{
    if (!_districtArray) {
        _districtArray = [NSMutableArray new];
    }
    return _districtArray;
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
        [self requestProvinceList];
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

#pragma mark request
- (void)requestProvinceList {
    [RequestApi requestProvinceWithDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.provinceArray = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelProvince"];
        [GlobalMethod writeAry:self.provinceArray key:LOCAL_PROVINCE_LIST];
        [self.pickView reloadAllComponents];
        [self requestCityList];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestCityList {
    if (self.provinceArray.count <= [self.pickView selectedRowInComponent:0]) {
        return;
    }
    ModelProvince * modelPro = [self.provinceArray objectAtIndex:[self.pickView selectedRowInComponent:0]];
    [RequestApi requestCityWithId:modelPro.value delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.cityArray = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelProvince"];
        [self.pickView selectRow:0 inComponent:1 animated:true];
        [self.pickView reloadAllComponents];
        [self requestDistrictList];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestDistrictList {
    if (self.cityArray.count <= [self.pickView selectedRowInComponent:1]) {
        return;
    }
    ModelProvince * modelPro = [self.cityArray objectAtIndex:[self.pickView selectedRowInComponent:1]];
    [RequestApi requestAreaWithId:modelPro.value delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.districtArray = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelProvince"];
        [self.pickView selectRow:0 inComponent:2 animated:true];
        [self.pickView reloadAllComponents];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
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
    ModelProvince * pro = component == 0?self.provinceArray[row]:component==1?self.cityArray[row]:self.districtArray[row];
    pickerLabel.text = pro.name;
    return pickerLabel;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return component==0? self.provinceArray.count:component == 1? self.cityArray.count:self.districtArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.frame.size.width/3.0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        [self requestCityList];
    }else if(component == 1){
        [self requestDistrictList];
    }
}


#pragma mark click
- (void)cancelClick{
    [self removeFromSuperview];
}
- (void)confirmClick{
    if (self.blockCitySeleted && isAry(self.provinceArray) && isAry(self.cityArray) && isAry(self.districtArray)) {
        self.blockCitySeleted([self.provinceArray objectAtIndex:[self.pickView selectedRowInComponent:0]],[self.cityArray objectAtIndex:[self.pickView selectedRowInComponent:1]],[self.districtArray objectAtIndex:[self.pickView selectedRowInComponent:2]]);
    }
    [self removeFromSuperview];
}
@end
