//
//  ImagePickerVC.m
//中车运
//
//  Created by 隋林栋 on 2017/4/6.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "ImagePickerVC.h"

//cell
#import "ImagePickerCollectionCell.h"
//下拉列表
#import "DownListViewBG.h"
//相册权限
#import <Photos/Photos.h>
//image edit vc
#import "UpImageWithTextVC.h"

@interface ImagePickerVC ()
@property (strong, nonatomic) NSMutableArray *groupArray;

@end

@implementation ImagePickerVC

#pragma mark lazy init
- (ImagePickerBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [ImagePickerBottomView initWithModel:nil];
        _bottomView.bottom = SCREEN_HEIGHT;
        [_bottomView.btnComplete addTarget:self action:@selector(okBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.btnSelectAlbum addTarget:self action:@selector(showSelectList) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}
- (ImagePikcerListBGVIew  *)viewListBG{
    if (!_viewListBG) {
        _viewListBG = [ImagePikcerListBGVIew new];
        WEAKSELF
        _viewListBG.blockSelect = ^(PHAssetCollection *group){
            [weakSelf getImageWithGroup:group];
        };
    }
    return _viewListBG;
}
- (NSMutableArray *)groupArray{
    if (!_groupArray) {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}
- (NSMutableArray *)selectAssetArray{
    if (!_selectAssetArray) {
        _selectAssetArray = [NSMutableArray array];
    }
    return _selectAssetArray;
}
- (NSMutableArray *)imageAssetAray{
    if (!_imageAssetAray) {
        _imageAssetAray = [NSMutableArray array];
    }
    return _imageAssetAray;
}
- (BaseNavView *)navView{
    if (!_navView) {
        _navView = [BaseNavView initNavBackTitle:@"" rightView:nil];
        _navView.blockBack = ^{
            //如果之前是详情 则返回两层
            NSMutableArray * ary = [NSMutableArray arrayWithArray:GB_Nav.viewControllers];
            if (ary.count>= 2) {
                UpImageWithTextVC * vc = [ary objectAtIndex:ary.count - 2];
                if ([NSStringFromClass(vc.class) isEqualToString:@"UpImageWithTextVC"] && !isAry(vc.aryDatas)) {
                    [GB_Nav popMultiVC:2];
                    return ;
                }
            }
            [GB_Nav popViewControllerAnimated:true];
        };
    }
    return _navView;
}
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //layout
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH / 3.0 - 1, SCREEN_WIDTH / 3.0 - 1 );
        //direction
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //collection
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT - self.bottomView.height) collectionViewLayout:layout];
        // backgroundColor
        _collectionView.backgroundColor = [UIColor clearColor];
        // delegate
        _collectionView.collectionViewLayout = layout;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = false;
        _collectionView.showsHorizontalScrollIndicator = false;
        
        [_collectionView registerClass:[ImagePickerCollectionCell class] forCellWithReuseIdentifier:@"ImagePickerCollectionCell"];
    }
    return _collectionView;
}
- (PHAssetMediaType)assetType{
    return PHAssetMediaTypeImage;
}
#pragma mark view appear
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    self.navigationController.navigationBarHidden = true;
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.collectionView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
    [self.view addSubview:self.bottomView];
    
    [self.view addSubview:self.navView];
    [self.view addSubview:self.viewListBG];
    
    WEAKSELF
    [GlobalMethod fetchPhotoAuthorityBlock:^{
        [weakSelf getAlbumList];
    }];
    
    
}

//获取相册列表
- (void)getAlbumList
{
    BOOL isFetchCamera = false;
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    //只要图片
    options.predicate =  [NSPredicate predicateWithFormat:@"mediaType = %d",self.assetType];
    // 按图片生成时间排序
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];

    // 所有智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in smartAlbums) {
        //遍历获取相册
        if (![collection isKindOfClass:[PHAssetCollection class]])continue;
        //过滤最近删除
        if (collection.assetCollectionSubtype >= 212) continue;
        //获取相册内asset result
        PHFetchResult<PHAsset *> *result = [PHAsset fetchAssetsInAssetCollection:collection options:options];
        if (!result.count) continue;
        if (collection.assetCollectionSubtype == 209) {
            isFetchCamera = true;
            [self getImageWithGroup:collection];
        }
        [self.groupArray addObject:collection];
    }
    if (!isFetchCamera) {
        [self getImageWithGroup:self.groupArray.firstObject];
    }
}

