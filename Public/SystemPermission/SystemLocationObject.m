//
//  SystemLocationObject.m
//  SystemPermission
//
//  Created by wujian on 2018/6/14.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemLocationObject.h"
#import <CoreLocation/CLLocationManager.h>

@interface SystemLocationObject ()

@property (nonatomic, strong)   CLLocationManager *locationManager;
@end

@implementation SystemLocationObject

- (BOOL)locationServicesEnabled
{
    return [CLLocationManager locationServicesEnabled];
}

/** 获取当前定位权限对app的授权 **/
- (void)getSystemLocationAuth:(void (^)(LocationAuthStatus authStatus))authStatusBlock
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        authStatusBlock(LocationAuthStatusNotDetermined);
    }
    else if (status == kCLAuthorizationStatusDenied)
    {
        authStatusBlock(LocationAuthStatusDenied);
    }
    else if (status == kCLAuthorizationStatusRestricted)
    {
        authStatusBlock(LocationAuthStatusRestricted);
    }
    else if (status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        authStatusBlock(LocationAuthStatusAuthorizedWhenInUse);
    }
    else if (status == kCLAuthorizationStatusAuthorizedAlways)
    {
        authStatusBlock(LocationAuthStatusAuthorizedAlways);
    }
    else
    {
        authStatusBlock(LocationAuthStatusAuthorized);
    }
}

- (void)judgeSystemLocationPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    if ([self locationServicesEnabled] == NO) {
        failedHandle(SystemPermissionTypeDisable);
        return;
    }
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        // 未授权
        // Fallback on earlier versions
        [self.locationManager requestWhenInUseAuthorization];
    }
    else if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted)
    {   // 已拒绝
        [self handleUnPermissionsFailedHandel:failedHandle];
    }
    else if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways)
    {   // 已授权
        succeedHandler();
    }
    else
    {
        succeedHandler();
    }
}

#pragma mark - setter/getter
- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}
@end
