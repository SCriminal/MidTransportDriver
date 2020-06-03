//
//  SendMsgHelper.h
//中车运
//
//  Created by 隋林栋 on 2018/7/10.
//  Copyright © 2018年 ping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>//message
@interface SendMsgHelper : NSObject<MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) void(^blockComplete)(MessageComposeResult);//block
//send msg to
- (void)sendMsg:(NSString *)msg to:(NSString *)numPhone;
//单例
DECLARE_SINGLETON(SendMsgHelper)

@end
