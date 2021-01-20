//
//  ModelAuthBusiness.h
//
//  Created by 林栋 隋 on 2021/1/20
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAuthBusiness : NSObject

@property (nonatomic, strong) NSString *qualificationUrl;
@property (nonatomic, strong) NSString *qualificationNumber;
@property (nonatomic, assign) double qcEndDate;
@property (nonatomic, strong) NSString *roadUrl;
@property (nonatomic, assign) double reviewTime;
@property (nonatomic, assign) double rtpEndDate;
@property (nonatomic, assign) id reviewerName;
@property (nonatomic, assign) id reason;
@property (nonatomic, assign) double reviewerId;
@property (nonatomic, strong) NSString *submitterName;
@property (nonatomic, assign) double submitTime;
@property (nonatomic, assign) double submitterId;
@property (nonatomic, strong) NSString *roadNumber;
@property (nonatomic, assign) double reviewStatus;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
