//
//  ShareView.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/23.
//Copyright © 2019 ping. All rights reserved.
//

#import "ShareView.h"
//微信
#import "WXApi.h"
@interface ShareView ()
@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UIButton *btnCancel;

@end

@implementation ShareView
#pragma mark 懒加载
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
        _viewBG.widthHeight = XY(W(355), W(165));
        [GlobalMethod setRoundView:_viewBG color:[UIColor clearColor] numRound:5 width:0];
    }
    return _viewBG;
}
-(UIButton *)btnCancel{
    if (_btnCancel == nil) {
        _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCancel.tag = 1;
        [_btnCancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        _btnCancel.backgroundColor = [UIColor whiteColor];
        _btnCancel.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnCancel setTitleColor:COLOR_333 forState:UIControlStateNormal];
        [GlobalMethod setRoundView:_btnCancel color:[UIColor clearColor] numRound:5 width:0];
        [_btnCancel setTitle:@"取消" forState:(UIControlStateNormal)];
        _btnCancel.widthHeight = XY(W(355),W(45));
    }
    return _btnCancel;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BLACK_ALPHA_PER60;
        self.width = SCREEN_WIDTH;
        self.height = SCREEN_HEIGHT;
        [self addSubView];
        [self addTarget:self action:@selector(cancelClick)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBG];
    [self addSubview:self.btnCancel];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    [self.viewBG removeAllSubViews];
    {
        UILabel * label = [UILabel new];
        label.fontNum = F(13);
        label.textColor = COLOR_333;
        [label fitTitle:@"分享至" variable:0];
        label.centerXTop = XY(self.viewBG.width/2.0, W(15));
        [self.viewBG addSubview:label];
        [self.viewBG addLineFrame:CGRectMake(0, W(42), self.viewBG.width, 1)];
    }
    {
        UIImageView * iv = [UIImageView new];
        iv.image = [UIImage imageNamed:@"share_wechat"];
        iv.widthHeight = XY(W(51), W(51));
        iv.leftTop = XY(W(69), W(68));
        [self.viewBG addSubview:iv];
        
        UILabel * label = [UILabel new];
        label.fontNum = F(12);
        label.textColor = COLOR_666;
        [label fitTitle:@"微信好友" variable:0];
        label.centerXTop = XY(iv.centerX,iv.bottom + W(10));

        [self.viewBG addSubview:label];
        [self.viewBG addControlFrame:CGRectInset(iv.frame, -W(30), -W(30)) belowView:iv target:self action:@selector(friendClick)];
    }
    {
        UIImageView * iv = [UIImageView new];
        iv.image = [UIImage imageNamed:@"share_circle"];
        iv.widthHeight = XY(W(51), W(51));
        iv.rightTop = XY(self.viewBG.width - W(69), W(68));
        [self.viewBG addSubview:iv];
        
        UILabel * label = [UILabel new];
        label.fontNum = F(12);
        label.textColor = COLOR_666;
        [label fitTitle:@"朋友圈" variable:0];
        [self.viewBG addSubview:label];
        label.centerXTop = XY(iv.centerX,iv.bottom + W(10));

        [self.viewBG addControlFrame:CGRectInset(iv.frame, -W(30), -W(30)) belowView:iv target:self action:@selector(circleClick)];
    }
    //刷新view
    self.btnCancel.centerXBottom = XY(SCREEN_WIDTH/2.0,SCREEN_HEIGHT - iphoneXBottomInterval - W(10));

    self.viewBG.centerXBottom = XY(SCREEN_WIDTH/2.0,self.btnCancel.top - W(10));
}
#pragma mark 点击事件
- (void)cancelClick{
    [self removeFromSuperview];
}
- (void)circleClick{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        //message是多媒体分享(链接/网页/图片/音乐各种)
        //text是分享文本,两者只能选其一
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        WXMediaMessage *message = [WXMediaMessage message];
        [self configMediamsg:message];
        req.message = message;
        WXWebpageObject *ext = [WXWebpageObject object];
        if (self.modelOrder.orderNumber) {
            ext.webpageUrl = [NSString stringWithFormat:@"%@/h5/waybill/detail/%@",URL_SHARE,self.modelOrder.orderNumber];
        }
        message.mediaObject = ext;
        //默认是Session分享给朋友,Timeline是朋友圈,Favorite是收藏
        req.scene = WXSceneTimeline;
        [WXApi sendReq:req completion:^(BOOL success) {
            
        }];

    } else {
        [GlobalMethod showAlert:@"你还没有安装微信"];
    }
    [self removeFromSuperview];

}
- (void)friendClick{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        //message是多媒体分享(链接/网页/图片/音乐各种)
        //text是分享文本,两者只能选其一
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        WXMediaMessage *message = [WXMediaMessage message];
        [self configMediamsg:message];
        req.message = message;
        WXWebpageObject *ext = [WXWebpageObject object];
        if (self.modelOrder.orderNumber.length) {
            ext.webpageUrl = [NSString stringWithFormat:@"%@/h5/waybill/detail/%@",URL_SHARE,self.modelOrder.orderNumber];
        }
        message.mediaObject = ext;
        //默认是Session分享给朋友,Timeline是朋友圈,Favorite是收藏
        req.scene = WXSceneSession;
        [WXApi sendReq:req completion:^(BOOL success) {
            
        }];

    } else {
        [GlobalMethod showAlert:@"你还没有安装微信"];
    }
    [self removeFromSuperview];

}

- (void) configMediamsg:(WXMediaMessage *)message{
    if (self.modelOrder.orderNumber.length) {
        //集运
        message.title = [NSString stringWithFormat:@"运单单号：%@",self.modelOrder.orderNumber];
        NSMutableString *strDes = [NSMutableString new];
//        [strDes appendString:[NSString stringWithFormat:@"背箱方式：%@\n",self.modelOrder.total == 2?@"双背":@"单背"]];

        [strDes appendString:[NSString stringWithFormat:@"发货地：%@\n",[NSString stringWithFormat:@"%@%@%@%@",self.modelOrder.startProvinceName,[self.modelOrder.startCityName isEqualToString:self.modelOrder.startProvinceName]?UnPackStr(self.modelOrder.startCityName):@"",self.modelOrder.startCountyName,self.modelOrder.startAddr]]];
        [strDes appendString:[NSString stringWithFormat:@"收货地：%@\n",[NSString stringWithFormat:@"%@%@%@%@",self.modelOrder.endProvinceName,[self.modelOrder.endCityName isEqualToString:self.modelOrder.endProvinceName]?UnPackStr(self.modelOrder.endCityName):@"",self.modelOrder.endCountyName,self.modelOrder.endAddr]]];
        message.description = strDes;
    }
    [message setThumbImage:[UIImage imageNamed:@"shareIcon"]];
}
+ (void)show:(ModelTransportOrder *)modelOrder{
    ShareView * share = [ShareView new];
    share.alpha = 0;
    share.modelOrder = modelOrder;
    [GB_Nav.lastVC.view addSubview:share];
    [UIView animateWithDuration:0.2 animations:^{
        share.alpha = 1;
    }];
}


@end
