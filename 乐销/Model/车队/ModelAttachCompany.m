//
//  ModelAttachCompany.m
//
//  Created by 林栋 隋 on 2019/12/10
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelAttachCompany.h"


NSString *const kModelAttachCompanyOfficeProvinceName = @"officeProvinceName";
NSString *const kModelAttachCompanyId = @"id";
NSString *const kModelAttachCompanyOfficeAddrDetail = @"officeAddrDetail";
NSString *const kModelAttachCompanyOfficeCountyName = @"officeCountyName";
NSString *const kModelAttachCompanyName = @"name";
NSString *const kModelAttachCompanyOfficeCityName = @"officeCityName";


@interface ModelAttachCompany ()
@end

@implementation ModelAttachCompany

@synthesize officeProvinceName = _officeProvinceName;
@synthesize iDProperty = _iDProperty;
@synthesize officeAddrDetail = _officeAddrDetail;
@synthesize officeCountyName = _officeCountyName;
@synthesize name = _name;
@synthesize officeCityName = _officeCityName;

- (NSString *)addressShow{
    NSString * strShow = [NSString stringWithFormat:@"%@%@%@%@",UnPackStr(self.officeProvinceName),[self.officeProvinceName isEqualToString:self.officeCityName]?@"":UnPackStr(self.officeCityName),UnPackStr(self.officeCountyName),UnPackStr(self.officeAddrDetail)];
    return strShow;
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
            self.officeProvinceName = [dict stringValueForKey:kModelAttachCompanyOfficeProvinceName];
            self.iDProperty = [dict doubleValueForKey:kModelAttachCompanyId];
            self.officeAddrDetail = [dict stringValueForKey:kModelAttachCompanyOfficeAddrDetail];
            self.officeCountyName = [dict stringValueForKey:kModelAttachCompanyOfficeCountyName];
            self.name = [dict stringValueForKey:kModelAttachCompanyName];
            self.officeCityName = [dict stringValueForKey:kModelAttachCompanyOfficeCityName];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.officeProvinceName forKey:kModelAttachCompanyOfficeProvinceName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelAttachCompanyId];
    [mutableDict setValue:self.officeAddrDetail forKey:kModelAttachCompanyOfficeAddrDetail];
    [mutableDict setValue:self.officeCountyName forKey:kModelAttachCompanyOfficeCountyName];
    [mutableDict setValue:self.name forKey:kModelAttachCompanyName];
    [mutableDict setValue:self.officeCityName forKey:kModelAttachCompanyOfficeCityName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
