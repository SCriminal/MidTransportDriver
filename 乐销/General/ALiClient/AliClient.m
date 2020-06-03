//
//  AliClient.m
//中车运
//
//  Created by 隋林栋 on 2016/12/26.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "AliClient.h"
//上传图片
#import "BaseImage.h"
//afnet work
//#import <AFNetworking.h>
//model
#import "ModelAliClient_Base.h"
//request
#import "RequestApi+Dictionary.h"
//md5
#import "NSString+YYAdd.h"

@implementation AliClient
SYNTHESIZE_SINGLETONE_FOR_CLASS(AliClient)

-(NSString *)imagePath{
    switch (self.imageType) {
        case ENUM_UP_IMAGE_TYPE_USER_LOGO:
            return @"/ums/head/";
            break;
        case ENUM_UP_IMAGE_TYPE_USER_AUTHORITY:
            return @"/ums/qualification/";
            break;
        case ENUM_UP_IMAGE_TYPE_COMPANY_LOGO:
            return @"/zhongcheyun/ent/logo/";
            break;
        case ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY:
            return @"/zhongcheyun/ent/qualification/";
            break;
        case ENUM_UP_IMAGE_TYPE_COMPANY_CAR:
        {
            return @"/zhongcheyun/ent/vehicle/";
        }
            break;
        case ENUM_UP_IMAGE_TYPE_ORDER:
            return @"/zhongcheyun/waybill/";
            break;
        case ENUM_UP_IMAGE_TYPE_DOWNLOAD:
            return @"/zhongcheyun/version/";
            break;
        default:
            break;
    }
    return @"";
}


- (void)updateImageAry:(NSArray *)aryDatas
        storageSuccess:(void(^)(void))storageSuccess
             upSuccess:(void(^)(void))upSuccess
                  fail:(void(^)(void))fail{
    //config image URL
    for (BaseImage * image  in aryDatas) {
        if (!isStr(image.identity)) {
            NSString * imageId = [[NSString stringWithFormat:@"%lf",[[NSDate date] timeIntervalSince1970]] md5String];
            NSString *imageNameID = [NSString stringWithFormat:@"%@.jpeg",imageId];
            image.identity = imageNameID;
            image.imageURL = [NSString stringWithFormat:@"%@%@%@",URL_IMAGE,self.imagePath,image.identity];
        }
    }
    //write data to Local
    [GlobalMethod asynthicBlock:^{
        [self storeHighImage:aryDatas storageSuccess:storageSuccess];
    }];

    [GlobalMethod asynthicBlock:^{
        for (BaseImage * image  in aryDatas) {
            if (isStr(image.imageURL) && image.upHightQualityComplete) {
                continue;
            }
            image.imageURL = [NSString stringWithFormat:@"%@%@%@",URL_IMAGE,self.imagePath,image.identity];
            [self upImageData:UIImageJPEGRepresentation(image,1) urlSuffix:image.identity blockSuccess:^{
                image.upComplete = true;
                [self removeKeyInSDWebImageBlackList:image.imageURL];
                if (!image.upHightQualityComplete && image.asset) {
                    [GlobalMethod asynthicBlock:^{
                        [self upImageHeigh:image.asset urlSuffix:image.identity blockSuccess:^(void){
                            image.upHightQualityComplete = true;
                        }blockFailure:nil];
                    }];
                }

                BOOL isAllComplete = true;
                for (BaseImage * image in aryDatas) {
                    if (!image.upComplete) {
                        isAllComplete = false;
                        break;
                    }
                }
                if (isAllComplete) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (upSuccess) {
                            upSuccess();
                        }
                    });
                }
            } blockFailure:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (fail) {
                        fail();
                    }
                });
            }];
        }
    }];
}
- (void)storeHighImage:(NSArray *)aryDatas
        storageSuccess:(void(^)(void))storageSuccess
{
    PHImageManager *imageManager = [[PHImageManager alloc] init];
    PHImageRequestOptions *opt = [[PHImageRequestOptions alloc]init];
    opt.resizeMode = PHImageRequestOptionsResizeModeNone;
    opt.synchronous = YES;
    opt.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;;
    for (BaseImage * image  in aryDatas) {
        NSString * strPathURL = [NSString stringWithFormat:@"%@%@%@",URL_IMAGE,self.imagePath,image.identity];
        [self removeKeyInSDWebImageBlackList:strPathURL];
        if (![[SDWebImageManager sharedManager].imageCache diskImageExistsWithKey:strPathURL] ) {
            if (image.asset) {
                [imageManager requestImageForAsset:image.asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:opt resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    NSData * imageData = UIImageJPEGRepresentation(result, 1);
                   
                    [[SDWebImageManager sharedManager].imageCache storeImageDataToDisk:imageData forKey:strPathURL];
                }];
            }else{
                NSData * imageData = UIImageJPEGRepresentation(image, 1);
               
                [[SDWebImageManager sharedManager].imageCache storeImageDataToDisk:imageData forKey:strPathURL];
            }
            
        }
    }
    if (storageSuccess) {
        [GlobalMethod mainQueueBlock:^{
            storageSuccess();
        }];
    }
    
    
}
- (void)upImageHeigh:(PHAsset *)asset urlSuffix:(NSString *)imageIdentity blockSuccess:(void (^)(void))blockSuccess blockFailure:(void (^)(void))blockFailure{

    PHImageManager *imageManager = [[PHImageManager alloc] init];
    PHImageRequestOptions *opt = [[PHImageRequestOptions alloc]init];
    opt.resizeMode = PHImageRequestOptionsResizeModeNone;
    opt.synchronous = YES;
    opt.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;;
    [imageManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:opt resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        NSData * imageData = UIImageJPEGRepresentation(result, 1);
        int num =0;
        while (imageData.length > 1.8*1024*1024)
        {
            num++;
            if (num>8) {
                break;
            }
            result = [UIImage imageWithData:imageData];
            imageData = UIImageJPEGRepresentation(result,0.4);
        }
        [self upImageData:imageData urlSuffix:imageIdentity blockSuccess:blockSuccess blockFailure:blockFailure];
    }];
    
}

