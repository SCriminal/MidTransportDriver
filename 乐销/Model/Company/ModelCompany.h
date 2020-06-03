//
//  ModelCompany.h
//
//  Created by 京涛 刘 on 2018/4/5
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelCompany : NSObject

@property (nonatomic, strong) NSString *legalPhone;
@property (nonatomic, strong) NSString *abbr;
@property (nonatomic, strong) NSString *creditCode;
@property (nonatomic, assign) double integrity;//完成度
@property (nonatomic, strong) ModelAddress *location;
@property (nonatomic, strong) NSString *nature;
@property (nonatomic, strong) id authentication;
@property (nonatomic, strong) NSString *contact;
@property (nonatomic, assign) double industryId;
@property (nonatomic, assign) double number;
@property (nonatomic, assign) double natureNumber;
@property (nonatomic, assign) double enterpriseTypeId;
@property (nonatomic, assign) double enterpriseNumber;
@property (nonatomic, strong) NSString *name;//公司名称
@property (nonatomic, strong) id introduction;
@property (nonatomic, strong) NSString *initial;
@property (nonatomic, strong) NSArray *honorList;
@property (nonatomic, strong) NSArray *albumList;
@property (nonatomic, strong) NSString *emails;
@property (nonatomic, assign) double authenticationStatus;
@property (nonatomic, assign) double registerCaptital;
@property (nonatomic, strong) NSString *identityCode;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *logoUrl;//头像
@property (nonatomic, strong) NSString *fax;
@property (nonatomic, assign) double identityIdentification;
@property (nonatomic, assign) double companyStatus;
@property (nonatomic, strong) NSString *legal;
@property (nonatomic, strong) NSString *shortName;
@property (nonatomic, assign) double userNumber;
@property (nonatomic, assign) double parentId;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *scale;
@property (nonatomic, strong) NSString *information;
//attention
@property (nonatomic, assign) double attentionStatus;
@property (nonatomic, assign) BOOL isSelect;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
