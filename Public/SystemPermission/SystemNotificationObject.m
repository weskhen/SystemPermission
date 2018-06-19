//
//  SystemNotificationObject.m
//  SystemPermission
//
//  Created by wujian on 2018/6/14.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemNotificationObject.h"
#import <UIKit/UIKit.h>

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@implementation SystemNotificationObject
/*
 警告：Xcode8 需要手动开启"TARGETS -> Capabilities -> Push Notifications"
 警告：该方法需要开发者自定义，以下代码根据 APP 支持的 iOS 系统不同，代码可以对应修改。
 以下为演示代码，注意根据实际需要修改，注意测试支持的 iOS 系统都能获取到 DeviceToken
 */
- (void)registerNotificationSettings
{
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = (id<UNUserNotificationCenterDelegate>)[UIApplication sharedApplication].delegate;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (granted) {
                WHLog(@"request authorization succeeded!");
            }
        }];
    } else {
        // Fallback on earlier versions
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
}

- (void)registerForRemoteNotificationsAndSettings
{
    [self registerNotificationSettings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

- (void)getSystemNotificationAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock
{
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
                authStatusBlock(SystemAuthStatusNotDetermined);
            }
            else if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                authStatusBlock(SystemAuthStatusDenied);
            }
            else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                authStatusBlock(SystemAuthStatusAuthorized);
            }
        }];
    } else {
        // Fallback on earlier versions
        BOOL subsettingEnabled = [[UIApplication sharedApplication] currentUserNotificationSettings].types != UIUserNotificationTypeNone;
        if (subsettingEnabled) {
            authStatusBlock(SystemAuthStatusAuthorized);
        }
        else
        {
            authStatusBlock(SystemAuthStatusDenied);
        }
    }
}

- (void)judgeSystemNotificationPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    // 设置里的通知各子项是否都打开
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
                //未授权
                dispatch_async(dispatch_get_main_queue(), ^{
                    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//                    center.delegate = (id<UNUserNotificationCenterDelegate>)[UIApplication sharedApplication].delegate;
                    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
                        if (granted) {
                            succeedHandler();
                        }
                        else{
                            [self handleUnPermissionsFailedHandel:failedHandle];
                        }
                    }];
                });
            }
            else if (settings.authorizationStatus == UNAuthorizationStatusDenied)
            {   //拒绝
                [self handleUnPermissionsFailedHandel:failedHandle];
            }
            else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized)
            {   //已授权
                succeedHandler();
            }
        }];
    } else {
        // Fallback on earlier versions
        BOOL subsettingEnabled = [[UIApplication sharedApplication] currentUserNotificationSettings].types != UIUserNotificationTypeNone;
        if (subsettingEnabled) {
            succeedHandler();
        }
        else
        {
            [self handleUnPermissionsFailedHandel:failedHandle];
        }
    }
}

- (BOOL)remoteNotificationsGranted
{
    // 远程push
    BOOL pushEnabled = [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
    return pushEnabled;
}

- (void)jumpSystemAppSetting
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    });
}

@end
