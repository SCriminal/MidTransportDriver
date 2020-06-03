//
//  ModelBaseInfo.m
//
//  Created by sld s on 2019/5/23
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelBaseInfo.h"


NSString *const kModelBaseInfoBirthday = @"birthday";
NSString *const kModelBaseInfoDriverStartTime = @"driverStartTime";
NSString *const kModelBaseInfoUserStatus = @"userStatus";
NSString *const kModelBaseInfoNickname = @"nickname";
NSString *const kModelBaseInfoContactPhone = @"contactPhone";
NSString *const kModelBaseInfoRealName = @"realName";
NSString *const kModelBaseInfoCountyId = @"countyId";
NSString *const kModelBaseInfoDriverEndTime = @"driverEndTime";
NSString *const kModelBaseInfoHeadUrl = @"headUrl";
NSString *const kModelBaseInfoGender = @"gender";
NSString *const kModelBaseInfoId = @"id";
NSString *const kModelBaseInfoCountyName = @"countyName";
NSString *const kModelBaseInfoIdNumber = @"idNumber";
NSString *const kModelBaseInfoIsDriver = @"isDriver";
NSString *const kModelBaseInfoProvinceName = @"provinceName";
NSString *const kModelBaseInfoCellPhone = @"cellPhone";
NSString *const kModelBaseInfoIsIdentity = @"isIdentity";
NSString *const kModelBaseInfoProvinceId = @"provinceId";
NSString *const kModelBaseInfoCityId = @"cityId";
NSString *const kModelBaseInfoEmail = @"email";
NSString *const kModelBaseInfoWxNumber = @"wxNumber";
NSString *const kModelBaseInfoCityName = @"cityName";
NSString *const kModelBaseInfoAddress = @"address";
NSString *const kModelBaseInfoIntroduce = @"introduce";
NSString *const kModelBaseInfoReviewStatus = @"reviewStatus";


@interface ModelBaseInfo ()
@end

@implementation ModelBaseInfo

@synthesize birthday = _birthday;
@synthesize driverStartTime = _driverStartTime;
@synthesize userStatus = _userStatus;
@synthesize nickname = _nickname;
@synthesize contactPhone = _contactPhone;
@synthesize realName = _realName;
@synthesize countyId = _countyId;
@synthesize driverEndTime = _driverEndTime;
@synthesize headUrl = _headUrl;
@synthesize gender = _gender;
@synthesize iDProperty = _iDProperty;
@synthesize countyName = _countyName;
@synthesize idNumber = _idNumber;
@synthesize isDriver = _isDriver;
@synthesize provinceName = _provinceName;
@synthesize cellPhone = _cellPhone;
@synthesize isIdentity = _isIdentity;
@synthesize provinceId = _provinceId;
@synthesize cityId = _cityId;
@synthesize email = _email;
@synthesize wxNumber = _wxNumber;
@synthesize cityName = _cityName;
@synthesize address = _address;
@synthesize introduce = _introduce;


