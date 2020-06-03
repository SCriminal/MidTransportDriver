//
//  OrderDetailAccessoryView.m
//  Driver
//
//  Created by 隋林栋 on 2019/7/12.
//Copyright © 2019 ping. All rights reserved.
//

#import "OrderDetailAccessoryView.h"
//detail big image view
#import "ImageDetailBigView.h"
#import "NSString+YYAdd.h"
@interface OrderDetailAccessoryView ()<UIDocumentInteractionControllerDelegate>

@end


@implementation OrderDetailAccessoryView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineSpace = 0;
    }
    return _labelTitle;
}
- (UIImageView *)ivBg{
    if (_ivBg == nil) {
        _ivBg = [UIImageView new];
        _ivBg.image = IMAGE_WHITE_BG;
        _ivBg.backgroundColor = [UIColor clearColor];
    }
    return _ivBg;
}
- (NSMutableArray *)aryImageDatas{
    if (!_aryImageDatas) {
        _aryImageDatas = [NSMutableArray new];
    }
    return _aryImageDatas;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.labelTitle];
}

#pragma mark 刷新view
- (void)resetViewWithAry:(NSArray *)ary  modelOrder:(ModelOrderList *)modelOrder{
    self.aryDatas = ary;
    [self.aryImageDatas removeAllObjects];
    
    [self removeAllSubViews];//移除线
    [self addSubView];
    //刷新view
    [self.labelTitle fitTitle:@"附件信息" variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    //设置总高度
    CGFloat bottom = self.labelTitle.bottom+ W(20);
    
    for (int i = 0; i<ary.count; i++) {
        ModelAccessoryItem * item = ary[i];
        if ([self isImage:item.fileUrl]) {
            [self.aryImageDatas addObject:^(){
                ModelImage * modelImage = [ModelImage new];
                modelImage.url = item.fileUrl;
                modelImage.desc = item.fileName;
                return modelImage;
            }()];
        }
        UILabel * label = [UILabel new];
        label.fontNum = F(15);
        label.textColor = COLOR_333;
        [label fitTitle: [NSString stringWithFormat:@"附件名称：%@%@",UnPackStr(item.fileName),[self isImage:item.fileUrl]?@"(图片)":@""] variable:SCREEN_WIDTH - W(50) - W(30)];
        label.leftTop = XY(W(25), bottom + W(20));
        [self addSubview:label];
        bottom = label.bottom;
        
        UILabel * labelTime = [UILabel new];
        labelTime.fontNum = F(15);
        labelTime.textColor = COLOR_BLUE;
        [labelTime fitTitle:@"查看" variable:0];
        labelTime.rightCenterY = XY(SCREEN_WIDTH - W(25), label.centerY);
        [self addSubview:labelTime];
        
        UIView * control =  [self addControlFrame:CGRectMake(0, label.top-W(5), SCREEN_WIDTH, label.height+W(10)) belowView:label target:self action:@selector(accessoryClick:)];
        control.tag = i;
    }
    
    self.height = bottom+W(20);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
    
}

- (void)accessoryClick:(UIControl *)con{
    if (self.aryDatas.count>con.tag) {
        ModelAccessoryItem * item = self.aryDatas[con.tag];
        NSLog(@"%@",item.fileName);
        if ([self isImage:item.fileUrl]) {//图片展示
            ImageDetailBigView * detailView = [ImageDetailBigView new];
            NSInteger index = [self.aryImageDatas fetchSameModelIndexKeyPath:@"url" value:item.fileUrl];
            [detailView resetView:self.aryImageDatas.tmpMuAry isEdit:false index: index>0?index:0];
            [detailView showInView:GB_Nav.lastVC.view imageViewShow:nil];
        }else{
            [self downloadFile:item];
        }
        
    }
}
//判断是否是图片
- (BOOL)isImage:(NSString *)url{
    if (!isStr(url)) {
        return false;
    }
    if ([url hasSuffix:@".png"]||[url hasSuffix:@".jpg"]||[url hasSuffix:@".jpeg"]) {
        return true;
    }
    return false;
}

//下载文件
- (void)downloadFile:(ModelAccessoryItem *)item{
    NSString * requestURL =item.fileUrl;
    //判断url
    if (!isStr(item.fileUrl)) {
        [GlobalMethod showAlert:@"链接失效"];
        return;
    }
    //首先判断本地是否存在
    if ([self judgeUrlExistInLocal:requestURL]) {
        [self openFile:item];
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:item.fileUrl]];
    //ignore security
    manager.securityPolicy.allowInvalidCertificates=YES;
    //是否在证书域字段中验证域名
    [manager.securityPolicy setValidatesDomainName:NO];
    BaseVC * vc = (BaseVC *)GB_Nav.lastVC;
    [vc showLoadingView];
    NSURLSessionDownloadTask *task =
    [manager downloadTaskWithRequest:request
                            progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                                return [NSURL fileURLWithPath:[self localPathWithKey:[self fetchKeyFromRequestURL:requestURL]]];
                            }
                   completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                       NSLog(@"%@",filePath);
                       [GlobalMethod mainQueueBlock:^{
                           [vc.loadingView hideLoading];
                           if (error) {
                               [GlobalMethod showAlert:@"下载失败"];
                           }else{
                               [self openFile:item];
                               
                           }
                       }];
                       
                   }];
    [task resume];
}

- (void)openFile:(ModelAccessoryItem *)item{
    NSString * strKey = [self fetchKeyFromRequestURL:item.fileUrl];
    NSURL * url = [NSURL fileURLWithPath:[self localPathWithKey:strKey]];
    UIDocumentInteractionController * controller = [UIDocumentInteractionController interactionControllerWithURL:url];
    controller.delegate = self;
    controller.name = item.fileName;
    [controller presentPreviewAnimated:YES];
    
    
    
}
//判断本地是否存在
- (BOOL)judgeUrlExistInLocal:(NSString *)requstURL{
    NSString * strKey = [self fetchKeyFromRequestURL:requstURL];
    if (!isStr(strKey)) return false;
    return [[NSFileManager defaultManager] fileExistsAtPath:[self localPathWithKey:strKey]];
}
//根据key 组建本地url
- (NSString *)localPathWithKey:(NSString *)key{
    NSString * strCachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    return [strCachePath stringByAppendingPathComponent:key];
}
//将请求url 转换为本地url
- (NSString *)fetchKeyFromRequestURL:(NSString *)requestURL{
    if (!isStr(requestURL)) return @"";
    //获取key
    NSString *fileType = [requestURL componentsValidSeparatedByString:@"."].lastObject;
    NSString * strKey = [NSString stringWithFormat:@"%@.%@",[requestURL md5String],fileType ];
    if (!isStr(strKey)) return @"";
    return strKey;
}

#pragma mark 代理方法
//为快速预览指定控制器
- (UIViewController*)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController*)controller
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return GB_Nav.lastVC;
}

//为快速预览指定View
- (UIView*)documentInteractionControllerViewForPreview:(UIDocumentInteractionController*)controller
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return GB_Nav.lastVC.view;
}

//为快速预览指定显示范围
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    //    return self.view.frame;
    return CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
}

@end
