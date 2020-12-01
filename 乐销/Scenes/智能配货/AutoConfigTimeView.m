//
//  AutoConfigTimeView.m
//  Driver
//
//  Created by 隋林栋 on 2020/11/30.
//Copyright © 2020 ping. All rights reserved.
//

#import "AutoConfigTimeView.h"

@interface AutoConfigTimeView ()

@end

@implementation AutoConfigTimeView
#pragma mark 懒加载
- (UIImageView *)ivBG{
    if (_ivBG == nil) {
        _ivBG = [UIImageView new];
        _ivBG.image = [UIImage imageNamed:@"zzrs_qyzz"];
        _ivBG.widthHeight = XY(W(15),W(15));
    }
    return _ivBG;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = [UIColor whiteColor];
        _labelTitle.textAlignment = NSTextAlignmentCenter;
        _labelTitle.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
    }
    return _labelTitle;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = [UIColor whiteColor];
        _time.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _time;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.widthHeight = XY(W(345), W(39));
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBG];
    [self addSubview:self.labelTitle];
    [self addSubview:self.time];
    
}

#pragma mark 刷新view
- (void)resetView{
    [self removeSubViewWithTag:TAG_LINE];//移除线
       //刷新view
       
       self.ivBG.widthHeight = self.widthHeight;
       [self.labelTitle fitTitle:self.title variable:0];
       self.labelTitle.rightCenterY = XY(self.width - W(30),self.height/2.0);
}
- (void)resetTime:(NSDate *)date{
   int interval = (int)[date timeIntervalSinceNow];
        if(interval>0){
            int sec = interval % 60;
            int min = (interval/60)%60;
            int hou = (interval/3600)%60;
            int day = (interval/(3600*24))%60;
            NSString * strSec = NSNumber.dou(sec).stringValue;
            NSString * strMin = NSNumber.dou(min).stringValue;
            NSString * strHou = NSNumber.dou(hou).stringValue;
            NSString * strDay = NSNumber.dou(day).stringValue;
            NSString * miao = @"秒";
            NSString * fen = @"分";
            NSString * shi = @"时";
            NSString * tian = @"天";

            NSArray * ary0 = @[strDay,tian,strHou,shi,strMin,fen,strSec,miao];
            NSMutableString * muStr = [NSMutableString new];
            for (int i = 0; i<ary0.count; i++) {
                NSString * str = ary0[i];
                [muStr appendString:str];
            }
               NSMutableAttributedString * strAttribute = [[NSMutableAttributedString alloc]initWithString:muStr];
            bool isJ = false;
            for (int i = 0; i<ary0.count; i++) {
                NSString * str = ary0[i];
                if(isJ){
                    [strAttribute setAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],        NSFontAttributeName :  [UIFont systemFontOfSize:F(10) weight:UIFontWeightMedium]} range:[muStr rangeOfString:str]];
                }else{
                    [strAttribute setAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],        NSFontAttributeName : [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium]} range:[muStr rangeOfString:str]];
                }

            }
            self.labelTitle.attributedText = strAttribute;
            self.labelTitle.widthHeight = XY(W(228), [UIFont fetchHeight:F(17)]);
            [self.time fitTitle:[NSString stringWithFormat:@"%d天%d时%d分%d秒",sec,min,hou,day] variable:0];
            self.time.centerXCenterY = XY(W(114),self.height/2.0);
        }
}

@end
