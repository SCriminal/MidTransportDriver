//
//  ModelLabel.h
//
//  Created by 京涛 刘 on 2017/6/21
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelLabel : NSObject

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) double font;
@property (nonatomic, strong) NSString *fontAttribute;
@property (nonatomic, assign) double lineSpacing;
@property (nonatomic, assign) NSRange   range;
@end
