//
//  ModelPackageInfo.m
//
//  Created by sld s on 2019/5/25
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelPackageInfo.h"


NSString *const kModelPackageInfoState = @"state";
NSString *const kModelPackageInfoWeightId = @"weightId";
NSString *const kModelPackageInfoContractId = @"contractId";
NSString *const kModelPackageInfoCargoId = @"cargoId";
NSString *const kModelPackageInfoTransportWaybillId = @"transportWaybillId";
NSString *const kModelPackageInfoContractNumber = @"contractNumber";
NSString *const kModelPackageInfoContainerType = @"containerType";
NSString *const kModelPackageInfoPrice = @"price";
NSString *const kModelPackageInfoTruckWaybillId = @"truckWaybillId";
NSString *const kModelPackageInfoTrustWaybillId = @"trustWaybillId";
NSString *const kModelPackageInfoBackMode = @"backMode";
NSString *const kModelPackageInfoCargoName = @"cargoName";
NSString *const kModelPackageInfoWaybillCargoId = @"waybillCargoId";
NSString *const kModelPackageInfoSealNumber = @"sealNumber";
NSString *const kModelPackageInfoContainerNumber = @"containerNumber";
NSString *const kModelPackageInfoDriverUserId = @"driverUserId";
NSString *const kModelPackageInfoTruckNumber = @"truckNumber";
NSString *const kModelPackageInfoStuffTime = @"stuffTime";
NSString *const kModelPackageInfoFinishTime = @"finishTime";
NSString *const kModelPackageInfoAcceptTime = @"acceptTime";


@interface ModelPackageInfo ()
@end

@implementation ModelPackageInfo

@synthesize state = _state;
@synthesize weightId = _weightId;
@synthesize contractId = _contractId;
@synthesize cargoId = _cargoId;
@synthesize transportWaybillId = _transportWaybillId;
@synthesize contractNumber = _contractNumber;
@synthesize containerType = _containerType;
@synthesize price = _price;
@synthesize truckWaybillId = _truckWaybillId;
@synthesize trustWaybillId = _trustWaybillId;
@synthesize backMode = _backMode;
@synthesize cargoName = _cargoName;
@synthesize waybillCargoId = _waybillCargoId;

- (NSString *)weightShow{
    if (self.weightId == 1) {
        return @"10吨以下";
    }
    if (self.weightId == 2) {
        return @"10吨-20吨";
    }
    if (self.weightId == 3) {
        return @"20-25吨";
    }
    if (self.weightId == 4) {
        return @"25-28吨";
    }
    if (self.weightId == 5) {
        return @"28吨以上";
    }
    return @"";
}

- (NSString *)containerTypeShow{
    static NSMutableDictionary * dicTyps = nil;
    if (!dicTyps) {
        NSMutableArray * aryLocal = [GlobalMethod readAry:LOCAL_PACKAGE_TYPE modelName:@"ModelPackageType"];
        if (isAry(aryLocal)) {
            dicTyps = [aryLocal exchangeDicWithKeyPath:@"iDProperty"];
        }
    }
    if (isDic(dicTyps)) {
        ModelPackageType * model = [dicTyps objectForKey:[NSNumber numberWithInt:self.containerType]];
        if (model && [model isKindOfClass:ModelPackageType.class]) {
            return model.name;
        }
    }
    if (self.containerType == 1) {
        return @"20GP";
    }
    if (self.containerType == 2) {
        return @"40GP";
    }
    if (self.containerType == 3) {
        return @"40HC";
    }
    if (self.containerType == 4) {
        return @"20HC";
    }
    if (self.containerType == 5) {
        return @"20RF";
    }
    if (self.containerType == 6) {
        return @"20TK";
    }
    if (self.containerType == 7) {
        return @"20OT";
    }
    if (self.containerType == 8) {
        return @"40RF";
    }
    if (self.containerType == 9) {
        return @"40TK";
    }
    if (self.containerType == 10) {
        return @"40OT";
    }
    if (self.containerType == 11) {
        return @"45GP";
    }
    if (self.containerType == 12) {
        return @"45HC";
    }
    if (self.containerType == 13) {
        return @"45RF";
    }
    if (self.containerType == 14) {
        return @"45TK";
    }
    if (self.containerType == 15) {
        return @"45OT";
    }
    return @"";
}
- (NSString *)backTypeShow{
    if (self.containerType == 1) {
        return @"单背";
    }
    if (self.containerType == 2) {
        return @"双背";
    }
    return @"";
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
            self.state = [dict doubleValueForKey:kModelPackageInfoState];
            self.weightId = [dict doubleValueForKey:kModelPackageInfoWeightId];
            self.contractId = [dict doubleValueForKey:kModelPackageInfoContractId];
            self.cargoId = [dict doubleValueForKey:kModelPackageInfoCargoId];
            self.transportWaybillId = [dict doubleValueForKey:kModelPackageInfoTransportWaybillId];
            self.contractNumber = [dict stringValueForKey:kModelPackageInfoContractNumber];
            self.containerType = [dict doubleValueForKey:kModelPackageInfoContainerType];
            self.price = [dict doubleValueForKey:kModelPackageInfoPrice];
            self.truckWaybillId = [dict doubleValueForKey:kModelPackageInfoTruckWaybillId];
            self.trustWaybillId = [dict doubleValueForKey:kModelPackageInfoTrustWaybillId];
            self.backMode = [dict doubleValueForKey:kModelPackageInfoBackMode];
            self.cargoName = [dict stringValueForKey:kModelPackageInfoCargoName];
            self.waybillCargoId = [dict doubleValueForKey:kModelPackageInfoWaybillCargoId];
        self.sealNumber = [dict stringValueForKey:kModelPackageInfoSealNumber];
        self.containerNumber = [dict stringValueForKey:kModelPackageInfoContainerNumber];
        self.driverUserId = [dict doubleValueForKey:kModelPackageInfoDriverUserId];
        self.truckNumber = [dict stringValueForKey:kModelPackageInfoTruckNumber];
        self.stuffTime = [dict doubleValueForKey:kModelPackageInfoStuffTime];
        self.finishTime = [dict doubleValueForKey:kModelPackageInfoFinishTime];
        self.acceptTime = [dict doubleValueForKey:kModelPackageInfoAcceptTime];


    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.state] forKey:kModelPackageInfoState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.weightId] forKey:kModelPackageInfoWeightId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.contractId] forKey:kModelPackageInfoContractId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cargoId] forKey:kModelPackageInfoCargoId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.transportWaybillId] forKey:kModelPackageInfoTransportWaybillId];
    [mutableDict setValue:self.contractNumber forKey:kModelPackageInfoContractNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.containerType] forKey:kModelPackageInfoContainerType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kModelPackageInfoPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.truckWaybillId] forKey:kModelPackageInfoTruckWaybillId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.trustWaybillId] forKey:kModelPackageInfoTrustWaybillId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.backMode] forKey:kModelPackageInfoBackMode];
    [mutableDict setValue:self.cargoName forKey:kModelPackageInfoCargoName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.waybillCargoId] forKey:kModelPackageInfoWaybillCargoId];
    [mutableDict setValue:self.sealNumber forKey:kModelPackageInfoSealNumber];
    [mutableDict setValue:self.containerNumber forKey:kModelPackageInfoContainerNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverUserId] forKey:kModelPackageInfoDriverUserId];
    [mutableDict setValue:self.truckNumber forKey:kModelPackageInfoTruckNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stuffTime] forKey:kModelPackageInfoStuffTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.finishTime] forKey:kModelPackageInfoFinishTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.acceptTime] forKey:kModelPackageInfoAcceptTime];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
