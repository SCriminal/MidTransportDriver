//
//  UpImageWithTextVC.m
//中车运
//
//  Created by 宋晨光 on 17/3/11.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "UpImageWithTextVC.h"
#import "UpImageWithTextCell.h"
//ali
#import "AliClient.h"
//add edit observe


@interface UpImageWithTextVC ()<UpImageWithTextDelegate>
@property (nonatomic,strong) UIButton *greenAddButton;

@end

@implementation UpImageWithTextVC

-(UIButton *)greenAddButton{
    if (_greenAddButton == nil) {
        _greenAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_greenAddButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _greenAddButton.backgroundColor = [UIColor clearColor];
        [_greenAddButton setImage:[UIImage imageNamed:@"image_select_tj"] forState:UIControlStateNormal];
        [GlobalMethod setRoundView:_greenAddButton color:[UIColor clearColor] numRound:5 width:0];
        _greenAddButton.widthHeight = XY(SCREEN_WIDTH,W(40));
    }
    return _greenAddButton;
}

- (void)setAryInit:(NSArray *)aryInit{
    if (isAry(aryInit)) {
        self.aryDatas = [NSMutableArray arrayWithArray:aryInit];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //add keyboard observe
    [self addObserveOfKeyboard];
    
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:@"图片描述" rightTitle:@"保存" rightBlock:^{
        if (weakSelf.blockSave) {
            [weakSelf filterArdDatas];
            weakSelf.blockSave(weakSelf.aryDatas);
        }
        [GB_Nav popViewControllerAnimated:true];
    }]];
    //table view
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerClass:[UpImageWithTextCell class] forCellReuseIdentifier:@"UpImageWithTextCell"];
    
    [self createFooterView];
    
    
}

-(void)createFooterView
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, W(40))];
    footerView.backgroundColor = [UIColor clearColor];
    [footerView addSubview:self.greenAddButton];
    self.tableView.tableFooterView = footerView;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.aryDatas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UpImageWithTextCell fetchHeight:nil];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UpImageWithTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UpImageWithTextCell"];
    cell.delegate = self;
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    cell.topButton.hidden = indexPath.row == 0 ? YES : NO;
    cell.downButton.hidden = self.aryDatas.count == indexPath.row + 1 ? YES : NO;
    
    return cell;
}

//1添加 5删除  10向上 11向下

-(void)protocolUpImageWithTextButton:(NSInteger)senderTag cell:(UITableViewCell *)cell
{
    NSIndexPath * index = [self.tableView indexPathForCell:cell];
    switch (senderTag) {
        case 1:
        {
            [self addClickWithIndex:index.row];
            return;
        }
            break;
            case 5:
        {
            [self.aryDatas removeObjectAtIndex:index.row];

        }
            break;
            case 10:
        {
            [self.aryDatas exchangeObjectAtIndex:index.row - 1 withObjectAtIndex:index.row];
        }
            break;
            case 11:
        {
            [self.aryDatas exchangeObjectAtIndex:index.row  withObjectAtIndex:index.row + 1];
        }
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)btnClick:(UIButton *)sender
{
    [self addClickWithIndex:self.aryDatas.count];
}

-(void)addClickWithIndex:(NSUInteger)index{
    ModelImage *model = [ModelImage new];
    [self.aryDatas insertObject:model atIndex:index];
    [self.tableView reloadData];
}
#pragma mark筛选数据
- (void)filterArdDatas{
    for (ModelImage * model in self.aryDatas.copy) {
        if (!isStr(model.url)) {
            [self.aryDatas removeObject:model];
        }
    }
}

#pragma mark 选择图片
- (void)imagesSelect:(NSArray *)aryImages
{
    [[AliClient sharedInstance]updateImageAry:aryImages  
 storageSuccess:nil upSuccess:nil fail:nil];
    for (BaseImage *image in aryImages) {
        ModelImage * modelImageInfo = [ModelImage new];
        modelImageInfo.url = image.imageURL;
        modelImageInfo.image = image;
        modelImageInfo.width = image.size.width;
        modelImageInfo.height = image.size.height;
        [self.aryDatas insertObject:modelImageInfo atIndex:0];
    }
    [self.tableView reloadData];
}

@end


