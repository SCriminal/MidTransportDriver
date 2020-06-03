//
//  AdvertiesementView.h
//中车运
//
//  Created by 隋林栋 on 2018/10/8.
//Copyright © 2018年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
//play video
#import <AVFoundation/AVFoundation.h>
@interface AdvertiesementView : UIView
@property (nonatomic,strong)AVPlayer *player;//播放器对象
@property (nonatomic,strong)AVPlayerItem *currentPlayerItem;

- (void)playVideo:(NSString *)strUrl;
@end
