//
//  LDMacro.h
//  LDMacro
//
//  Created by 隋林栋 on 2018/3/19.
//

#ifndef LDMacro_h
#define LDMacro_h

//weakself strongSelf
#define WEAKSELF __weak typeof(self) weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong self = weakSelf;

//screen width height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//nav height
#define NAVIGATIONBAR_HEIGHT (64.0f+iphoneXTopInterval) //导航条的高度
#define TABBAR_HEIGHT        (49.0f+iphoneXBottomInterval)  //工具栏高度
#define STATUSBAR_HEIGHT     (20.0f+iphoneXTopInterval) //状态栏高度

//iphone device version
#define isIphone5 ([UIScreen mainScreen].bounds.size.width == 320)
#define isIphone6 ([UIScreen mainScreen].bounds.size.width == 375)
#define isIphone6p ([UIScreen mainScreen].bounds.size.width == 414)

#define isIphoneX  (((int)((SCREEN_HEIGHT/SCREEN_WIDTH)*100) == 216)?YES:NO)

#define iphoneXBottomInterval (isIphoneX?34:0)
#define iphoneXTopInterval (isIphoneX?24:0)

//adapt
#define W(n)  ((n)* [UIScreen mainScreen].bounds.size.width / 375.0f)
#define F(n)  (([UIScreen mainScreen].bounds.size.width == 320)?(n-1):([UIScreen mainScreen].bounds.size.width == 375)?(n):([UIScreen mainScreen].bounds.size.width == 414)?(n+1):(n+2))
#define H(n)  (n*[UIScreen mainScreen].bounds.size.height / 667.0f)

#endif /* LDMacro_h */
