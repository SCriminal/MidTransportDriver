//
//  ModelScheduleInfo.m
//
//  Created by 林栋 隋 on 2019/11/26
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelScheduleInfo.h"


NSString *const kModelScheduleInfoEndCityName = @"endCityName";
NSString *const kModelScheduleInfoStartAddr = @"startAddr";
NSString *const kModelScheduleInfoStartCityName = @"startCityName";
NSString *const kModelScheduleInfoStartContact = @"startContact";
NSString *const kModelScheduleInfoEndPhone = @"endPhone";
NSString *const kModelScheduleInfoEndCountyName = @"endCountyName";
NSString *const kModelScheduleInfoEndContact = @"endContact";
NSString *const kModelScheduleInfoEndEntName = @"endEntName";
NSString *const kModelScheduleInfoCargoName = @"cargoName";
NSString *const kModelScheduleInfoEntName = @"entName";
NSString *const kModelScheduleInfoEndAddr = @"endAddr";
NSString *const kModelScheduleInfoCloseTime = @"closeTime";
NSString *const kModelScheduleInfoEndProvinceName = @"endProvinceName";
NSString *const kModelScheduleInfoStartCountyName = @"startCountyName";
NSString *const kModelScheduleInfoStartTownName = @"startTownName";
NSString *const kModelScheduleInfoNumber = @"number";
NSString *const kModelScheduleInfoStartProvinceName = @"startProvinceName";
NSString *const kModelScheduleInfoWaybillVolume = @"waybillVolume";
NSString *const kModelScheduleInfoUnit = @"unit";
NSString *const kModelScheduleInfoStartPhone = @"startPhone";
NSString *const kModelScheduleInfoEndTownName = @"endTownName";
NSString *const kModelScheduleInfoDescription = @"description";
NSString *const kModelScheduleInfoReserveVolume = @"reserveVolume";
NSString *const kModelScheduleInfoIsOpen = @"isOpen";

@interface ModelScheduleInfo ()
@end

@implementation ModelScheduleInfo

@synthesize endCityName = _endCityName;
@synthesize startAddr = _startAddr;
@synthesize startCityName = _startCityName;
@synthesize startContact = _startContact;
@synthesize endPhone = _endPhone;
@synthesize endCountyName = _endCountyName;
@synthesize endContact = _endContact;
@synthesize endEntName = _endEntName;
@synthesize cargoName = _cargoName;
@synthesize entName = _entName;
@synthesize endAddr = _endAddr;
@synthesize closeTime = _closeTime;
@synthesize endProvinceName = _endProvinceName;
@synthesize startCountyName = _startCountyName;
@synthesize startTownName = _startTownName;
@synthesize number = _number;
@synthesize startProvinceName = _startProvinceName;
@synthesize waybillVolume = _waybillVolume;
@synthesize unit = _unit;
@synthesize startPhone = _startPhone;
@synthesize endTownName = _endTownName;

