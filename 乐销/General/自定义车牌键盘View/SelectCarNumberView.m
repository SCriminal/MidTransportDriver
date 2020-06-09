//
//  CustomCharactersKeyBoardView.m
//  乐销
//
//  Created by lirenbo on 2018/5/31.
//  Copyright © 2018年 ping. All rights reserved.
//

#import "SelectCarNumberView.h"


@interface SelectCarNumberView()
@property (nonatomic, strong) DistrictAlphaView *alphaView;
@property (nonatomic, strong) CharacterView *characterView;
@property (nonatomic, strong) UIView *controlDismiss;

@end

@implementation SelectCarNumberView

#pragma mark 懒加载
- (NSString *)content{
    if (!_content) {
        _content = [NSString new];
    }
    return _content;
}
- (DistrictAlphaView *)alphaView{
    if (!_alphaView) {
        _alphaView = [DistrictAlphaView new];
        _alphaView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        _alphaView.btnClickBlock = ^(NSString *str) {
            if (weakSelf.content.length>=7) {
                return;
            }
            weakSelf.content = [weakSelf.content stringByAppendingString:str];
            [weakSelf refresh];
            if (weakSelf.blockSelected ) {
                weakSelf.blockSelected(weakSelf.content);
            }
        };
        _alphaView.deleteClickBlock = ^{
            if (weakSelf.content.length) {
                weakSelf.content = [weakSelf.content substringToIndex:weakSelf.content.length-1];
                [weakSelf refresh];
                if (weakSelf.blockSelected ) {
                    weakSelf.blockSelected(weakSelf.content);
                }
            }
        };
    }
    return _alphaView;
}
- (CharacterView *)characterView{
    if (!_characterView) {
        _characterView = [CharacterView new];
        _characterView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        _characterView.byValueBlock = ^(NSString *str) {
            if (weakSelf.content.length>=7) {
                return;
            }
            weakSelf.content = [weakSelf.content stringByAppendingString:str];
            [weakSelf refresh];
            if (weakSelf.blockSelected ) {
                weakSelf.blockSelected(weakSelf.content);
            }
        };
        _characterView.delBlack = ^{
            if (weakSelf.content.length) {
                weakSelf.content = [weakSelf.content substringToIndex:weakSelf.content.length-1];
                [weakSelf refresh];
                if (weakSelf.blockSelected ) {
                    weakSelf.blockSelected(weakSelf.content);
                }
            }
        };
    }
    return _characterView;
}
- (UIView *)controlDismiss{
    if (!_controlDismiss) {
        _controlDismiss = [UIView new];
        _controlDismiss.backgroundColor = [UIColor clearColor];
        _controlDismiss.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT - W(210)-iphoneXBottomInterval);
        [_controlDismiss addTarget:self action:@selector(dismissClick)];
    }
    return _controlDismiss;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        self.height= SCREEN_HEIGHT;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.alphaView];
    [self addSubview:self.characterView];
    [self addSubview:self.controlDismiss];

}

#pragma mark 刷新view
- (void)resetViewWithContent:(NSString *)content{
    self.content = content;
    //刷新view
    [self refresh];
}

- (void)refresh{
    self.alphaView.hidden = self.content.length>0;
    self.characterView.hidden = self.content.length==0;
}
- (void)dismissClick{
    [self removeFromSuperview];
}
@end


@implementation DistrictAlphaView

