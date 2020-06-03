//
//  BaseCell.m
//中车运
//
//  Created by 隋林栋 on 2017/3/15.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.numRetract) {
        self.left = self.numRetract;
    }
    if (self.widthRetract) {
        self.width = SCREEN_WIDTH - self.widthRetract;
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = true;
    }
    return self;
}


@end
