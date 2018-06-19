//
//  SystemPermissionObject.h
//  SystemPermission
//
//  Created by wujian on 2018/6/14.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IS_IOS8_OR_HIGHER      (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
#define IS_IOS9_OR_HIGHER      (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
#define IS_IOS10_OR_HIGHER      (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0"))

//weakSelf 宏定义
#define WEAKSELF    __weak __typeof(&*self)weakSelf = self;
#define STRONGSELF  __strong __typeof(weakSelf) strongSelf = weakSelf;

// log
#ifdef DEBUG
# define WHLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define WHLog(...)
#endif

typedef NS_ENUM(NSUInteger,SystemPermissionType) {
    /** 系统没这项功能/硬件等不支持 **/
    SystemPermissionTypeDisable = 0,
    /** 没权限且不能进设置页 **/
    SystemPermissionTypeFailedThorough,
    /** 没权限可进设置页 **/
    SystemPermissionTypeFailedSetting,
};

typedef NS_ENUM(NSUInteger,SystemAuthStatus) {
    /** 未获取授权 **/
    SystemAuthStatusNotDetermined = 0,
    /** 拒绝 **/
    SystemAuthStatusDenied,
    /** 权限受限或家长控制 **/
    SystemAuthStatusRestricted,
    /** 已授权 **/
    SystemAuthStatusAuthorized,
    /** 硬件等不支持 **/
    SystemAuthStatusNotSupport,
};

typedef NS_ENUM(NSUInteger, LocationAuthStatus){
    /** 未获取授权 **/
    LocationAuthStatusNotDetermined = 0,
    /** 拒绝 **/
    LocationAuthStatusDenied,
    /** 家长控制 **/
    LocationAuthStatusRestricted,
    /** 已授权 **/
    LocationAuthStatusAuthorized,
    /** 硬件等不支持 **/
    LocationAuthStatusNotSupport,
    /** 一直允许获取定位 **/
    LocationAuthStatusAuthorizedAlways,
    /** 在使用时允许获取定位 **/
    LocationAuthStatusAuthorizedWhenInUse,
};

// ECCBManagerState 蓝牙状态，参考 CBManagerState
typedef NS_ENUM(NSUInteger, WHCBManagerStatus){
    /** 未知状态 **/
    WHCBManagerStatusUnknown = 0,
    /** 正在重置，与系统服务暂时丢失 **/
    WHCBManagerStatusResetting,
    /** 不支持 **/
    WHCBManagerStatusUnsupported,
    /** 未授权 **/
    WHCBManagerStatusUnauthorized,
    /** 蓝牙关闭 **/
    WHCBManagerStatusPoweredOff,
    /** 蓝牙可用 **/
    WHCBManagerStatusPoweredOn,
};

typedef enum : NSUInteger {
    /** 不支持 **/
    SystemApplePayStatusNotSupport = 0,
    /** 没有卡 **/
    SystemApplePayStatusNoCard,
    /** 能被使用 **/
    SystemApplePayStatusCanPay,
} SystemApplePayStatus;

typedef NS_ENUM(NSUInteger,SystemTouchIDStatus) {
    /** 系统没这项功能/硬件等不支持 **/
    SystemTouchIDStatusDisable = 0,
    /** TouchID可用 **/
    SystemTouchIDStatusVisable,
};

@interface SystemPermissionObject : NSObject

- (void)handleUnPermissionsFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

- (void)handleUnBluetoothFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;


@end
