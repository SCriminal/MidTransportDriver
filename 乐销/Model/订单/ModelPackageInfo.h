//
//  ModelPackageInfo.h
//
//  Created by sld s on 2019/5/25
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelPackageInfo : NSObject

@property (nonatomic, assign) double state;
@property (nonatomic, assign) double weightId;
@property (nonatomic, assign) double contractId;
@property (nonatomic, assign) double cargoId;
@property (nonatomic, assign) double transportWaybillId;
@property (nonatomic, strong) NSString *contractNumber;
@property (nonatomic, assign) double containerType;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) double truckWaybillId;
@property (nonatomic, assign) double trustWaybillId;
@property (nonatomic, assign) double backMode;
@property (nonatomic, strong) NSString *cargoName;
@property (nonatomic, assign) double waybillCargoId;
@property (nonatomic, strong) NSString *sealNumber;
@property (nonatomic, strong) NSString *containerNumber;
@property (nonatomic, assign) double driverUserId;
@property (nonatomic, strong) NSString *truckNumber;
@property (nonatomic, assign) double stuffTime;
@property (nonatomic, assign) double finishTime;
@property (nonatomic, assign) double acceptTime;

//logical
//@property (nonatomic, strong) NSString *packageNum;
//@property (nonatomic, strong) NSString *plumbumNum;
@property (nonatomic, readonly) NSString *containerTypeShow;
@property (nonatomic, readonly) NSString *weightShow;
@property (nonatomic, readonly) NSString *backTypeShow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
