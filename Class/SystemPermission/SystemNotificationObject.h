//
//  SystemNotificationObject.h
//  SystemPermission
//
//  Created by wujian on 2018/6/14.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemPermissionObject.h"

@interface SystemNotificationObject : SystemPermissionObject

/** 注册系统通知 首次会弹出系统提示框 **/
- (void)registerNotificationSettings;

/** 注册系统通知和远程通知 首次会弹出系统提示框 远程通知 appDelegate有回调 didRegisterForRemoteNotificationsWithDeviceToken/didFailToRegisterForRemoteNotificationsWithError **/
- (void)registerForRemoteNotificationsAndSettings;

/** 获取当前通知权限对app的授权 iOS10一下UIUserNotificationTypeNone 认为未授权  **/
- (void)getSystemNotificationAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock;

/** 通知权限(ios10以下需要先注册通知再获取,否则为权限未开,so 先调用注册系统通知的方法) **/
- (void)judgeSystemNotificationPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

/** 远程通知是否已注册 **/
- (BOOL)remoteNotificationsGranted;

@end