#pragma mark - 懒加载
-(UIButton *)deleteBtn{
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.tag = 1;
        [_deleteBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:_deleteBtn color:[UIColor clearColor] numRound:5 width:0];
        [_deleteBtn setImage:[UIImage imageNamed:@"icon_cp_delete"] forState:UIControlStateNormal];
    }
    return _deleteBtn;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromHexRGB(@"#D0D4DA");
        self.width = SCREEN_WIDTH;
        self.height = W(210)+iphoneXBottomInterval;
        [self addSubView];
        [self resetViewWithModel:nil];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.deleteBtn];
    NSArray * firstLineAry = @[@"京",@"津",@"沪",@"渝",@"苏",@"浙",@"豫",@"粤",@"川",@"陕"];
    for (int i = 0; i < firstLineAry.count; i ++) {
        UIButton * btn = [UIButton new];
        [btn setTitle:firstLineAry[i] forState:UIControlStateNormal];
        [self resetBtnWithNum:i left:W(5) lineNum:1 btn:btn];
        [self addSubview:btn];
    }
    
    NSArray * secondLineAry = @[@"冀",@"辽",@"吉",@"皖",@"闽",@"鄂",@"湘",@"鲁",@"晋"];
    for (int i = 0; i < secondLineAry.count; i ++) {
        UIButton * btn = [UIButton new];
        [btn setTitle:secondLineAry[i] forState:UIControlStateNormal];
        [self resetBtnWithNum:i left:W(24) lineNum:2 btn:btn];
        [self addSubview:btn];
    }
    
    NSArray * thirdLineAry = @[@"黑",@"赣",@"贵",@"甘",@"桂",@"琼",@"云",@"青"];
    for (int i = 0; i < thirdLineAry.count; i ++) {
        UIButton * btn = [UIButton new];
        [btn setTitle:thirdLineAry[i] forState:UIControlStateNormal];
        [self resetBtnWithNum:i left:W(42) lineNum:3 btn:btn];
        [self addSubview:btn];
    }
    
    NSArray * fourthLineAry = @[@"蒙",@"藏",@"宁",@"新",@"港",@"澳",@"台"];
    CGFloat centerY = 0;
    for (int i = 0; i < fourthLineAry.count; i ++) {
        UIButton * btn = [UIButton new];
        [btn setTitle:fourthLineAry[i] forState:UIControlStateNormal];
        [self resetBtnWithNum:i left:W(24) lineNum:4 btn:btn];
        [self addSubview:btn];
        centerY = btn.centerY;
    }
    
    self.deleteBtn.widthHeight = XY(W(66), W(41));
    self.deleteBtn.rightCenterY = XY(self.width-W(8),centerY);
    
}

- (void)resetBtnWithNum:(NSInteger)num left:(CGFloat)left lineNum:(NSInteger)lineNum btn:(UIButton *)sender
{
    CGFloat btnW = W(32);
    CGFloat btnH = W(43);
    CGFloat btnSpace = W(5);
    sender.leftTop = XY(left+(btnW+btnSpace)*num, W(8)+(lineNum-1)*(btnH+W(7)));
    sender.widthHeight = XY(btnW, btnH);
    [sender addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    sender.titleLabel.fontNum = F(20);
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sender setBackgroundImage:[UIImage imageNamed:@"icon_cp_keyBack"] forState:UIControlStateNormal];
}

#pragma mark - 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
}
#pragma mark - 点击事件
- (void)btnClick:(UIButton *)sender{
    if (sender.tag == 1) {
        if (self.deleteClickBlock) {
            self.deleteClickBlock();
        }
    }else{
        if(self.btnClickBlock){
            self.btnClickBlock(sender.titleLabel.text);
        }
    }
}


@end




#pragma mark - CompanyCenterHeaderView
@implementation CharacterView

-(UIButton *)deleteBtn{
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.tag = 1;
        [_deleteBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:_deleteBtn color:[UIColor clearColor] numRound:5 width:0];
        [_deleteBtn setImage:[UIImage imageNamed:@"icon_cp_delete"] forState:UIControlStateNormal];
    }
    return _deleteBtn;
}

