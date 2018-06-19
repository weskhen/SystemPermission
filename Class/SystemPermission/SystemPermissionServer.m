//
//  SystemPermissionServer.m
//  SystemPermission
//
//  Created by wujian on 2018/6/13.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemPermissionServer.h"
#import <UIKit/UIKit.h>
#import "SystemNotificationObject.h"
#import "SystemAlbumObject.h"
#import "SystemCameraObject.h"
#import "SystemRecordObject.h"
#import "SystemLocationObject.h"
#import "SystemAddressBookObject.h"
#import "SystemBluetoothObject.h"
#import "SystemCalendarObject.h"
#import "SystemSirObject.h"
#import "SystemSpeechObject.h"
#import "SystemApplePayObject.h"
#import "SystemTouchIDObject.h"
#import "SystemMediaPlayerObject.h"
#import "SystemHealthObject.h"
#import "SystemNetworkObject.h"

@interface SystemPermissionServer  ()

@property (nonatomic, strong)   SystemNotificationObject *notificationObj;
@property (nonatomic, strong)   SystemAlbumObject *albumObj;
@property (nonatomic, strong)   SystemCameraObject *cameraObj;
@property (nonatomic, strong)   SystemRecordObject *recordObj;
@property (nonatomic, strong)   SystemLocationObject *locationObj;
@property (nonatomic, strong)   SystemAddressBookObject *addressBookObj;
@property (nonatomic, strong)   SystemBluetoothObject *bluetoothObj;
@property (nonatomic, strong)   SystemCalendarObject *calendarObj;
@property (nonatomic, strong)   SystemSirObject *sirObj;
@property (nonatomic, strong)   SystemSpeechObject *speechObj;
@property (nonatomic, strong)   SystemApplePayObject *applePayObj;
@property (nonatomic, strong)   SystemTouchIDObject *touchIDObj;
@property (nonatomic, strong)   SystemMediaPlayerObject *mediaPlayerObj;
@property (nonatomic, strong)   SystemHealthObject *healthObj;
@property (nonatomic, strong)   SystemNetworkObject *networkObj;


@end

@implementation SystemPermissionServer

+ (instancetype)sharedInstance {
    static SystemPermissionServer *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)currentSystemAlbumAuthStatus:(SystemAuthStatusBlock)authStatusBlock
{
    [self.albumObj getSystemAlbumAuth:authStatusBlock];
}

- (void)judgeSystemAlbumPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    [self.albumObj judgeSystemAlbumPermissionsSuccess:succeedHandler withFailedHandel:failedHandle];
}

- (void)currentSystemCameraAuthStatus:(SystemAuthStatusBlock)authStatusBlock
{
    [self.cameraObj getSystemCameraAuth:authStatusBlock];
}

- (void)judgeSystemCameraPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    [self.cameraObj judgeSystemCameraPermissionsSuccess:succeedHandler withFailedHandel:failedHandle];
}

- (void)currentSystemRecordAuthStatus:(SystemAuthStatusBlock)authStatusBlock
{
    [self.recordObj getSystemRecordAuth:authStatusBlock];
}

- (void)judgeSystemRecordPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    [self.recordObj judgeSystemRecordPermissionsSuccess:succeedHandler withFailedHandel:failedHandle];
}

- (void)currentSystemLocationAuthStatus:(LocationAuthStatusBlock)authStatusBlock
{
    [self.locationObj getSystemLocationAuth:authStatusBlock];
}

- (void)judgeSystemLocationPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    [self.locationObj judgeSystemLocationPermissionsSuccess:succeedHandler withFailedHandel:failedHandle];
}

- (void)currentSystemAddressBookAuthStatus:(SystemAuthStatusBlock)authStatusBlock
{
    [self.addressBookObj getSystemAddressBookAuth:authStatusBlock];
}

- (void)judgeSystemAddressBookPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    [self.addressBookObj judgeSystemAddressBookPermissionsSuccess:succeedHandler withFailedHandel:failedHandle];
}

- (void)currentSystemBluetoothPeripheralAuthStatus:(SystemAuthStatusBlock)authStatusBlock
{
    [self.bluetoothObj getSystemBluetoothPeripheralAuth:authStatusBlock];
}

- (void)judgeSystemBluetoothPeripheralPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle notDetermined:(void (^)(void))notDeterminedHandler
{
    [self.bluetoothObj judgeSystemBluetoothPeripheralPermissionsSuccess:succeedHandler withFailedHandel:failedHandle notDetermined:notDeterminedHandler];
}

- (void)jumpToBluetoothPage
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:(IS_IOS10_OR_HIGHER?@"App-Prefs:root=Bluetooth":@"prefs:root=Bluetooth")]];
}

- (void)registerNotificationSettings
{
    [self.notificationObj registerNotificationSettings];
}

- (void)registerForRemoteNotificationsAndSettings
{
    [self.notificationObj registerForRemoteNotificationsAndSettings];
}

- (void)currentSystemNotificationAuthStatus:(SystemAuthStatusBlock)authStatusBlock
{
    [self.notificationObj getSystemNotificationAuth:authStatusBlock];
}

- (void)judgeSystemNotificationPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    [self.notificationObj judgeSystemNotificationPermissionsSuccess:succeedHandler withFailedHandel:failedHandle];
}

- (BOOL)remoteNotificationsGranted
{
   return [self.notificationObj remoteNotificationsGranted];
}

