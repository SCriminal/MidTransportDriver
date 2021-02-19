//
//  AdvertiesementView.m
//中车运
//
//  Created by 隋林栋 on 2018/10/8.
//Copyright © 2018年 ping. All rights reserved.
//

#import "AdvertiesementView.h"

@interface AdvertiesementView ()
//定时器
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) double numTime;
@property (nonatomic, strong) UILabel *labelAlert;
@property (nonatomic, strong) UIControl *controlSkip;
@property (strong, nonatomic) UIImageView *ivAD;

@end

@implementation AdvertiesementView

#pragma mark 倒计时
- (UILabel *)labelAlert{
    if (_labelAlert == nil) {
        _labelAlert = [UILabel new];
        _labelAlert.textColor = [UIColor whiteColor];
        _labelAlert.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _labelAlert.backgroundColor = COLOR_BLACK_ALPHA_PER30;
        _labelAlert.textAlignment = NSTextAlignmentCenter;
        _labelAlert.text = [NSString stringWithFormat:@"%.f  跳过",self.numTime];
        _labelAlert.width = [UILabel fetchWidthFontNum:_labelAlert.font.pointSize text:_labelAlert.text] + W(32);
        _labelAlert.height = _labelAlert.font.lineHeight + W(20);
        [GlobalMethod setRoundView:_labelAlert color:[UIColor clearColor] numRound:_labelAlert.height/2.0 width:0];
        _labelAlert.rightTop = XY(SCREEN_WIDTH - W(13), W(40)+iphoneXBottomInterval);
    }
    return _labelAlert;
}
- (UIControl *)controlSkip{
    if (_controlSkip == nil) {
        _controlSkip = [UIButton buttonWithType:UIButtonTypeCustom];
        [_controlSkip addTarget:self action:@selector(btnSkipClick) forControlEvents:UIControlEventTouchUpInside];
        _controlSkip.backgroundColor = [UIColor clearColor];
        _controlSkip.widthHeight = XY(self.labelAlert.width+W(30),self.labelAlert.height + W(30));
//        _controlSkip.userInteractionEnabled = false;
        _controlSkip.centerXCenterY = self.labelAlert.centerXCenterY;
    }
    return _controlSkip;
}
- (UIImageView *)ivAD{
    if (_ivAD == nil) {
        _ivAD = [UIImageView new];
        _ivAD.image = [self getLaunchImage];
        _ivAD.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
//        _ivAD.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _ivAD;
}
- (UIImage *)getLaunchImage {
    UIImage *launchImg = [[UIImage alloc] init];
    NSString *orientation = @"";
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (statusBarOrientation == UIInterfaceOrientationLandscapeLeft || statusBarOrientation == UIInterfaceOrientationLandscapeRight) {
        orientation = @"Landscape";
    } else {
        orientation = @"Portrait";
    }
    NSArray *imgsInfoArr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"UILaunchImages"];
    for (NSDictionary *info in imgsInfoArr) {
        CGSize imgSize = CGSizeFromString(info[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imgSize, screenSize) && [orientation isEqualToString:info[@"UILaunchImageOrientation"]] ) {
            launchImg = [UIImage imageNamed:info[@"UILaunchImageName"]];
        }
    }
    return launchImg;
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);//默认宽度
        self.numTime = 5;
        [self addSubView];//添加子视图
//        [self playVideo:@""];
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self addSubview:self.ivAD];
    [self addSubview:self.labelAlert];
    [self addSubview:self.controlSkip];
}

#pragma mark 定时器相关
- (void)timerStart{
    //开启定时器
    if (_timer == nil) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
        [self timerRun];
    }
}

- (void)timerRun{
    //每秒的动作
    if (_numTime <=0) {
        //刷新按钮 开始
        [self timerStop];
        self.labelAlert.text = @"跳过";
//        self.controlSkip.userInteractionEnabled = true;
        [self dismiss];
        return;
    }
    _numTime --;
    self.labelAlert.text = [NSString stringWithFormat:@"%.f  跳过",self.numTime];
//    self.controlSkip.userInteractionEnabled = false;
}

- (void)timerStop{
    //停止定时器
    if (_timer != nil) {
        [_timer invalidate];
        self.timer = nil;
    }
}

#pragma mark play video
- (void)playVideo:(NSString *)strUrl{
    NSString* localFilePath=[[NSBundle mainBundle]pathForResource:@"闪屏" ofType:@"m4v"];
    NSURL *localVideoUrl = [NSURL fileURLWithPath:localFilePath];
    //网络视频路径
//    NSString *webVideoPath = @"http://api.junqingguanchashi.net/yunpan/bd/c.php?vid=/junqing/1129.mp4";
//    NSURL *webVideoUrl = [NSURL URLWithString:webVideoPath];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:localVideoUrl];
    self.currentPlayerItem = playerItem;
    self.player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    WEAKSELF
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //当前播放的时间
        NSTimeInterval current = CMTimeGetSeconds(time);
        //视频的总时间
        NSTimeInterval total = CMTimeGetSeconds(weakSelf.player.currentItem.duration);
        if (total <= current) {
            [weakSelf btnSkipClick];
        }
    }];
    

    AVPlayerLayer *avLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    avLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;//AVLayerVideoGravityResizeAspect
//    avLayer.delegate = self;
    avLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.layer insertSublayer:avLayer below:self.labelAlert.layer];
   
    [self.player play];

    
}

#pragma mark click
- (void)btnSkipClick{
    [self timerStop];
    [self dismiss];
}
- (void)dismiss{
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_EXTENDTOKEN object:nil];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
