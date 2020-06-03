//
//  ModelCompany.m
//
//  Created by 京涛 刘 on 2018/4/5
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "ModelCompany.h"

NSString *const kModelCompanyLegalPhone = @"legalPhone";
NSString *const kModelCompanyAbbr = @"abbr";
NSString *const kModelCompanyCreditCode = @"creditCode";
NSString *const kModelCompanyIntegrity = @"integrity";
NSString *const kModelCompanyLocation = @"location";
NSString *const kModelCompanyNature = @"nature";
NSString *const kModelCompanyAuthentication = @"authentication";
NSString *const kModelCompanyContact = @"contact";
NSString *const kModelCompanyIndustryId = @"industryId";
NSString *const kModelCompanyNumber = @"number";
NSString *const kModelCompanyNatureNumber = @"natureNumber";
NSString *const kModelCompanyEnterpriseTypeId = @"enterpriseTypeId";
NSString *const kModelCompanyEnterpriseNumber = @"enterpriseNumber";
NSString *const kModelCompanyName = @"name";
NSString *const kModelCompanyIntroduction = @"introduction";
NSString *const kModelCompanyInitial = @"initial";
NSString *const kModelCompanyHonorList = @"honorList";
NSString *const kModelCompanyAlbumList = @"albumList";
NSString *const kModelCompanyEmails = @"emails";
NSString *const kModelCompanyAuthenticationStatus = @"authenticationStatus";
NSString *const kModelCompanyRegisterCaptital = @"registerCaptital";
NSString *const kModelCompanyIdentityCode = @"identityCode";
NSString *const kModelCompanyMobile = @"mobile";
NSString *const kModelCompanyFullName = @"fullName";
NSString *const kModelCompanyDesc = @"desc";
NSString *const kModelCompanyLogoUrl = @"logoUrl";
NSString *const kModelCompanyFax = @"fax";
NSString *const kModelCompanyIdentityIdentification = @"identityIdentification";
NSString *const kModelCompanyCompanyStatus = @"companyStatus";
NSString *const kModelCompanyLegal = @"legal";
NSString *const kModelCompanyShortName = @"shortName";
NSString *const kModelCompanyUserNumber = @"userNumber";
NSString *const kModelCompanyParentId = @"parentId";
NSString *const kModelCompanyPhone = @"phone";
NSString *const kModelCompanyScale = @"scale";
//sld_change
NSString *const kModelCompanyAttentionStatus = @"attentionStatus";
NSString *const kModelCompanyInformation = @"information";


@interface ModelCompany ()
@end

@implementation ModelCompany

@synthesize legalPhone = _legalPhone;
@synthesize abbr = _abbr;
@synthesize creditCode = _creditCode;
@synthesize integrity = _integrity;
@synthesize location = _location;
@synthesize nature = _nature;
@synthesize authentication = _authentication;
@synthesize contact = _contact;
@synthesize industryId = _industryId;
@synthesize number = _number;
@synthesize natureNumber = _natureNumber;
@synthesize enterpriseTypeId = _enterpriseTypeId;
@synthesize enterpriseNumber = _enterpriseNumber;
@synthesize name = _name;
@synthesize introduction = _introduction;
@synthesize initial = _initial;
@synthesize honorList = _honorList;
@synthesize albumList = _albumList;
@synthesize emails = _emails;
@synthesize authenticationStatus = _authenticationStatus;
@synthesize registerCaptital = _registerCaptital;
@synthesize identityCode = _identityCode;
@synthesize mobile = _mobile;
@synthesize fullName = _fullName;
@synthesize desc = _desc;
@synthesize logoUrl = _logoUrl;
@synthesize fax = _fax;
@synthesize identityIdentification = _identityIdentification;
@synthesize companyStatus = _companyStatus;
@synthesize legal = _legal;
@synthesize shortName = _shortName;
@synthesize userNumber = _userNumber;
@synthesize parentId = _parentId;
@synthesize phone = _phone;
@synthesize scale = _scale;
//scan
@synthesize attentionStatus = _attentionStatus;

#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.legalPhone = [dict stringValueForKey:kModelCompanyLegalPhone];
            self.abbr = [dict stringValueForKey:kModelCompanyAbbr];
            self.creditCode = [dict stringValueForKey:kModelCompanyCreditCode];
            self.integrity = [dict doubleValueForKey:kModelCompanyIntegrity];
        self.location = [ModelAddress modelObjectWithDictionary:[dict objectForKey:kModelCompanyLocation]];
            self.nature = [dict stringValueForKey:kModelCompanyNature];
//        self.authentication = [ModelAuthentication modelObjectWithDictionary:[dict objectForKey:kModelCompanyAuthentication]];
            self.contact = [dict stringValueForKey:kModelCompanyContact];
            self.industryId = [dict doubleValueForKey:kModelCompanyIndustryId];
            self.number = [dict doubleValueForKey:kModelCompanyNumber];
            self.natureNumber = [dict doubleValueForKey:kModelCompanyNatureNumber];
            self.enterpriseTypeId = [dict doubleValueForKey:kModelCompanyEnterpriseTypeId];
            self.enterpriseNumber = [dict doubleValueForKey:kModelCompanyEnterpriseNumber];
            self.name = [dict stringValueForKey:kModelCompanyName];
