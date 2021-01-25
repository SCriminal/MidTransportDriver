#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

#import <MapKit/MKMapItem.h>//用于苹果自带地图

#import <MapKit/MKTypes.h>//用于苹果自带地图
#import "ThirdMap.h"

@implementation ThirdMap
/**
 
 *跳转到已经安装的地图
 
 *@param coord        目标位置
 
 *@param currentCoord 当前位置
 
 *@return sheetAction
 
 */




+ (UIAlertController  *)getInstalledMapAppWithEndLocation:(CLLocationCoordinate2D)coord currentLocation:(CLLocationCoordinate2D)currentCoord{
    
    //    调用地图
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:@"前往导航" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //百度地图
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]) {
        
        UIAlertAction *baiduMapAction = [UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSString *baiduParameterFormat = @"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:终点&mode=driving";
            
            NSString *urlString = [[NSString stringWithFormat:
                                    
                                    baiduParameterFormat,
                                    
                                    currentCoord.latitude,//用户当前的位置
                                    
                                    currentCoord.longitude,//用户当前的位置
                                    
                                    coord.latitude,
                                    
                                    coord.longitude]
                                   
                                   stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [actionSheet addAction:baiduMapAction];
        
    }
    
    //高德地图
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://map/"]]) {
        
        UIAlertAction *gaodeMapAction = [UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSString *gaodeParameterFormat = @"iosamap://navi?sourceApplication=%@&backScheme=%@&poiname=%@&lat=%f&lon=%f&dev=1&style=2";
            NSString *urlString = [[NSString stringWithFormat:
                                    
                                    gaodeParameterFormat,
                                    
                                    [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"],
                                    
                                    @"hjfNeighbor",
                                    
                                    @"终点",
                                    
                                    coord.latitude,
                                    
                                    coord.longitude]
                                   
                                   stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [actionSheet addAction:gaodeMapAction];
        
    }
    
    //苹果地图
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"苹果地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //起点
        
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        
        CLLocationCoordinate2D desCorrdinate = CLLocationCoordinate2DMake(coord.latitude, coord.longitude);
        
        //终点
        
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:desCorrdinate addressDictionary:nil]];
        
        //默认驾车
        
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
         
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                       
                                       MKLaunchOptionsMapTypeKey:[NSNumber numberWithInteger:MKMapTypeStandard],
                                       
                                       MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
        
    }]];
    
    //腾讯地图
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://map/"]]) {
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"腾讯地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSString *QQParameterFormat = @"qqmap://map/routeplan?type=drive&fromcoord=%f, %f&tocoord=%f,%f&coord_type=1&policy=0&refer=%@";
            
            NSString *urlString = [[NSString stringWithFormat:
                                    
                                    QQParameterFormat,
                                    
                                    currentCoord.latitude,//用户当前的位置
                                    
                                    currentCoord.longitude,//用户当前的位置
                                    
                                    coord.latitude,
                                    
                                    coord.longitude,
                                    
                                    [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]]
                                   
                                   stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }]];
        
    }
    
    //谷歌地图
    
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://map/"]]) {
//
//        [actionSheet addAction:[UIAlertAction actionWithTitle:@"谷歌地图"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//            NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",
//
//                                    [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"],
//
//                                    @"hjfNeighbor",
//
//                                    coord.latitude,
//
//                                    coord.longitude]
//
//                                   stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//
//        }]];
//
//    }
    
    //取消按钮
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [actionSheet dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [actionSheet addAction:action3];
    
    return actionSheet;
    
}

@end
