//
//  SystemSirObject.m
//  SystemPermission
//
//  Created by wujian on 2018/6/15.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemSirObject.h"
#import <Intents/Intents.h>

@implementation SystemSirObject

- (void)getSystemSirAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock
{
    if (@available(iOS 10.0, *)) {
        INSiriAuthorizationStatus siriAutoStatus = [INPreferences siriAuthorizationStatus];
        if (siriAutoStatus == INSiriAuthorizationStatusNotDetermined) {
            authStatusBlock(SystemAuthStatusNotDetermined);
        }
        else if (siriAutoStatus == INSiriAuthorizationStatusAuthorized)
        {
            authStatusBlock(SystemAuthStatusAuthorized);
        }
        else if (siriAutoStatus == INSiriAuthorizationStatusDenied)
        {
            authStatusBlock(SystemAuthStatusDenied);
        }
        else if (siriAutoStatus == INSiriAuthorizationStatusRestricted)
        {
            authStatusBlock(SystemAuthStatusRestricted);
        }
        
    } else {
        // Fallback on earlier versions
        authStatusBlock(SystemAuthStatusNotSupport);
    }
}

- (void)judgeSystemSirPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    if (@available(iOS 10.0, *)) {
        //Did you enable the Siri capability in your Xcode project? first
        INSiriAuthorizationStatus siriAutoStatus = [INPreferences siriAuthorizationStatus];
        if (siriAutoStatus == INSiriAuthorizationStatusNotDetermined) {
            //未授权
            [INPreferences requestSiriAuthorization:^(INSiriAuthorizationStatus status) {
                if (status == INSiriAuthorizationStatusAuthorized) {
                    succeedHandler();
                }
                else
                {
                    [self handleUnPermissionsFailedHandel:failedHandle];
                }
            }];
        }
        else if (siriAutoStatus == INSiriAuthorizationStatusAuthorized)
        {   // 已授权
            succeedHandler();
        }
        else if (siriAutoStatus == INSiriAuthorizationStatusDenied || siriAutoStatus == INSiriAuthorizationStatusRestricted)
        {   // 已拒绝
            [self handleUnPermissionsFailedHandel:failedHandle];
        }
            
    } else {
        // Fallback on earlier versions
        failedHandle(SystemPermissionTypeDisable);
    }

}

@end