#pragma mark logical
- (NSString *)addressFromShow{
    return [NSString stringWithFormat:@"%@%@",UnPackStr(self.startProvinceName),[self.startProvinceName isEqualToString:self.startCityName]?@"":UnPackStr(self.startCityName)];
}
- (NSString *)addressToShow{
    return [NSString stringWithFormat:@"%@%@",UnPackStr(self.endProvinceName),[self.endProvinceName isEqualToString:self.endCityName]?@"":UnPackStr(self.endCityName)];
}
- (NSString *)addressFromDetailShow{
    return [NSString stringWithFormat:@"%@%@%@%@",UnPackStr(self.startProvinceName),[self.startProvinceName isEqualToString:self.startCityName]?@"":UnPackStr(self.startCityName),UnPackStr(self.startCountyName),UnPackStr(self.startAddr)];
}
- (NSString *)addressToDetailShow{
    return [NSString stringWithFormat:@"%@%@%@%@",UnPackStr(self.endProvinceName),[self.endProvinceName isEqualToString:self.endCityName]?@"":UnPackStr(self.endCityName),UnPackStr(self.endCountyName),UnPackStr(self.endAddr)];
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
            self.endCityName = [dict stringValueForKey:kModelScheduleInfoEndCityName];
            self.startAddr = [dict stringValueForKey:kModelScheduleInfoStartAddr];
            self.startCityName = [dict stringValueForKey:kModelScheduleInfoStartCityName];
            self.startContact = [dict stringValueForKey:kModelScheduleInfoStartContact];
            self.endPhone = [dict stringValueForKey:kModelScheduleInfoEndPhone];
            self.endCountyName = [dict stringValueForKey:kModelScheduleInfoEndCountyName];
            self.endContact = [dict stringValueForKey:kModelScheduleInfoEndContact];
            self.endEntName = [dict stringValueForKey:kModelScheduleInfoEndEntName];
            self.cargoName = [dict stringValueForKey:kModelScheduleInfoCargoName];
            self.entName = [dict stringValueForKey:kModelScheduleInfoEntName];
            self.endAddr = [dict stringValueForKey:kModelScheduleInfoEndAddr];
            self.closeTime = [dict doubleValueForKey:kModelScheduleInfoCloseTime];
            self.endProvinceName = [dict stringValueForKey:kModelScheduleInfoEndProvinceName];
            self.startCountyName = [dict stringValueForKey:kModelScheduleInfoStartCountyName];
            self.startTownName = [dict stringValueForKey:kModelScheduleInfoStartTownName];
            self.number = [dict stringValueForKey:kModelScheduleInfoNumber];
            self.startProvinceName = [dict stringValueForKey:kModelScheduleInfoStartProvinceName];
            self.waybillVolume = [dict doubleValueForKey:kModelScheduleInfoWaybillVolume];
            self.unit = [dict stringValueForKey:kModelScheduleInfoUnit];
            self.startPhone = [dict stringValueForKey:kModelScheduleInfoStartPhone];
            self.endTownName = [dict stringValueForKey:kModelScheduleInfoEndTownName];
        self.iDPropertyDescription = [dict stringValueForKey:kModelScheduleInfoDescription];
        self.reserveVolume = [dict doubleValueForKey:kModelScheduleInfoReserveVolume];
        self.isOpen = [dict doubleValueForKey:kModelScheduleInfoIsOpen];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.endCityName forKey:kModelScheduleInfoEndCityName];
    [mutableDict setValue:self.startAddr forKey:kModelScheduleInfoStartAddr];
    [mutableDict setValue:self.startCityName forKey:kModelScheduleInfoStartCityName];
    [mutableDict setValue:self.startContact forKey:kModelScheduleInfoStartContact];
    [mutableDict setValue:self.endPhone forKey:kModelScheduleInfoEndPhone];
    [mutableDict setValue:self.endCountyName forKey:kModelScheduleInfoEndCountyName];
    [mutableDict setValue:self.endContact forKey:kModelScheduleInfoEndContact];
    [mutableDict setValue:self.endEntName forKey:kModelScheduleInfoEndEntName];
    [mutableDict setValue:self.cargoName forKey:kModelScheduleInfoCargoName];
    [mutableDict setValue:self.entName forKey:kModelScheduleInfoEntName];
    [mutableDict setValue:self.endAddr forKey:kModelScheduleInfoEndAddr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.closeTime] forKey:kModelScheduleInfoCloseTime];
    [mutableDict setValue:self.endProvinceName forKey:kModelScheduleInfoEndProvinceName];
    [mutableDict setValue:self.startCountyName forKey:kModelScheduleInfoStartCountyName];
    [mutableDict setValue:self.startTownName forKey:kModelScheduleInfoStartTownName];
    [mutableDict setValue:self.number forKey:kModelScheduleInfoNumber];
    [mutableDict setValue:self.startProvinceName forKey:kModelScheduleInfoStartProvinceName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.waybillVolume] forKey:kModelScheduleInfoWaybillVolume];
    [mutableDict setValue:self.unit forKey:kModelScheduleInfoUnit];
    [mutableDict setValue:self.startPhone forKey:kModelScheduleInfoStartPhone];
    [mutableDict setValue:self.endTownName forKey:kModelScheduleInfoEndTownName];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelScheduleInfoDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reserveVolume] forKey:kModelScheduleInfoReserveVolume];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isOpen] forKey:kModelScheduleInfoIsOpen];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
