//
//  FeedbackVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/19.
//Copyright © 2019 ping. All rights reserved.
//

#import "FeedbackVC.h"
//text view
#import "PlaceHolderTextView.h"
//request
#import "RequestApi+Dictionary.h"
//图片选择collection
#import "Collection_Image.h"
//request
#import "RequestDriver2.h"
#import "SelectOrderVC.h"

@interface FeedbackVC ()
@property (nonatomic, strong) UILabel *labelNum;
@property (nonatomic,strong) PlaceHolderTextView *textView;
@property (nonatomic, strong) Collection_Image *collection_Image;
@property (nonatomic, strong) ModelTransportOrder *modelSelected;

@end

@implementation FeedbackVC
- (Collection_Image *)collection_Image{
    if (!_collection_Image) {
        _collection_Image = [Collection_Image new];
        _collection_Image.isEditing = true;
        _collection_Image.width =  SCREEN_WIDTH - W(30);
        [_collection_Image resetWithAry:nil];
    }
    return _collection_Image;
}

- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.backgroundColor = [UIColor clearColor];
//        _textView.delegate = self;
        [GlobalMethod setLabel:_textView.placeHolder widthLimit:0 numLines:0 fontNum:F(14) textColor:COLOR_999 text:@"请输入您的具体描述"];
        _textView.placeHolder.leftTop = XY(0, W(4));
        [_textView setTextColor:COLOR_333];
        _textView.font = [UIFont systemFontOfSize:F(14)];
        _textView.widthHeight = XY(W(321), W(100));
        
    }
    return _textView;
}
- (UILabel *)labelNum{
    if (_labelNum == nil) {
        _labelNum = [UILabel new];
        _labelNum.textColor = COLOR_999;
        _labelNum.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_labelNum fitTitle:@"选择投诉运单编号" variable:0];
        _labelNum.numberOfLines = 1;
    }
    return _labelNum;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self configView];
}
- (void)configView{
    {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(SCREEN_WIDTH, W(237));
        view.leftTop = XY(W(0), W(10));
        [self.view addSubview:view];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"投诉运单" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), W(27));
        [self.view addSubview:l];
        
        [self.view addSubview:self.labelNum];
        self.labelNum.leftCenterY = XY(W(90), l.centerY);
        [self.view addControlFrame:CGRectInset(self.labelNum.frame, -W(230), -W(20)) belowView:self.labelNum target:self action:@selector(numClick)];
        
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"setting_RightArrow"];
        iv.widthHeight = XY(W(25),W(25));
        iv.rightCenterY = XY(SCREEN_WIDTH - W(10),l.centerY);
        [self.view addSubview:iv];
    }
    [self.view addLineFrame:CGRectMake(W(15), W(59), SCREEN_WIDTH - W(30), 1)];

    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"投诉内容" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), W(78));
        [self.view addSubview:l];
    }
    {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(W(345), W(120));
        view.centerXTop = XY(SCREEN_WIDTH/2.0, W(110));
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
        [self.view addSubview:view];
    }
    [self.view addSubview:self.textView];
    self.textView.centerXTop = XY(SCREEN_WIDTH/2.0, W(125));
    
    [self.view addLineFrame:CGRectMake(W(0 ), W(247), SCREEN_WIDTH , W(10)) color:COLOR_BACKGROUND];

    {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(SCREEN_WIDTH, W(138));
        view.leftTop = XY(W(0), W(257));
        [self.view addSubview:view];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"附件（可多张）" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), W(272));
        [self.view addSubview:l];
    }
    [self.view addSubview:self.collection_Image];
    self.collection_Image.leftTop = XY(W(15), W(302));
    
    {
        UIButton * btn = [UIButton createBottomBtn:@"保存"];
        btn.centerXTop = XY(SCREEN_WIDTH/2.0, W(410));
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(saveClick)];
    }
}

- (void)numClick{
    SelectOrderVC * selectVC = [SelectOrderVC new];
    WEAKSELF
    selectVC.blockSelected = ^(ModelTransportOrder * item) {
        [weakSelf.labelNum fitTitle:item.orderNumber variable:W(220)];
        weakSelf.labelNum.textColor = COLOR_333;
        weakSelf.modelSelected = item;
    };
    [GB_Nav pushViewController:selectVC animated:true];
}
- (void)saveClick{
    [self request];

}
#pragma mark request
- (void)request{
   
    if (self.textView.text.length <5) {
        [GlobalMethod showAlert:@"请输入更多内容"];
        return;
    }
    NSString *str0 = nil;
    NSString *str1 = nil;
    NSString *str2 = nil;
    if (self.collection_Image.aryDatas.count>=3) {
        ModelImage * item = self.collection_Image.aryDatas[2];
        str2 = item.url;
    }
    if (self.collection_Image.aryDatas.count>=2) {
        ModelImage * item = self.collection_Image.aryDatas[1];
        str1 = item.url;
    }
    if (self.collection_Image.aryDatas.count>=1) {
        ModelImage * item = self.collection_Image.aryDatas[0];
        str0 = item.url;
    }
    [RequestApi requestProblemWithProblemtype:1 type:1 description:self.textView.text submitUrl1:str0 submitUrl2:str1 submitUrl3:str2 waybillNumber:self.modelSelected.orderNumber delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"提交成功"];
        [GB_Nav popViewControllerAnimated:true];

        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];

}

- (void)imagesSelect:(NSArray *)aryImages
{
    [[AliClient sharedInstance]updateImageAry:aryImages  storageSuccess:nil upSuccess:nil upHighQualitySuccess:nil fail:nil];
    for (BaseImage *image in aryImages) {
        ModelImage * modelImageInfo = [ModelImage new];
        modelImageInfo.url = image.imageURL;
        modelImageInfo.image = image;
        modelImageInfo.width = image.size.width;
        modelImageInfo.height = image.size.height;
        [self.collection_Image.aryDatas insertObject:modelImageInfo atIndex:0];
    }
    [self.collection_Image.collectionView reloadData];

}
//选择图片
- (void)showImageVC:(int)imageNum{
    [self showImageVC:3 cameraType:ENUM_CAMERA_DEFAULT];
}
@end
