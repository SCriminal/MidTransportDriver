//
//  UpImageWithTextVC.h
//中车运
//
//  Created by 宋晨光 on 17/3/11.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "BaseTableVC.h"
#import "BaseVC+BaseImageSelectVC.h"//select image category
#import "AliClient.h"//up image type

@interface UpImageWithTextVC : BaseTableVC

@property (nonatomic, strong)  void (^blockSave)(NSArray *);

@property (nonatomic, strong) NSArray *aryInit;


@end

