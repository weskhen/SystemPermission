//
//  SystemBluetoothObject.m
//  SystemPermission
//
//  Created by wujian on 2018/6/14.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemBluetoothObject.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface SystemBluetoothObject ()

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;

@end

/** 蓝牙权限  CBCentralManager不能生成多个 iPhone有些手机 在使用多个CBCentralManager下 权限状态会有获取不准的情况 **/
@implementation SystemBluetoothObject

- (void)getSystemBluetoothPeripheralAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock
{
    CBPeripheralManagerAuthorizationStatus authStatus = [CBPeripheralManager authorizationStatus];
    if (authStatus == CBPeripheralManagerAuthorizationStatusNotDetermined)
    {   // 未授权
        authStatusBlock(SystemAuthStatusNotDetermined);
    }
    else if (authStatus == CBPeripheralManagerAuthorizationStatusDenied)
    {   // 已拒绝
        authStatusBlock(SystemAuthStatusDenied);
    }
    else if (authStatus == CBPeripheralManagerAuthorizationStatusRestricted)
    {   // 家长控制
        authStatusBlock(SystemAuthStatusRestricted);
    }
    else if (authStatus == CBPeripheralManagerAuthorizationStatusAuthorized)
    {   // 已授权
        authStatusBlock(SystemAuthStatusAuthorized);
    }
}

- (void)judgeSystemBluetoothPeripheralPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle notDetermined:(void (^)(void))notDeterminedHandler
{
    CBPeripheralManagerAuthorizationStatus authStatus = [CBPeripheralManager authorizationStatus];
    if (authStatus == CBPeripheralManagerAuthorizationStatusNotDetermined)
    {   // 未授权 触发弹框获取
        notDeterminedHandler();
    }
    else if (authStatus == CBPeripheralManagerAuthorizationStatusDenied || authStatus == CBPeripheralManagerAuthorizationStatusRestricted)
    {   // 已拒绝
        [self handleUnPermissionsFailedHandel:failedHandle];
    }
    else if (authStatus == CBPeripheralManagerAuthorizationStatusAuthorized)
    {   // 已授权
        succeedHandler();
    }
}

//#pragma mark - setter/getter
//- (CBCentralManager *)centralManager
//{
//    if (!_centralManager) {
//        // 创建中心设备管理器，会回调centralManagerDidUpdateState
//        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 //蓝牙power没打开时alert提示框 iOS11设置页里关闭才会弹
//                                 [NSNumber numberWithBool:YES],CBCentralManagerOptionShowPowerAlertKey, @"centralManagerIdentifier",CBCentralManagerOptionRestoreIdentifierKey,nil];
//        
//        NSArray *backgroundModes = [[[NSBundle mainBundle] infoDictionary]objectForKey:@"UIBackgroundModes"];
//        if ([backgroundModes containsObject:@"bluetooth-central"]) {
//            //info.plist 有声明蓝牙使用 后台模式
//            _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:options];
//        }
//        else {
//            //非后台模式
//            _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
//        }
//    }
//    return _centralManager;
//}
//
//- (CBPeripheralManager *)peripheralManager
//{
//    if (!_peripheralManager) {
//        // 创建中心设备管理器，会回调centralManagerDidUpdateState
//        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 //蓝牙power没打开时alert提示框 CBCentralManagerOptionRestoreIdentifierKeyiOS11设置页里关闭才会弹CBCentralManagerOptionShowPowerAlertKey
//                                 [NSNumber numberWithBool:YES],CBPeripheralManagerOptionShowPowerAlertKey,nil];
//
//        NSArray *backgroundModes = [[[NSBundle mainBundle] infoDictionary]objectForKey:@"UIBackgroundModes"];
//        if ([backgroundModes containsObject:@"bluetooth-peripheral"]) {
//            //info.plist 有声明蓝牙使用 后台模式
//            _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:options];
//        }
//        else {
//            //非后台模式
//            _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
//        }
//    }
//    return _peripheralManager;
//}
@end
