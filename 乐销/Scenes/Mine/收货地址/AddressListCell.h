//
//  AddressListCell.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressListCell : UITableViewCell

@property (strong, nonatomic) UIButton *btnEdit;
@property (strong, nonatomic) UIButton *btnDelete;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *address;
@property (nonatomic, strong) void (^blockEditClick)(ModelShopAddress *);
@property (nonatomic, strong) void (^blockDeleteClick)(ModelShopAddress *);
@property (nonatomic, strong) ModelShopAddress *model;


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelShopAddress *)model;

@end
