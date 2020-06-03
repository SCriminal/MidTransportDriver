//
//  ModelAttachCompany.h
//
//  Created by 林栋 隋 on 2019/12/10
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAttachCompany : NSObject

@property (nonatomic, strong) NSString *officeProvinceName;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *officeAddrDetail;
@property (nonatomic, strong) NSString *officeCountyName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *officeCityName;
@property (nonatomic, readonly) NSString  *addressShow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
