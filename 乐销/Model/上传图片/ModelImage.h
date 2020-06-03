//
//  ModelImage.h
//
//  Created by   on 2018/3/28
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//base image
#import "BaseImage.h"
//image type
#import "AliClient.h"


@interface ModelImage : NSObject

@property (nonatomic, assign) double width;
@property (nonatomic, assign) double height;


@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *url;
@property (nonatomic,strong) BaseImage * image;
@property (nonatomic, assign) BOOL isEssential;
@property (nonatomic, assign) BOOL isChangeInvalid;
@property (nonatomic, assign) ENUM_UP_IMAGE_TYPE imageType;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