- (void)upImageData:(NSData *)imageData urlSuffix:(NSString *)imageIdentity blockSuccess:(void (^)(void))blockSuccess blockFailure:(void (^)(void))blockFailure{
    if (!isStr(imageIdentity)) {
        return;
    }
    if (!imageData) {
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20;
    //ignore security
    manager.securityPolicy.allowInvalidCertificates=YES;
    //是否在证书域字段中验证域名
    [manager.securityPolicy setValidatesDomainName:NO];

    [manager.requestSerializer setValue:@"multipart/form-data;" forHTTPHeaderField:@"Content-Type"];
    NSDictionary *dic = @{@"path":RequestStrKey(self.imagePath),
                          @"file":RequestStrKey(imageIdentity)};
    
    //设置请求头
    dic = [RequestApi setInitHead:dic];
    
    //拼接参数
    NSString * urlNew = [RequestApi replaceParameter:dic url:@"/zhongcheyun/file/app"];
    
    [manager POST:urlNew parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:imageIdentity mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (blockSuccess!=nil) {
            blockSuccess();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (blockFailure!=nil) {
            blockFailure();
        }
    }];
    
    
}



#pragma mark remove key in SDWebimage blacklist
- (void)removeKeyInSDWebImageBlackList:(NSString *)key{
    if (!isStr(key)) {
        return;
    }
    NSURL *url = [NSURL URLWithString:key];
    SDWebImageManager * sdManager = [SDWebImageManager sharedManager];
    if ([sdManager respondsToSelector:NSSelectorFromString(@"failedURLs")]) {
        NSMutableSet * failUrls = [sdManager valueForKeyPath:@"failedURLs"];
        if ([failUrls isKindOfClass:NSMutableSet.class]) {
            @synchronized (failUrls) {
                if ([failUrls containsObject:url]) {
                    [failUrls removeObject:url];
                }
            }
        }
    }
}



@end