#pragma mark logical show
- (NSString *)nickname{
    if (isStr(_nickname)) {
        return _nickname;
    }
    return _realName;
}
- (NSString *)authStatusShow{
    if (self.isIdentity == 1 && self.isDriver == 1) {
        switch ((int)self.reviewStatus) {
            case 1:
                return @"未审核";
                break;
            case 2:
                return @"修改已提交";
                break;
            case 3:
                return @"已认证";
                break;
            case 10:
                return @"修改已驳回";
                break;
            default:
                break;
        }
    }
    switch ((int)self.reviewStatus) {
        case 1:
            return @"未审核";
            break;
        case 2:
            return @"审核中";
            break;
        case 3:
            return @"已认证";
            break;
        case 10:
            return @"审核拒绝";
            break;
        default:
            break;
    }
    
    return @"";
}
+ (void)jumpToAuthorityStateVCSuccessBlock:(void (^)(void))successBlock{
    ModelBaseInfo *modelUser = [GlobalData sharedInstance].GB_UserModel;
    BOOL isQuantity  = modelUser.isIdentity == 1&& modelUser.isDriver == 1;
    if (isQuantity && successBlock) {
        successBlock();
        return;
    }
    switch ((int)modelUser.reviewStatus) {
        case 1:
            [GB_Nav pushVCName:@"PerfectAuthorityInfoVC" animated:true];
            break;
        case 2:
            [GB_Nav pushVCName:isQuantity?@"AuthorityReVerifyingVC":@"AuthorityVerifyingVC" animated:true];
            break;
        case 3:
            if (successBlock) {
                successBlock();
            }else{
                [GB_Nav pushVCName:@"PerfectAuthorityInfoSuccessVC" animated:true];
            }
            break;
        case 10:
            [GB_Nav pushVCName:isQuantity?@"AuthorityReFailVC":@"AuthorityFailVC" animated:true];
            break;
        default:
            break;
    }
    
}
#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.birthday = [dict doubleValueForKey:kModelBaseInfoBirthday];
            self.driverStartTime = [dict doubleValueForKey:kModelBaseInfoDriverStartTime];
            self.userStatus = [dict doubleValueForKey:kModelBaseInfoUserStatus];
            self.nickname = [dict stringValueForKey:kModelBaseInfoNickname];
            self.contactPhone = [dict stringValueForKey:kModelBaseInfoContactPhone];
            self.realName = [dict stringValueForKey:kModelBaseInfoRealName];
            self.countyId = [dict doubleValueForKey:kModelBaseInfoCountyId];
            self.driverEndTime = [dict doubleValueForKey:kModelBaseInfoDriverEndTime];
            self.headUrl = [dict stringValueForKey:kModelBaseInfoHeadUrl];
            self.gender = [dict doubleValueForKey:kModelBaseInfoGender];
            self.iDProperty = [dict doubleValueForKey:kModelBaseInfoId];
            self.countyName = [dict stringValueForKey:kModelBaseInfoCountyName];
            self.idNumber = [dict stringValueForKey:kModelBaseInfoIdNumber];
            self.isDriver = [dict doubleValueForKey:kModelBaseInfoIsDriver];
            self.provinceName = [dict stringValueForKey:kModelBaseInfoProvinceName];
            self.cellPhone = [dict stringValueForKey:kModelBaseInfoCellPhone];
            self.isIdentity = [dict doubleValueForKey:kModelBaseInfoIsIdentity];
            self.provinceId = [dict doubleValueForKey:kModelBaseInfoProvinceId];
            self.cityId = [dict doubleValueForKey:kModelBaseInfoCityId];
            self.email = [dict stringValueForKey:kModelBaseInfoEmail];
            self.wxNumber = [dict stringValueForKey:kModelBaseInfoWxNumber];
            self.cityName = [dict stringValueForKey:kModelBaseInfoCityName];
            self.address = [dict stringValueForKey:kModelBaseInfoAddress];
            self.introduce = [dict stringValueForKey:kModelBaseInfoIntroduce];
        self.reviewStatus = [dict doubleValueForKey:kModelBaseInfoReviewStatus];
       

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.birthday] forKey:kModelBaseInfoBirthday];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverStartTime] forKey:kModelBaseInfoDriverStartTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userStatus] forKey:kModelBaseInfoUserStatus];
    [mutableDict setValue:self.nickname forKey:kModelBaseInfoNickname];
    [mutableDict setValue:self.contactPhone forKey:kModelBaseInfoContactPhone];
    [mutableDict setValue:self.realName forKey:kModelBaseInfoRealName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countyId] forKey:kModelBaseInfoCountyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverEndTime] forKey:kModelBaseInfoDriverEndTime];
    [mutableDict setValue:self.headUrl forKey:kModelBaseInfoHeadUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.gender] forKey:kModelBaseInfoGender];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelBaseInfoId];
    [mutableDict setValue:self.countyName forKey:kModelBaseInfoCountyName];
    [mutableDict setValue:self.idNumber forKey:kModelBaseInfoIdNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isDriver] forKey:kModelBaseInfoIsDriver];
    [mutableDict setValue:self.provinceName forKey:kModelBaseInfoProvinceName];
    [mutableDict setValue:self.cellPhone forKey:kModelBaseInfoCellPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isIdentity] forKey:kModelBaseInfoIsIdentity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provinceId] forKey:kModelBaseInfoProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kModelBaseInfoCityId];
    [mutableDict setValue:self.email forKey:kModelBaseInfoEmail];
    [mutableDict setValue:self.wxNumber forKey:kModelBaseInfoWxNumber];
    [mutableDict setValue:self.cityName forKey:kModelBaseInfoCityName];
    [mutableDict setValue:self.address forKey:kModelBaseInfoAddress];
    [mutableDict setValue:self.introduce forKey:kModelBaseInfoIntroduce];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewStatus] forKey:kModelBaseInfoReviewStatus];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
