
//
//  ModelImage.m
//
//  Created by   on 2018/3/28
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "ModelImage.h"


NSString *const kModelImageNumber = @"number";
NSString *const kModelImageSort = @"sort";
NSString *const kModelImageHeight = @"height";
NSString *const kModelImageTitle = @"title";
NSString *const kModelImageThumbUrl = @"thumbUrl";
NSString *const kModelImageWidth = @"width";
NSString *const kModelImageDesc = @"desc";
NSString *const kModelImageUrl = @"url";


@interface ModelImage ()
@property (nonatomic, assign) double number;
@property (nonatomic, assign) double sort;
@property (nonatomic, strong) NSString *thumbUrl;
@property (nonatomic, strong) NSString *title;
@end

@implementation ModelImage

@synthesize number = _number;
@synthesize sort = _sort;
@synthesize height = _height;
@synthesize title = _title;
@synthesize thumbUrl = _thumbUrl;
@synthesize width = _width;
@synthesize desc = _desc;
@synthesize url = _url;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.number = [dict doubleValueForKey:kModelImageNumber];
        self.sort = [dict doubleValueForKey:kModelImageSort];
        self.height = [dict doubleValueForKey:kModelImageHeight];
        self.title = [dict stringValueForKey:kModelImageTitle];
        self.thumbUrl = [dict stringValueForKey:kModelImageThumbUrl];
        self.width = [dict doubleValueForKey:kModelImageWidth];
        self.desc = [dict stringValueForKey:kModelImageDesc];
        self.url = [dict stringValueForKey:kModelImageUrl];
        //sld_exchange width height
        self.width = !self.width?W(400):self.width;
        self.height = !self.height?W(400):self.height;
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.number] forKey:kModelImageNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kModelImageSort];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kModelImageHeight];
    [mutableDict setValue:self.title forKey:kModelImageTitle];
    [mutableDict setValue:self.thumbUrl forKey:kModelImageThumbUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.width] forKey:kModelImageWidth];
    [mutableDict setValue:self.desc forKey:kModelImageDesc];
    [mutableDict setValue:self.url forKey:kModelImageUrl];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