//根据相册获取下面的图片
- (void)getImageWithGroup:(PHAssetCollection *)assetCollection
{
    if (!assetCollection) return;
    //清空数据
    [self.bottomView.btnComplete setTitle:@"确定" forState:UIControlStateNormal];
    [self.selectAssetArray removeAllObjects];
    [self.imageAssetAray removeAllObjects];
    //更改navTitle
    NSString *name = UnPackStr(assetCollection.localizedTitle);
    [self.navView changeTitle:name];
    
    [GlobalMethod asynthicBlock:^{
        PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:^(){
            PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
            // 按图片生成时间排序
            allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"modificationDate" ascending:NO]];
            return allPhotosOptions;
        }()];
        if (fetchResult.count != 0) {
            for (NSInteger j = 0; j < fetchResult.count; j++) {
                //从相册中取出照片
                [self.imageAssetAray addObject:fetchResult[j]];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_collectionView reloadData];
        });
    }];
    
}

#pragma mark--UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageAssetAray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImagePickerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImagePickerCollectionCell" forIndexPath:indexPath];
    //selectBtnClick
    if (indexPath.row !=0)
    {
        //缩略图  aspectRatioThumbnail  thumbnail
        [cell resetCellWithImage:self.imageAssetAray[indexPath.row - 1] isSelected:[self.selectAssetArray containsObject:self.imageAssetAray[indexPath.row - 1]]];
        WEAKSELF
        cell.blockClick = ^(ImagePickerCollectionCell *cell){
            if (weakSelf.selectAssetArray.count >= weakSelf.photoNumber && !cell.rightButton.selected ) {
                if (weakSelf.photoNumber == 1) {
                    //如果一张 那就不停地替换
                    [weakSelf.selectAssetArray removeAllObjects];
                    [weakSelf.selectAssetArray addObject:weakSelf.imageAssetAray[indexPath.row - 1]];
                    [weakSelf resetBottomView];
                    [weakSelf.collectionView reloadData];
                    return ;
                }else {
                    [weakSelf showAlert];
                    return ;
                }
            }
            cell.rightButton.selected = !cell.rightButton.selected;
            NSIndexPath *indexPath = [weakSelf.collectionView indexPathForCell:cell];
            if (cell.rightButton.selected) {
                //加入
                [weakSelf.selectAssetArray addObject:weakSelf.imageAssetAray[indexPath.row - 1]];
            }else{
                [weakSelf.selectAssetArray removeObject:weakSelf.imageAssetAray[indexPath.row - 1]];
            }
            [weakSelf resetBottomView];
        };
    }
    else
    {
        [cell resetCellWithImage:nil isSelected:false];
        cell.iconImg.image = [UIImage imageNamed:@"ico_相机"];
        cell.rightButton.hidden = true;
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH / 3.0 - 1, SCREEN_WIDTH / 3.0 - 1 );
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"亲，您的设备不支持照相机功能" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
    }
}

- (void)showAlert
{
    NSString * str = [NSString stringWithFormat:@"最多只能选择%ld张图片",self.photoNumber];
    NSString * cancelButtonTitle = NSLocalizedString(@"我知道了", nil);
    NSString * destructiveButtonTitle = NSLocalizedString(str, nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //NSLog(@"取消");
    }];
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        
    }];
    [alertController addAction:destructiveAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)okBtnClick:(UIButton *)sender
{
    if (self.selectAssetArray.count > self.photoNumber) {
        [self showAlert];
    }else{
        NSMutableArray * aryVCs = [NSMutableArray arrayWithArray:GB_Nav.viewControllers];
        if (aryVCs.count>= 2) {
            UpImageWithTextVC * editVC = [aryVCs objectAtIndex:aryVCs.count - 2];
            if ([NSStringFromClass(editVC.class) isEqualToString:@"UpImageWithTextVC"] && !isAry(editVC.aryDatas) && !isAry(self.selectAssetArray)) {
                [GB_Nav popMultiVC:2];
                return ;
            }
        }
        if ([_delegate respondsToSelector:@selector(ImagePickerVC:finishClick:)])
        {
            [_delegate ImagePickerVC:self finishClick:self.selectAssetArray];
        }
        [GB_Nav popViewControllerAnimated:true];
    }
}

- (void)showSelectList{
    [self.viewListBG resetViewWithAry:self.groupArray height:SCREEN_HEIGHT - self.bottomView.height];
    [self.viewListBG showAnimation];
}

#pragma mark resetBottomView
- (void)resetBottomView{
    if (self.selectAssetArray.count == 0)
    {
        [self.bottomView.btnComplete setTitle:@"确定" forState:UIControlStateNormal];
    }
    else
    {
        [self.bottomView.btnComplete setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)[self.selectAssetArray count]] forState:UIControlStateNormal];
    }
    
}
#pragma mark--UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        if ([_delegate respondsToSelector:@selector(ImagePickerVC:firstImageClick:)])
        {
            [_delegate ImagePickerVC:self firstImageClick: info[picker.allowsEditing?UIImagePickerControllerEditedImage:UIImagePickerControllerOriginalImage]];
        }
    }];
}

#pragma mark status bar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
@end



