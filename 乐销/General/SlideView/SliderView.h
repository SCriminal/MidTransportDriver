//
//  SliderView.h
//中车运
//
//  Created by 隋林栋 on 2016/12/19.
//  Copyright © 2016年 ping. All rights reserved.
//


#import <UIKit/UIKit.h>

@class CustomSliderControl;

@protocol SliderViewDelegate <NSObject>

@optional

- (void)protocolSliderViewBtnSelect:(NSUInteger)tag btn:(CustomSliderControl *)control;

@end

@interface SliderView : UIView

//代理
@property (nonatomic, weak) id<SliderViewDelegate> delegate;

@property (nonatomic, strong) UIView * viewSlid;        //滑动条
@property (nonatomic, assign) CGFloat viewSlidWidth;    //滑动条宽度
@property (nonatomic, assign) CGFloat viewSlidHeight;   //滑动条高度
@property (nonatomic, strong) UIColor *viewSlidColor;   //滑动条颜色
@property (strong, nonatomic) UIScrollView *scrollView; //sc
@property (nonatomic, strong) UIView * line;        //底部线条
@property (nonatomic, assign) BOOL isScroll;            //是否可滑动
@property (nonatomic, assign) BOOL isHasSlider;         //是否有滑动条
@property (nonatomic, assign) BOOL isImageLeft;         //是否图片居左
@property (nonatomic, assign) BOOL isLineVerticalHide;  //是否有竖线
@property (nonatomic, strong) NSArray *aryModels;//数据源
@property (nonatomic, assign) NSInteger selectSliderIndex;//当前选中

//刷新页面
- (void)resetWithAry:(NSArray *)aryModel;

//滑动到指定
- (void)sliderToIndex:(int)index noticeDelegate:(BOOL)notice;
- (void)sliderToIndex:(int)index noticeDelegate:(BOOL)notice animate:(BOOL)animate;

//刷新指定title
- (void)refreshBtn:(int)indext  title:(NSString *)strTitle;

@end


@interface CustomSliderControl:UIControl//自定义 滑动按钮
@property (nonatomic, strong) UILabel * labelTitle;
@property (nonatomic, strong) UIImageView * iv;
@property (nonatomic, strong) UIColor * textColorSelect;
@property (nonatomic, strong) UIColor * textColor;

//@property  BOOL isSelect_Custom;

//这里放方法
- (void)resetControlFrame:(CGRect )rect
                      tag:(int )tag
                    title:(NSString *)title
                imageName:(NSString *)imageName
            highImageName:(NSString *)highImageName
              isImageLeft:(BOOL)isImageLeft
          hasLineVertical:(BOOL)hasLineVertical;

//更改title
- (void)changeTitle:(NSString *)strTitle;

@end