#pragma mark 懒加载
- (NSMutableArray *)numAndLettersArr{
    if (!_numAndLettersArr) {
        _numAndLettersArr = [NSMutableArray array];
        NSArray * arr = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",nil];
        [_numAndLettersArr addObjectsFromArray:arr];
    }
    return _numAndLettersArr;
}
- (NSMutableArray *)numAndLettersArrSecond{
    if (!_numAndLettersArrSecond) {
        _numAndLettersArrSecond = [NSMutableArray array];
        NSArray * arr = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",nil];
        [_numAndLettersArrSecond addObjectsFromArray:arr];
    }
    return _numAndLettersArrSecond;
}
- (NSMutableArray *)numAndLettersArrThird{
    if (!_numAndLettersArrThird) {
        _numAndLettersArrThird = [NSMutableArray array];
        NSArray * arr = [[NSArray alloc] initWithObjects:@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",nil];
        [_numAndLettersArrThird addObjectsFromArray:arr];
    }
    return _numAndLettersArrThird;
}
- (NSMutableArray *)numAndLettersArrFourth{
    if (!_numAndLettersArrFourth) {
        _numAndLettersArrFourth = [NSMutableArray array];
        NSArray * arr = [[NSArray alloc] initWithObjects:@"W",@"X",@"Y",@"Z",nil];
        [_numAndLettersArrFourth addObjectsFromArray:arr];
    }
    return _numAndLettersArrFourth;
}



#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromHexRGB(@"#D0D4DA");
        self.width = SCREEN_WIDTH;
        self.height = W(210)+iphoneXBottomInterval;
        [self creatBtn];
        [self addSubview:self.deleteBtn];
        [self addSubView];
    }
    return self;
}

- (void)creatBtn{
    for(int i = 0;i<self.numAndLettersArr.count;i++){
        UIButton * btn = [UIButton new];
        //        btn.backgroundColor = [UIColor whiteColor];
        btn.widthHeight = XY(W(32), W(43));
        btn.leftTop = XY(W(5)+i*W(37), W(6));
        [btn setTitle:self.numAndLettersArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [GlobalMethod setRoundView:btn color:[UIColor whiteColor] numRound:4 width:1];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_cp_keyBack"] forState:UIControlStateNormal];
        [self addSubview:btn];
    }
    for(int i = 0;i<self.numAndLettersArrSecond.count;i++){
        UIButton * btn = [UIButton new];
        //        btn.backgroundColor = [UIColor whiteColor];
        btn.widthHeight = XY(W(32), W(43));
        btn.leftTop = XY(W(5)+i*W(37), W(6+43+6));
        [btn setTitle:self.numAndLettersArrSecond[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:btn color:[UIColor whiteColor] numRound:4 width:1];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_cp_keyBack"] forState:UIControlStateNormal];
        [self addSubview:btn];
    }
    for(int i = 0;i<self.numAndLettersArrThird.count;i++){
        UIButton * btn = [UIButton new];
        btn.widthHeight = XY(W(32), W(43));
        btn.leftTop = XY(W(5)+i*W(37), W(6+2*43+2*6));
        [btn setTitle:self.numAndLettersArrThird[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:btn color:[UIColor whiteColor] numRound:4 width:1];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_cp_keyBack"] forState:UIControlStateNormal];
        [self addSubview:btn];
    }
    for(int i = 0;i<self.numAndLettersArrFourth.count;i++){
        UIButton * btn = [UIButton new];
        btn.widthHeight = XY(W(32), W(43));
        btn.leftTop = XY(i*W(37)+W(5)+W(37)*3, W(6+3*43+3*6));
        [btn setTitle:self.numAndLettersArrFourth[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:btn color:[UIColor whiteColor] numRound:4 width:1];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_cp_keyBack"] forState:UIControlStateNormal];
        [self addSubview:btn];
        //刷新view
        self.deleteBtn.widthHeight = XY(W(66), W(43));
        self.deleteBtn.rightTop = XY(self.width-W(8), W(6+3*43+3*6));
    }
}


//添加subview
- (void)addSubView{
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
}

- (void)btnClick:(UIButton *)btn{
    if(btn.tag ==1){
        if(self.delBlack){
            self.delBlack();
        }
    }else {
        if(self.byValueBlock){
            self.byValueBlock(btn.titleLabel.text);
        }
    }
}


@end