- (void)currentSystemCalendarAuthStatus:(SystemAuthStatusBlock)authStatusBlock
{
    [self.calendarObj getSystemCalendarAuth:authStatusBlock];
}

- (void)judgeSystemCalendarPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType))failedHandle
{
    [self.calendarObj judgeSystemCalendarPermissionsSuccess:succeedHandler withFailedHandel:failedHandle];
}

- (void)currentSystemSirAuthStatus:(SystemAuthStatusBlock)authStatusBlock
{
    [self.sirObj getSystemSirAuth:authStatusBlock];
}

- (void)judgeSystemSirPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    [self.sirObj judgeSystemSirPermissionsSuccess:succeedHandler withFailedHandel:failedHandle];
}

- (void)currentSystemSpeechAuthStatus:(SystemAuthStatusBlock)authStatusBlock
{
    [self.speechObj getSystemSpeechAuth:authStatusBlock];
}

- (void)judgeSystemSpeechPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    [self.speechObj judgeSystemSpeechPermissionsSuccess:succeedHandler withFailedHandel:failedHandle];
}

- (void)currentSystemApplePayStatus:(ApplePayStatusBlock)statusBlock
{
    [self.applePayObj getSystemApplePayStatus:statusBlock];
}

- (void)currentSystemTouchIDStatus:(SystemTouchIDStatusBlock)touchIDStatusBlock
{
    [self.touchIDObj getSystemTouchIDAuth:touchIDStatusBlock];
}

- (void)currentSystemMediaPlayerAuthStatus:(SystemAuthStatusBlock)authStatusBlock
{
    [self.mediaPlayerObj getSystemMediaPlayerAuth:authStatusBlock];
}

- (void)judgeSystemMediaPlayerPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    [self.mediaPlayerObj judgeSystemMediaPlayerPermissionsSuccess:succeedHandler withFailedHandel:failedHandle];
}

- (BOOL)isSupportHealthData
{
    return [self.healthObj isSupportHealthData];
}

- (void)currentSystemHealthAuthStatus:(void (^)(SystemAuthStatus authStatus))authStatusBlock quantityTypeIdentifier:(HKQuantityTypeIdentifier)identifier
{
    [self.healthObj getSystemHealthAuth:authStatusBlock quantityTypeIdentifier:identifier];
}

- (void)currentSystemNetworkAuthStatus:(void (^)(SystemAuthStatus authStatus))authStatusBlock
{
    [self.networkObj getSystemCellularDataAuth:authStatusBlock];
}

- (void)jumpSystemAppSetting
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    });
}

#pragma mark - privateMethod
- (void)handleUnPermissionsFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
            failedHandle (true);
        }
        else {
            failedHandle (false);
        }
    });
}

#pragma mark - setter/getter
- (SystemAlbumObject *)albumObj
{
    if (!_albumObj) {
        _albumObj = [SystemAlbumObject new];
    }
    return _albumObj;
}

- (SystemCameraObject *)cameraObj
{
    if (!_cameraObj) {
        _cameraObj = [SystemCameraObject new];
    }
    return _cameraObj;
}

- (SystemRecordObject *)recordObj
{
    if (!_recordObj) {
        _recordObj = [SystemRecordObject new];
    }
    return _recordObj;
}

- (SystemLocationObject *)locationObj
{
    if (!_locationObj) {
        _locationObj = [SystemLocationObject new];
    }
    return _locationObj;
}

- (SystemAddressBookObject *)addressBookObj
{
    if (!_addressBookObj) {
        _addressBookObj = [SystemAddressBookObject new];
    }
    return _addressBookObj;
}

- (SystemNotificationObject *)notificationObj
{
    if (!_notificationObj) {
        _notificationObj = [SystemNotificationObject new];
    }
    return _notificationObj;
}

- (SystemBluetoothObject *)bluetoothObj
{
    if (!_bluetoothObj) {
        _bluetoothObj = [SystemBluetoothObject new];
    }
    return _bluetoothObj;
}

- (SystemCalendarObject *)calendarObj
{
    if (!_calendarObj) {
        _calendarObj = [SystemCalendarObject new];
    }
    return _calendarObj;
}

- (SystemSirObject *)sirObj
{
    if (!_sirObj) {
        _sirObj = [SystemSirObject new];
    }
    return _sirObj;
}
- (SystemSpeechObject *)speechObj
{
    if (!_speechObj) {
        _speechObj = [SystemSpeechObject new];
    }
    return _speechObj;
}

- (SystemApplePayObject *)applePayObj
{
    if (!_applePayObj) {
        _applePayObj = [SystemApplePayObject new];
    }
    return _applePayObj;
}

- (SystemTouchIDObject *)touchIDObj
{
    if (!_touchIDObj) {
        _touchIDObj = [SystemTouchIDObject new];
    }
    return _touchIDObj;
}

- (SystemMediaPlayerObject *)mediaPlayerObj
{
    if (!_mediaPlayerObj) {
        _mediaPlayerObj = [SystemMediaPlayerObject new];
    }
    return _mediaPlayerObj;
}

- (SystemHealthObject *)healthObj
{
    if (!_healthObj) {
        _healthObj = [SystemHealthObject new];
    }
    return _healthObj;
}

- (SystemNetworkObject *)networkObj
{
    if (!_networkObj) {
        _networkObj = [SystemNetworkObject new];
    }
    return _networkObj;
}
@end
