//
//  SystemLocationObject.h
//  SystemPermission
//
//  Created by wujian on 2018/6/14.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemPermissionObject.h"

@interface SystemLocationObject : SystemPermissionObject

/** 设备定位服务功能是否可用 **/
- (BOOL)locationServicesEnabled;

/** 获取当前定位权限对app的授权 **/
- (void)getSystemLocationAuth:(void (^)(LocationAuthStatus authStatus))authStatusBlock;

/** 定位权限 info.plist中 需要有NSLocationWhenInUseUsageDescription **/
- (void)judgeSystemLocationPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

@end
