






//
//  WMZCodeView.m
//  WMZCode
//
//  Created by wmz on 2018/12/14.
//  Copyright © 2018年 wmz. All rights reserved.
//


//间距
#define margin 10

//滑块大小
#define codeSize 50

//贝塞尔曲线偏移
#define offset 9

//背景图片宽度
#define imageHeight 200


//默认还需要添加的点击文本的数量
#define codeAddLabelCount 3

//字体
#define WMZfont 24

#import "WMZCodeView.h"
@interface WMZCodeView()

@property(nonatomic,copy)NSString *name;                      //文本图片 默认图片“A”

@property(nonatomic,copy)callBack block;                      //回调

@property(nonatomic,strong)UILabel *tipLabel;                 //提示文本

@property(nonatomic,strong)UIImageView *mainImage;            //背景图片

@property(nonatomic,strong)UIImageView *moveImage;            //可移动图片

@property(nonatomic,strong)CAShapeLayer *maskLayer;           //遮罩层layer

@property(nonatomic,strong)UIView *maskView;                  //遮罩层

@property(nonatomic,assign)CGPoint randomPoint;               //随机位置


@property(nonatomic,strong)WMZSlider *slider;                 //滑动

@property(nonatomic,strong)UIButton *refresh;                 //刷新按钮

@property(nonatomic,assign)CGFloat width;                     //self的frame的width

@property(nonatomic,assign)CGFloat height;                    //self的frame的height




@end
@implementation WMZCodeView
/*
 * 初始化
 */
+ (instancetype)shareInstance{
    return [[self alloc]init];
}

/*
 * 调用方法
 *
 * @param  CodeType  类型
 * @param  name      背景图
 * @param  rect      frame
 * @param  block     回调
 *
 */
- (WMZCodeView*)addCodeViewWithType:(int)type withImageName:(NSString*)name witgFrame:(CGRect)rect withBlock:(callBack)block{
    self.frame = rect;
    self.name = [name copy];
    self.block = block;
    [self CodeTypeImageView];
    return self;
}



//CodeTypeImage
- (void)CodeTypeImageView{
    [self addSubview:({
        self.tipLabel.text = @"拖动下方滑块完成拼图";
        self.tipLabel.frame = CGRectMake(margin, margin, self.width-margin*2, 30);
        self.tipLabel;
    })];
    
    [self addSubview:({
        self.mainImage.frame = CGRectMake(margin, CGRectGetMaxY(self.tipLabel.frame)+margin, self.width-margin*2, imageHeight);
        self.mainImage.contentMode =  UIViewContentModeScaleAspectFill;
        self.mainImage.clipsToBounds = YES;
        self.mainImage;
    })];
    
    [self addSubview:({
        self.slider.frame = CGRectMake(margin, CGRectGetMaxY(self.mainImage.frame)+margin, W(284), 37);
        [self.slider addTarget:self action:@selector(buttonAction:forEvent:) forControlEvents:UIControlEventAllTouchEvents];
        self.slider;
    })];
    
    [self addSubview:({
        self.refresh.frame = CGRectMake(self.width-margin-50, CGRectGetMaxY(self.slider.frame)+margin, 40, 40);
        [self.refresh setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
        [self.refresh addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
        self.refresh;
    })];
    
    CGRect rect = self.frame;
    rect.size.height = CGRectGetMaxY(self.refresh.frame)+margin;
    self.frame = rect;
    
    [self refreshAction];

}



//添加可移动的图片
- (void)addMoveImage{
    UIImage *normalImage = [UIImage imageNamed:self.name];
    normalImage = [normalImage dw_RescaleImageToSize:CGSizeMake(self.width-margin*2, imageHeight)];
    self.mainImage.image = normalImage;
    
    [self.mainImage addSubview:({
        self.maskView.frame = CGRectMake(self.randomPoint.x, self.randomPoint.y, codeSize, codeSize);
        self.maskView;
    })];
    
    UIBezierPath *path = getCodePath();
    
    UIImage * thumbImage = [self.mainImage.image dw_SubImageWithRect:self.maskView.frame];
    thumbImage = [thumbImage dw_ClipImageWithPath:path];
    [self.mainImage addSubview:({
        self.moveImage.frame = CGRectMake(0, self.randomPoint.y-offset, codeSize+offset, codeSize+offset);
        self.moveImage.image = thumbImage;
        self.moveImage;
    })];
    
    
    [self.maskView.layer addSublayer:({
        self.maskLayer.frame = CGRectMake(0, 0, codeSize, codeSize);
        self.maskLayer.path = path.CGPath;
        self.maskLayer.strokeColor = [UIColor whiteColor].CGColor;
        self.maskLayer;
    })];
   
}



//按钮点击事件
- (void)tapAction:(UIButton*)btn{

}


//图片验证滑块的所有事件
- (void)buttonAction:(UISlider*)slider forEvent:(UIEvent *)event{
    UITouchPhase phase = event.allTouches.anyObject.phase;
    if (phase == UITouchPhaseBegan) {
       
    }
    else if(phase == UITouchPhaseEnded){
     
        
        CGFloat x = self.maskView.frame.origin.x;
        if (fabs(self.moveImage.frame.origin.x-x)<=5.00) {
            [self.layer addAnimation:successAnimal() forKey:@"successAnimal"];
            [self successShow];
        }else{
            [self.layer addAnimation:failAnimal() forKey:@"failAnimal"];
            [self defaultSlider];
        }
    }else if (phase == UITouchPhaseMoved){
        if (slider.value>self.width-margin*2-codeSize) {
            slider.value = self.width-margin*2-codeSize;
            return;
        }
        [self changeSliderWithVlue:slider.value];
        
    }
}

//设置默认的滑动
- (void)defaultSlider{
    self.slider.value = 0.05;
    [self changeSliderWithVlue:self.slider.value];
}

//图片位置随着Slider滑动改变frame
- (void)changeSliderWithVlue:(CGFloat)value{
    CGRect rect = self.moveImage.frame;
    CGFloat x = value * (self.mainImage.frame.size.width)-(value*codeSize);
    rect.origin.x = x;
    self.moveImage.frame = rect;
}



//刷新按钮事件
- (void)refreshAction{
    [self getRandomPoint];
    [self addMoveImage];
    [self defaultSlider];
   
}



//成功动画
static inline CABasicAnimation *successAnimal(){
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 0.2;
    animation.autoreverses = YES;
    animation.fromValue = @1;
    animation.toValue = @0;
    animation.removedOnCompletion = YES;
    return animation;
}

//失败动画
static inline CABasicAnimation *failAnimal(){
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [animation setDuration:0.08];
    animation.fromValue = @(-M_1_PI/16);
    animation.toValue = @(M_1_PI/16);
    animation.repeatCount = 2;
    animation.autoreverses = YES;
    return animation;
}

//成功的操作
- (void)successShow{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __weak WMZCodeView *codeView = self;
        NSString *tip = @"";
      
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"验证成功" message:tip preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (codeView.block) {
                codeView.block(YES);
            }
            [codeView refreshAction];
        }];
        [alert addAction:action];
        [[self getCurrentVC] presentViewController:alert animated:YES completion:nil];
    });
   
}

