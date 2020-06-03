//
//  GlobalData.m
//  ChinaDream
//
//  Created by zhangfeng on 12-11-26.
//  Copyright (c) 2012年 eastedge. All rights reserved.
//

#import "GlobalData.h"

UINavigationController *GB_Nav = nil;

@implementation GlobalData
@synthesize GB_UserModel = _GB_UserModel;
@synthesize GB_Key = _GB_Key;
#pragma mark 实现单例
SYNTHESIZE_SINGLETONE_FOR_CLASS(GlobalData);

- (instancetype)init{
    self = [super init];
    if (self) {
        //初始化状态栏
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    return self;
}

//set get userModel
- (void)setGB_UserModel:(ModelBaseInfo *)GB_UserModel{
    [GlobalMethod writeModel:GB_UserModel key:LOCAL_USERMODEL];
    _GB_UserModel = GB_UserModel;
    //保存手机号
    if (GB_UserModel.cellPhone) {
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:UnPackStr(GB_UserModel.cellPhone)  forKey:LOCAL_PHONE];
        [user synchronize];
    }
    if (GB_UserModel) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_SELFMODEL_CHANGE object:nil];
    }
}
- (ModelBaseInfo *)GB_UserModel{
    if (!_GB_UserModel.iDProperty) {
        NSDictionary * dicItem = [GlobalMethod exchangeStringToDic:[GlobalMethod readStrFromUser:LOCAL_USERMODEL]];
        _GB_UserModel = [ModelBaseInfo modelObjectWithDictionary:dicItem];
    }
    return _GB_UserModel;
}
- (NSMutableArray *)aryLocations{
    if (!_aryLocations) {
        _aryLocations = [[NSMutableArray alloc]init];
    }
    return _aryLocations;
}

//set get key
- (void)setGB_Key:(NSString *)GB_Key{
    [GlobalMethod writeStr:GB_Key!=nil?GB_Key:@"" forKey:LOCAL_KEY];
    _GB_Key = GB_Key;
}
- (NSString*)GB_Key{
    if (!isStr(_GB_Key)){
        _GB_Key = [GlobalMethod readStrFromUser:LOCAL_KEY];
    }
    return _GB_Key;
}
#pragma mark lazy init
//set Notice View
- (NoticeView *)GB_NoticeView{
    if (_GB_NoticeView == nil) {
        _GB_NoticeView = [NoticeView new];
    }
    return _GB_NoticeView;
}

+ (void)saveUserModel{
    [GlobalData sharedInstance].GB_UserModel = [GlobalData sharedInstance].GB_UserModel;
}

@end