//        self.introduction = [ModelIntroduction modelObjectWithDictionary:[dict objectForKey:kModelCompanyIntroduction]];
            self.initial = [dict stringValueForKey:kModelCompanyInitial];
        self.honorList = [GlobalMethod exchangeDic:[dict objectForKey:kModelCompanyHonorList] toAryWithModelName:@"ModelImage"];
        self.albumList = [GlobalMethod exchangeDic:[dict objectForKey:kModelCompanyAlbumList] toAryWithModelName:@"ModelImage"];
            self.emails = [dict stringValueForKey:kModelCompanyEmails];
            self.authenticationStatus = [dict doubleValueForKey:kModelCompanyAuthenticationStatus];
            self.registerCaptital = [dict doubleValueForKey:kModelCompanyRegisterCaptital];
            self.identityCode = [dict stringValueForKey:kModelCompanyIdentityCode];
            self.mobile = [dict stringValueForKey:kModelCompanyMobile];
            self.fullName = [dict stringValueForKey:kModelCompanyFullName];
            self.desc = [dict stringValueForKey:kModelCompanyDesc];
            self.logoUrl = [dict stringValueForKey:kModelCompanyLogoUrl];
            self.fax = [dict stringValueForKey:kModelCompanyFax];
            self.identityIdentification = [dict doubleValueForKey:kModelCompanyIdentityIdentification];
            self.companyStatus = [dict doubleValueForKey:kModelCompanyCompanyStatus];
            self.legal = [dict stringValueForKey:kModelCompanyLegal];
            self.shortName = [dict stringValueForKey:kModelCompanyShortName];
            self.userNumber = [dict doubleValueForKey:kModelCompanyUserNumber];
            self.parentId = [dict doubleValueForKey:kModelCompanyParentId];
            self.phone = [dict stringValueForKey:kModelCompanyPhone];
            self.scale = [dict stringValueForKey:kModelCompanyScale];
        self.information = [dict stringValueForKey:kModelCompanyInformation];

//scan code
        self.attentionStatus = [dict doubleValueForKey:kModelCompanyAttentionStatus];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.legalPhone forKey:kModelCompanyLegalPhone];
    [mutableDict setValue:self.abbr forKey:kModelCompanyAbbr];
    [mutableDict setValue:self.creditCode forKey:kModelCompanyCreditCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.integrity] forKey:kModelCompanyIntegrity];
    [mutableDict setValue:[self.location dictionaryRepresentation] forKey:kModelCompanyLocation];
    [mutableDict setValue:self.nature forKey:kModelCompanyNature];
    [mutableDict setValue:[self.authentication dictionaryRepresentation] forKey:kModelCompanyAuthentication];
    [mutableDict setValue:self.contact forKey:kModelCompanyContact];
    [mutableDict setValue:[NSNumber numberWithDouble:self.industryId] forKey:kModelCompanyIndustryId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.number] forKey:kModelCompanyNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.natureNumber] forKey:kModelCompanyNatureNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.enterpriseTypeId] forKey:kModelCompanyEnterpriseTypeId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.enterpriseNumber] forKey:kModelCompanyEnterpriseNumber];
    [mutableDict setValue:self.name forKey:kModelCompanyName];
    [mutableDict setValue:[self.introduction dictionaryRepresentation] forKey:kModelCompanyIntroduction];
    [mutableDict setValue:self.initial forKey:kModelCompanyInitial];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.honorList] forKey:kModelCompanyHonorList];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.albumList] forKey:kModelCompanyAlbumList];
    [mutableDict setValue:self.emails forKey:kModelCompanyEmails];
    [mutableDict setValue:[NSNumber numberWithDouble:self.authenticationStatus] forKey:kModelCompanyAuthenticationStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.registerCaptital] forKey:kModelCompanyRegisterCaptital];
    [mutableDict setValue:self.identityCode forKey:kModelCompanyIdentityCode];
    [mutableDict setValue:self.mobile forKey:kModelCompanyMobile];
    [mutableDict setValue:self.fullName forKey:kModelCompanyFullName];
    [mutableDict setValue:self.desc forKey:kModelCompanyDesc];
    [mutableDict setValue:self.logoUrl forKey:kModelCompanyLogoUrl];
    [mutableDict setValue:self.fax forKey:kModelCompanyFax];
    [mutableDict setValue:[NSNumber numberWithDouble:self.identityIdentification] forKey:kModelCompanyIdentityIdentification];
    [mutableDict setValue:[NSNumber numberWithDouble:self.companyStatus] forKey:kModelCompanyCompanyStatus];
    [mutableDict setValue:self.legal forKey:kModelCompanyLegal];
    [mutableDict setValue:self.shortName forKey:kModelCompanyShortName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userNumber] forKey:kModelCompanyUserNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.parentId] forKey:kModelCompanyParentId];
    [mutableDict setValue:self.phone forKey:kModelCompanyPhone];
    [mutableDict setValue:self.scale forKey:kModelCompanyScale];
    [mutableDict setValue:self.information forKey:kModelCompanyInformation];

//scan code
    [mutableDict setValue:[NSNumber numberWithDouble:self.attentionStatus] forKey:kModelCompanyAttentionStatus];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
