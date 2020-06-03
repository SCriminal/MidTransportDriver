//
//  Collection_Image.m
//中车运
//
//  Created by 隋林栋 on 2017/1/9.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "Collection_Image.h"
#import "CollectionImageCell.h"//cell
#import "ImageDetailBigView.h"//detail

@interface Collection_Image()

@end

@implementation Collection_Image

#pragma mark 懒加载
- (NSMutableArray *)aryDatas {
    if (!_aryDatas) {
        _aryDatas = [NSMutableArray array];
    }
    return _aryDatas;
}
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        // 1.流水布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;
        layout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0);
        CGSize size = [self fetchCellSize];
        layout.itemSize = size;
        layout.scrollDirection = self.scrollDirection;
        // 6.创建UICollectionView
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height) collectionViewLayout:layout];
        // 7.设置collectionView的背景色
        _collectionView.backgroundColor = [UIColor whiteColor];
        // 8.设置代理
        _collectionView.collectionViewLayout = layout;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = false;
        _collectionView.showsHorizontalScrollIndicator = false;
        [_collectionView registerClass:NSClassFromString(self.collectionCellName) forCellWithReuseIdentifier:self.collectionCellName];
    }
    return _collectionView;
}

#pragma mark 初始化
- (instancetype)init{
    return [self initWithConfig:true];
}
- (instancetype)initWithConfig:(BOOL)config{
    self = [super init];
    if (self) {
        //default
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.isEditing = true;
        self.backgroundColor = [UIColor clearColor];
        self.widthHeight = XY(SCREEN_WIDTH, 0);
        self.collectionCellName = @"CollectionImageCell";
        //config
        if (config) {
            [self configView];
        }
    }
    return self;
}
- (void)configView{
    if (!self.height) {
        CGSize sizeCell = [self fetchCellSize];
        self.height = sizeCell.height;
    }
    [self addSubview:self.collectionView];
}

#pragma mark fetch cell size
- (CGSize)fetchCellSize{
    return [NSClassFromString(self.collectionCellName) fetchHeight];
}

#pragma mark 刷新view
- (void)resetWithAry:(NSMutableArray *)aryDatas{
    self.collectionView.width = self.width;
    self.collectionView.centerY = self.height/2.0;
    self.aryDatas = aryDatas;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.isEditing? self.aryDatas.count + 1:self.aryDatas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.collectionCellName forIndexPath:indexPath];
    if (self.isEditing && indexPath.row == 0) {
        [cell resetCellWithCamera];
        return cell;
    }
    [cell resetCellWithModel:self.aryDatas[self.isEditing?indexPath.row -1:indexPath.row]];
    return cell;
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self fetchCellSize];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isEditing && indexPath.item == 0) {
        [self showSelectImage];
    } else {
        ImageDetailBigView * detailView = [ImageDetailBigView new];
        WEAKSELF
        detailView.blockRefresh = ^(void){
            [weakSelf.collectionView reloadData];
            if (weakSelf.blockUpComplete != nil) {
                weakSelf.blockUpComplete();
            }
        };
 
        [detailView resetView:self.aryDatas isEdit:self.isEditing index: self.isEditing?indexPath.row-1:indexPath.row];
        CollectionImageCell * cell = (CollectionImageCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [detailView showInView:GB_Nav.lastVC.view imageViewShow:cell.ivImage];
    }
}
- (void)showSelectImage{
//    UpImageWithTextVC *vcImage = [self fetchTextImageVC];
//    [GB_Nav jumpToAry:@[vcImage,[vcImage fetchImageVC:NUM_IMAGE]]];
    [GB_Nav pushViewController:[(BaseVC *)GB_Nav.lastVC fetchImageVC:NUM_IMAGE] animated:true];
}
- (UpImageWithTextVC *)fetchTextImageVC{
    UpImageWithTextVC * vcImage = [UpImageWithTextVC new];
    vcImage.aryInit = self.aryDatas;
    WEAKSELF
    vcImage.blockSave = ^(NSArray *ary){
        weakSelf.aryDatas = [NSMutableArray arrayWithArray:ary];
        [weakSelf.collectionView reloadData];
        if (weakSelf.blockUpComplete) {
            weakSelf.blockUpComplete();
        }
    };
    return vcImage;
}
#pragma mark 获取请求数据
- (NSString *)fetchRequestImgString{
    return UnPackStr(self.aryDatas.imageRequestStr);
}

@end
