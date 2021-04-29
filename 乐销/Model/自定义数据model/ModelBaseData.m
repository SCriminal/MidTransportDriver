//
//  ModelBaseData.m
//中车运
//
//  Created by 隋林栋 on 2017/6/9.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "ModelBaseData.h"

@implementation ModelBaseData

NSString *const kModelBaseDataPlaceHolderString = @"placeHolderString";
NSString *const kModelBaseDataIsRequired = @"isRequired";
NSString *const kModelBaseDataString = @"string";
NSString *const kModelBaseDataIsArrowHide = @"isArrowHide";
NSString *const kModelBaseDataIsChangeInvalid = @"isChangeInvalid";
NSString *const kModelBaseDataIdentifier = @"identifier";
NSString *const kModelBaseDataSubString = @"subString";
NSString *const kModelBaseDataHideSubState = @"hideSubState";
NSString *const kModelBaseDataSubLeft = @"subLeft";
NSString *const kModelBaseDataImageName = @"imageName";
NSString *const kModelBaseDataIsSelected = @"isSelected";
NSString *const kModelBaseDataHideState = @"hideState";
NSString *const kModelBaseDataEnumType = @"enumType";

#pragma mark lazy init
- (NSMutableArray *)aryDatas{
    if (!_aryDatas) {
        _aryDatas = [NSMutableArray new];
    }
    return _aryDatas;
}
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.placeHolderString = [dict stringValueForKey:kModelBaseDataPlaceHolderString];
            self.isRequired = [dict boolValueForKey:kModelBaseDataIsRequired];
            self.string = [dict stringValueForKey:kModelBaseDataString];
            self.isArrowHide = [dict boolValueForKey:kModelBaseDataIsArrowHide];
            self.isChangeInvalid = [dict boolValueForKey:kModelBaseDataIsChangeInvalid];
            self.identifier = [dict stringValueForKey:kModelBaseDataIdentifier];
            self.subString = [dict stringValueForKey:kModelBaseDataSubString];
            self.hideSubState = [dict boolValueForKey:kModelBaseDataHideSubState];
            self.subLeft = [dict doubleValueForKey:kModelBaseDataSubLeft];
            self.imageName = [dict stringValueForKey:kModelBaseDataImageName];
            self.isSelected = [dict boolValueForKey:kModelBaseDataIsSelected];
            self.hideState = [dict boolValueForKey:kModelBaseDataHideState];
            self.enumType = [dict doubleValueForKey:kModelBaseDataEnumType];
        self.type = [dict doubleValueForKey:@"type"];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.placeHolderString forKey:kModelBaseDataPlaceHolderString];
    [mutableDict setValue:[NSNumber numberWithBool:self.isRequired] forKey:kModelBaseDataIsRequired];
    [mutableDict setValue:self.string forKey:kModelBaseDataString];
    [mutableDict setValue:[NSNumber numberWithBool:self.isArrowHide] forKey:kModelBaseDataIsArrowHide];
    [mutableDict setValue:[NSNumber numberWithBool:self.isChangeInvalid] forKey:kModelBaseDataIsChangeInvalid];
    [mutableDict setValue:self.identifier forKey:kModelBaseDataIdentifier];
    [mutableDict setValue:self.subString forKey:kModelBaseDataSubString];
    [mutableDict setValue:[NSNumber numberWithBool:self.hideSubState] forKey:kModelBaseDataHideSubState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.subLeft] forKey:kModelBaseDataSubLeft];
    [mutableDict setValue:self.imageName forKey:kModelBaseDataImageName];
    [mutableDict setValue:[NSNumber numberWithBool:self.isSelected] forKey:kModelBaseDataIsSelected];
    [mutableDict setValue:[NSNumber numberWithBool:self.hideState] forKey:kModelBaseDataHideState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.enumType] forKey:kModelBaseDataEnumType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:@"type"];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}



@end
