//
//  SystemPermissionObject.m
//  SystemPermission
//
//  Created by wujian on 2018/6/14.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemPermissionObject.h"
#import <UIKit/UIKit.h>

@implementation SystemPermissionObject

#pragma mark - privateMethod
- (void)handleUnPermissionsFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
            failedHandle(SystemPermissionTypeFailedSetting);
        }
        else {
            failedHandle(SystemPermissionTypeFailedThorough);
        }
    });
}

- (void)handleUnBluetoothFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *urlString = IS_IOS10_OR_HIGHER?@"App-Prefs:root=Bluetooth":@"prefs:root=Bluetooth";
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
            failedHandle(SystemPermissionTypeFailedSetting);
        }
        else {
            failedHandle(SystemPermissionTypeFailedThorough);
        }
    });
}

@end