//获取当前VC
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

/**
 配置滑块贝塞尔曲线
 */
static inline UIBezierPath* getCodePath(){
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(codeSize*0.5-offset,0)];
    [path addQuadCurveToPoint:CGPointMake(codeSize*0.5+offset, 0) controlPoint:CGPointMake(codeSize*0.5, -offset*2)];
    [path addLineToPoint:CGPointMake(codeSize, 0)];
    
    
    [path addLineToPoint:CGPointMake(codeSize,codeSize*0.5-offset)];
    [path addQuadCurveToPoint:CGPointMake(codeSize, codeSize*0.5+offset) controlPoint:CGPointMake(codeSize+offset*2, codeSize*0.5)];
    [path addLineToPoint:CGPointMake(codeSize, codeSize)];
    
    [path addLineToPoint:CGPointMake(codeSize*0.5+offset,codeSize)];
    [path addQuadCurveToPoint:CGPointMake(codeSize*0.5-offset, codeSize) controlPoint:CGPointMake(codeSize*0.5, codeSize-offset*2)];
    [path addLineToPoint:CGPointMake(0, codeSize)];
    
    [path addLineToPoint:CGPointMake(0,codeSize*0.5+offset)];
    [path addQuadCurveToPoint:CGPointMake(0, codeSize*0.5-offset) controlPoint:CGPointMake(0+offset*2, codeSize*0.5)];
    [path addLineToPoint:CGPointMake(0, 0)];
    
    [path stroke];
    return path;
}

//获取随机位置
- (void)getRandomPoint{
    CGFloat widthMax =  self.mainImage.frame.size.width-margin-codeSize;
    CGFloat heightMax = self.mainImage.frame.size.height-codeSize*2;
    
    self.randomPoint = CGPointMake([self getRandomNumber:margin+codeSize*2 to:widthMax], [self getRandomNumber:offset*2 to:heightMax]);
    NSLog(@"%f %f",self.randomPoint.x,self.randomPoint.y);
}

//获取一个随机整数，范围在[from, to]，包括from，包括to
- (int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}


