//
//  SendMsgHelper.m
//中车运
//
//  Created by 隋林栋 on 2018/7/10.
//  Copyright © 2018年 ping. All rights reserved.
//

#import "SendMsgHelper.h"

@implementation SendMsgHelper

SYNTHESIZE_SINGLETONE_FOR_CLASS(SendMsgHelper)

- (void)sendMsg:(NSString *)msg to:(NSString *)numPhone{
    if (![MFMailComposeViewController canSendMail]) {
        [GlobalMethod showAlert:@"设备无法发送短信"];
        return;
    }
    MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc] init];
    vc.body = UnPackStr(msg);
    vc.recipients = @[UnPackStr(numPhone)];
    vc.messageComposeDelegate = self;
    [GB_Nav.lastVC presentViewController:vc animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController*)controller didFinishWithResult:(MessageComposeResult)result
{
    // 关闭短信界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (self.blockComplete) {
        self.blockComplete(result);
    }
    self.blockComplete = nil;
}


@end
