//
//  UIImageView+Category.m
//中车运
//
//  Created by 隋林栋 on 2017/12/4.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "UIImageView+Category.h"


static const char modelUIImageViewKey = '\0';
static const char identityUIImageViewKey = '\0';
@implementation UIImageView (Category)

#pragma mark run time
- (void)setModel:(id)model{
    objc_setAssociatedObject(self, &modelUIImageViewKey, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id)model{
    id model = objc_getAssociatedObject(self, &modelUIImageViewKey);
    return  model;
}
- (void)setIdentity:(double)identity{
    objc_setAssociatedObject(self, &identityUIImageViewKey, [NSNumber numberWithDouble:identity], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (double)identity{
    NSNumber * numID = objc_getAssociatedObject(self, &identityUIImageViewKey);
    if (numID && [numID isKindOfClass:[NSNumber class]]) {
        return [numID doubleValue];
    }
    return 0;
}


#pragma mark sdweb image category: show product image
- (void)sd_setProductImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder{
    WEAKSELF
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        if (!weakSelf) {
            return;
        }
        STRONGSELF
        if (image) {
            self.image = image;
            self.contentMode = image.size.width>image.size.height?UIViewContentModeScaleAspectFill:UIViewContentModeScaleAspectFit;
        }
        
    }];
}

#pragma mark show image with modelImage
- (void)sd_setImageWithModel:(ModelImage *)model placeholderImageName:(NSString *)placeholderName{
    [self sd_setImageWithModel:model placeholderImageName:placeholderName useSmaleImage:false];
}
- (void)sd_setSmallImageWithModel:(ModelImage *)model placeholderImageName:(NSString *)placeholderName{
    [self sd_setImageWithModel:model placeholderImageName:placeholderName useSmaleImage:true];
}

- (void)sd_setImageWithModel:(ModelImage *)model placeholderImageName:(NSString *)placeholderName  useSmaleImage:(BOOL)useSmallImage{
    if (isStr(model.image.imageURL)) {//本地图片缓存 抓取高清图片
        UIImage * imageCache = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:model.image.imageURL];
        if (imageCache) {
            self.image = imageCache;
            return;
        }
    }
    if (model.image) {//本地图片
        self.image = model.image;
    }else{//网络图片
        UIImage * imageSmallCache = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:model.url.smallImage];
        if (!imageSmallCache) {
            imageSmallCache = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:model.url.middleImage];
        }
        [self sd_setImageWithURL:[NSURL URLWithString:useSmallImage?model.url.smallImage:model.url] placeholderImage:imageSmallCache?:[UIImage imageNamed:placeholderName]];
    }
}

@end