//获取随机数量中文
- (NSString*)getRandomChineseWithCount:(NSInteger)count{
    
     NSMutableString *mString = [[NSMutableString alloc]initWithString:@""];
     NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    for (int i = 0; i<count; i++) {
        NSInteger randomH = 0xA1+arc4random()%(0xFE - 0xA1+1);
        NSInteger randomL = 0xB0+arc4random()%(0xF7 - 0xB0+1);
        NSInteger number = (randomH<<8)+randomL;
        NSData *data = [NSData dataWithBytes:&number length:2];
        NSString *string = [[NSString alloc] initWithData:data encoding:gbkEncoding];
        if (string) {
            [mString appendString:string];
        }
    }
    return [NSString stringWithFormat:@"%@",mString];
}

- (NSString *)name{
    if (!_name) {
        _name = @"A";
    }
    return _name;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont systemFontOfSize:WMZfont];
    }
    return _tipLabel;
}

- (UIImageView *)mainImage{
    if (!_mainImage) {
        _mainImage = [UIImageView new];
    }
    return _mainImage;
}

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.alpha = 0.5;
    }
    return _maskView;
}

- (UIImageView *)moveImage{
    if (!_moveImage) {
        _moveImage = [UIImageView new];
    }
    return _moveImage;
}

- (WMZSlider *)slider{
    if (!_slider) {
        _slider = [WMZSlider new];
        _slider.thumbTintColor = [UIColor greenColor];
        UIImage *leftTrack = [[UIImage imageNamed:@"SliderTrackLeft"]
        resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
         
        [_slider setMinimumTrackImage:leftTrack forState:UIControlStateNormal];
            
        UIImage *rightTrack = [[UIImage imageNamed:@"SliderTrackRight"]
        resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
         
        [_slider setMaximumTrackImage:rightTrack forState:UIControlStateNormal];
        [_slider setThumbImage:[UIImage imageNamed:@"slider_default"] forState:UIControlStateNormal];
        [_slider setThumbImage:[UIImage imageNamed:@"slider_default"] forState:UIControlStateHighlighted];

    }
    return _slider;
}


-(UIButton *)refresh{
    if (!_refresh) {
        _refresh = [UIButton buttonWithType:UIButtonTypeCustom];
        [_refresh setAdjustsImageWhenHighlighted:NO];
    }
    return _refresh;
}

- (CGFloat)width{
    if (!_width) {
        _width = self.frame.size.width;
    }
    return _width;
}


- (CGFloat)height{
    if (!_height) {
        _height = self.frame.size.height;
    }
    return _height;
}


- (CAShapeLayer *)maskLayer{
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
    }
    return _maskLayer;
}



@end

@implementation WMZSlider
//改变滑动条高度



- (UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.center = self.center;
        _label.text = @"按住滑块拖动到最右边";
        _label.font = [UIFont systemFontOfSize:WMZfont];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1];
        _label.layer.masksToBounds = YES;
        _label.layer.borderWidth = 1;
        _label.layer.borderColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1].CGColor;
    }
    return _label;
}


@end


@implementation UIImage (Expand)

///截取当前image对象rect区域内的图像
-(UIImage *)dw_SubImageWithRect:(CGRect)rect{
    CGFloat scale = self.scale;
    
    CGRect scaleRect = CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale);
    CGImageRef newImageRef = CGImageCreateWithImageInRect(self.CGImage, scaleRect);
    UIImage *newImage = [[UIImage imageWithCGImage:newImageRef] dw_RescaleImageToSize:rect.size];
    CGImageRelease(newImageRef);
    return newImage;
}

///压缩图片至指定尺寸
-(UIImage *)dw_RescaleImageToSize:(CGSize)size{
    CGRect rect = (CGRect){CGPointZero, size};
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [self drawInRect:rect];
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resImage;
}

///按给定path剪裁图片
/**
 path:路径，剪裁区域。
 mode:填充模式
 */
-(UIImage *)dw_ClipImageWithPath:(UIBezierPath *)path {
    CGFloat originScale = self.size.width * 1.0 / self.size.height;
    CGRect boxBounds = path.bounds;
    CGFloat width = boxBounds.size.width;
    CGFloat height = width / originScale;
    if (height > boxBounds.size.height) {
        height = boxBounds.size.height;
        width = height * originScale;
    }
    
    ///开启上下文
    UIGraphicsBeginImageContextWithOptions(boxBounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    ///归零path
    UIBezierPath * newPath = [path copy];
    [newPath applyTransform:CGAffineTransformMakeTranslation(-path.bounds.origin.x, -path.bounds.origin.y)];
    [newPath addClip];
    
    ///移动原点至图片中心
    CGContextTranslateCTM(bitmap, boxBounds.size.width / 2.0, boxBounds.size.height / 2.0);
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-width / 2, -height / 2, width, height), self.CGImage);
    
    ///生成图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//裁剪图片
- (UIImage*)imageScaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);//size为CGSize类型，即你所需要的图片尺寸
    [self drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
