//
//  SystemMediaPlayerObject.m
//  SystemPermission
//
//  Created by wujian on 2018/6/15.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemMediaPlayerObject.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation SystemMediaPlayerObject

- (void)getSystemMediaPlayerAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock
{
    if (@available(iOS 9.3, *)) {
        MPMediaLibraryAuthorizationStatus authStatus = [MPMediaLibrary authorizationStatus];
        if (authStatus == MPMediaLibraryAuthorizationStatusNotDetermined) {
            authStatusBlock(SystemAuthStatusNotDetermined);
        }
        else if (authStatus == MPMediaLibraryAuthorizationStatusAuthorized)
        {
            authStatusBlock(SystemAuthStatusAuthorized);
        }
        else if (authStatus == MPMediaLibraryAuthorizationStatusDenied)
        {
            authStatusBlock(SystemAuthStatusDenied);
        }
        else if (authStatus == MPMediaLibraryAuthorizationStatusRestricted)
        {
            authStatusBlock(SystemAuthStatusRestricted);
        }
    } else {
        // Fallback on earlier versions
        authStatusBlock(SystemAuthStatusNotSupport);
    }
}

- (void)judgeSystemMediaPlayerPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    if (@available(iOS 9.3, *)) {
        MPMediaLibraryAuthorizationStatus authStatus = [MPMediaLibrary authorizationStatus];
        if (authStatus == MPMediaLibraryAuthorizationStatusNotDetermined) {
            [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
                if (status == MPMediaLibraryAuthorizationStatusAuthorized) {
                    succeedHandler();
                }
                else{
                    [self handleUnPermissionsFailedHandel:failedHandle];
                }
            }];
        }
        else if (authStatus == MPMediaLibraryAuthorizationStatusAuthorized)
        {
            succeedHandler();
        }
        else if (authStatus == MPMediaLibraryAuthorizationStatusDenied || authStatus == MPMediaLibraryAuthorizationStatusRestricted)
        {
            [self handleUnPermissionsFailedHandel:failedHandle];
        }
    } else {
        // Fallback on earlier versions
        failedHandle(SystemPermissionTypeDisable);
    }
}

@end
