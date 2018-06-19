//
//  SystemPermissionServer.h
//  SystemPermission
//
//  Created by wujian on 2018/6/13.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SystemPermissionObject.h"
#import <HealthKit/HKTypeIdentifiers.h>

#define SystemPermission [SystemPermissionServer sharedInstance]

typedef void(^SystemAuthStatusBlock)(SystemAuthStatus authStatus);
typedef void(^ApplePayStatusBlock)(SystemApplePayStatus status);
typedef void(^LocationAuthStatusBlock)(LocationAuthStatus authStatus);
typedef void(^SystemTouchIDStatusBlock)(SystemTouchIDStatus touchIDStatus);

/** ios8 以上方法 **/
@interface SystemPermissionServer : NSObject

+ (instancetype)sharedInstance;

#pragma mark - 相册权限
/** 获取当前相册权限对app的授权 **/
- (void)currentSystemAlbumAuthStatus:(SystemAuthStatusBlock)authStatusBlock;
/** 相册权限 **/
- (void)judgeSystemAlbumPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

#pragma mark - 相机权限
/** 获取当前相机权限对app的授权 **/
- (void)currentSystemCameraAuthStatus:(SystemAuthStatusBlock)authStatusBlock;
/** 相机权限 **/
- (void)judgeSystemCameraPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

#pragma mark - 录音权限
/** 获取当前录音权限对app的授权 无SystemAuthStatusRestricted **/
- (void)currentSystemRecordAuthStatus:(SystemAuthStatusBlock)authStatusBlock;
/** 录音权限 **/
- (void)judgeSystemRecordPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

#pragma mark - 定位权限
/** 获取当前定位权限对app的授权 **/
- (void)currentSystemLocationAuthStatus:(LocationAuthStatusBlock)authStatusBlock;
/** 定位权限 **/
- (void)judgeSystemLocationPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

#pragma mark - 通讯录权限
/** 获取当前通讯录对app的授权 **/
- (void)currentSystemAddressBookAuthStatus:(SystemAuthStatusBlock)authStatusBlock;
/** 通讯录权限 **/
- (void)judgeSystemAddressBookPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

#pragma mark - 蓝牙共享权限
/** 获取当前蓝牙共享对app的授权 **/
- (void)currentSystemBluetoothPeripheralAuthStatus:(SystemAuthStatusBlock)authStatusBlock;
/** 蓝牙共享权限 **/
- (void)judgeSystemBluetoothPeripheralPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle notDetermined:(void (^)(void))notDeterminedHandler;

/** 跳转到蓝牙设置 **/
- (void)jumpToBluetoothPage;

#pragma mark - push通知权限
/** 注册系统通知 首次会弹出系统提示框 **/
- (void)registerNotificationSettings;
/** 注册系统通知和远程通知 首次会弹出系统提示框 远程通知 appDelegate有回调 didRegisterForRemoteNotificationsWithDeviceToken/didFailToRegisterForRemoteNotificationsWithError **/
- (void)registerForRemoteNotificationsAndSettings;

/** 获取当前通知权限对app的授权 iOS10一下UIUserNotificationTypeNone 认为未授权  **/
- (void)currentSystemNotificationAuthStatus:(SystemAuthStatusBlock)authStatusBlock;
/** 通知权限(ios10以下需要先注册通知再获取,否则为权限未开,so 先调用注册系统通知的方法) **/
- (void)judgeSystemNotificationPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;
/** 远程通知是否已注册 **/
- (BOOL)remoteNotificationsGranted;

#pragma mark - 日历/备忘录
/** 获取当前日历/备忘录权限对app的授权**/
- (void)currentSystemCalendarAuthStatus:(SystemAuthStatusBlock)authStatusBlock;

/** 日历/备忘录权限 info.plist中 **/
- (void)judgeSystemCalendarPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

#pragma mark - Sir
/** 获取当前Sir权限对app的授权 iOS10才开放Sir权限**/
- (void)currentSystemSirAuthStatus:(SystemAuthStatusBlock)authStatusBlock;

/** Sir权限 info.plist中 iOS10才开放Sir权限**/
- (void)judgeSystemSirPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

#pragma mark - 语音识别
/** 获取当前语音识别权限对app的授权**/
- (void)currentSystemSpeechAuthStatus:(SystemAuthStatusBlock)authStatusBlock;

/** 语音识别权限 info.plist中 **/
- (void)judgeSystemSpeechPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

#pragma mark - Apple Pay
/** 获取当前Apple Pay权限对app的授权**/
- (void)currentSystemApplePayStatus:(ApplePayStatusBlock)statusBlock;

#pragma mark - Touch ID
/** 获取当前Touch ID权限对app的授权**/
- (void)currentSystemTouchIDStatus:(SystemTouchIDStatusBlock)touchIDStatusBlock;

#pragma mark - 媒体资料库
/** 获取当前媒体资料库权限对app的授权 info.plist中 NSAppleMusicUsageDescription**/
- (void)currentSystemMediaPlayerAuthStatus:(SystemAuthStatusBlock)authStatusBlock;
/** 媒体资料库权限 info.plist中 NSAppleMusicUsageDescription **/
- (void)judgeSystemMediaPlayerPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

#pragma mark - 健康
/** 设备是否支持健康权限 **/
- (BOOL)isSupportHealthData;
/** 获取当前健康权限对app的授权 **/
- (void)currentSystemHealthAuthStatus:(void (^)(SystemAuthStatus authStatus))authStatusBlock quantityTypeIdentifier:(HKQuantityTypeIdentifier)identifier;

#pragma mark - 国产手机网络权限获取
- (void)currentSystemNetworkAuthStatus:(void (^)(SystemAuthStatus authStatus))authStatusBlock;

#pragma mark - Common
/** 跳转到app设置页 **/
- (void)jumpSystemAppSetting;
@end
