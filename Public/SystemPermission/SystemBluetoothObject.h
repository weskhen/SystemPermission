//
//  SystemBluetoothObject.h
//  SystemPermission
//
//  Created by wujian on 2018/6/14.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemPermissionObject.h"

@class CBCentralManager;

@interface SystemBluetoothObject : SystemPermissionObject

/** 获取当前蓝牙共享对app的授权 **/
- (void)getSystemBluetoothPeripheralAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock;

/** 蓝牙共享权限 **/
- (void)judgeSystemBluetoothPeripheralPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle notDetermined:(void (^)(void))notDeterminedHandler;


@end
