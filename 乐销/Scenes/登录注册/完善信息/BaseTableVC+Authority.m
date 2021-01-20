//
//  BaseTableVC+Authority.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/6.
//  Copyright © 2019 ping. All rights reserved.
//

#import "BaseTableVC+Authority.h"
#import "NSObject+Catrgory.h"

@implementation BaseTableVC (Authority)

- (void)registAuthorityCell{
    [self.tableView registerClass:[PerfectSelectCell class] forCellReuseIdentifier:@"PerfectSelectCell"];
    [self.tableView registerClass:[PerfectTextCell class] forCellReuseIdentifier:@"PerfectTextCell"];
    [self.tableView registerClass:[PerfectAddressDetailCell class] forCellReuseIdentifier:@"PerfectAddressDetailCell"];
    [self.tableView registerClass:[PerfectEmptyCell class] forCellReuseIdentifier:@"PerfectEmptyCell"];
    [self.tableView registerClass:[PerfectSelectCell_Path class] forCellReuseIdentifier:@"PerfectSelectCell_Path"];
    [self.tableView registerClass:[PerfectSelectCell_Logo class] forCellReuseIdentifier:@"PerfectSelectCell_Logo"];


}
- (UITableViewCell *)dequeueAuthorityCell:(NSIndexPath *)indexPath{
    ModelBaseData * model = self.aryDatas[indexPath.row];
    switch (model.enumType) {
        case ENUM_PERFECT_CELL_TEXT:
        {
            PerfectTextCell * textCell = [self.tableView dequeueReusableCellWithIdentifier:@"PerfectTextCell"];
            [textCell resetCellWithModel:model];
            return textCell;
        }
            break;
        case ENUM_PERFECT_CELL_SELECT:
        {
            PerfectSelectCell * selectCell = [self.tableView dequeueReusableCellWithIdentifier:@"PerfectSelectCell"];
            [selectCell resetCellWithModel:model];
            return selectCell;
        }
            break;
            case ENUM_PERFECT_CELL_SELECT_DELETE:
            {
                PerfectSelectCell_Path * selectCell = [self.tableView dequeueReusableCellWithIdentifier:@"PerfectSelectCell_Path"];
                [selectCell resetCellWithModel:model];
                return selectCell;
            }
                break;
        case ENUM_PERFECT_CELL_SELECT_LOGO:
        {
            PerfectSelectCell_Logo * selectCell = [self.tableView dequeueReusableCellWithIdentifier:@"PerfectSelectCell_Logo"];
            [selectCell resetCellWithModel:model];
            return selectCell;
        }
            break;
        case ENUM_PERFECT_CELL_ADDRESS:
        {
            PerfectAddressDetailCell * addressCell = [self.tableView dequeueReusableCellWithIdentifier:@"PerfectAddressDetailCell"];
            [addressCell resetCellWithModel:model];
            return addressCell;
        }
            break;
        case ENUM_PERFECT_CELL_EMPTY:
        {
            PerfectEmptyCell * addressCell = [self.tableView dequeueReusableCellWithIdentifier:@"PerfectEmptyCell"];
            [addressCell resetCellWithModel:model];
            return addressCell;
        }
            break;
        default:
            break;
    }
    return nil;
}
- (CGFloat)fetchAuthorityCellHeight:(NSIndexPath *)indexPath{
    ModelBaseData * model = self.aryDatas[indexPath.row];
    switch (model.enumType) {
        case ENUM_PERFECT_CELL_TEXT:
        {
            return [PerfectTextCell fetchHeight:model];
        }
            break;
        case ENUM_PERFECT_CELL_SELECT:
        {
            return [PerfectSelectCell fetchHeight:model];
        }
            break;
            case ENUM_PERFECT_CELL_SELECT_DELETE:
                   {
                       return [PerfectSelectCell_Path fetchHeight:model];
                   }
                       break;
        case ENUM_PERFECT_CELL_SELECT_LOGO:
               {
                   return [PerfectSelectCell_Logo fetchHeight:model];
               }
                   break;
        case ENUM_PERFECT_CELL_ADDRESS:
        {
            CGFloat height = [PerfectAddressDetailCell fetchHeight:model];
            return height;
        }
            break;
        case ENUM_PERFECT_CELL_EMPTY:
        {
            return [PerfectEmptyCell fetchHeight:model];
        }
            break;
        default:
            break;
    }
    return 0.00;
}
- (void)saveAllProperty{
    NSArray * ary = [self getAllProperties];
    for (NSString * proName in ary) {
       ModelBaseData * model =  (ModelBaseData *)[self valueForKey:proName];
        if ([model isKindOfClass:[ModelBaseData class]]||[model isKindOfClass:[ModelOCR class]]) {
            [GlobalMethod writeModel:model key:[NSString stringWithFormat:@"%@_%@",self.class,proName]];
        }
    }
}
- (void)fetchAllProperty{
    NSArray * ary = [self getAllProperties];
    for (NSString * proName in ary) {
        ModelBaseData * model =  (ModelBaseData *)[self valueForKey:proName];
         if ([model isKindOfClass:[ModelBaseData class]]) {
             ModelBaseData * modelLocal = [GlobalMethod readModelForKey:[NSString stringWithFormat:@"%@_%@",self.class,proName] modelName:@"ModelBaseData"];
             if (modelLocal) {
                 modelLocal.blockValueChange = model.blockValueChange;
                 modelLocal.blocClick = model.blocClick;
                 modelLocal.blockDeleteClick = model.blockDeleteClick;
                 [self setValue:modelLocal forKey:proName];
             }
         }else if ([model isKindOfClass:[ModelOCR class]]) {
             ModelBaseData * modelLocal = [GlobalMethod readModelForKey:[NSString stringWithFormat:@"%@_%@",self.class,proName] modelName:@"ModelOCR"];
             if (modelLocal) {
                 [self setValue:modelLocal forKey:proName];
             }
         }
    }
}
@end
