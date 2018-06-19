//
//  SystemAlbumObject.m
//  SystemPermission
//
//  Created by wujian on 2018/6/14.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemAlbumObject.h"
#import <Photos/Photos.h>

@implementation SystemAlbumObject

- (void)getSystemAlbumAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied)
    {
        authStatusBlock(SystemAuthStatusDenied);
    }
    else if (status == PHAuthorizationStatusRestricted)
    {
        authStatusBlock(SystemAuthStatusRestricted);
    }
    else if (status == PHAuthorizationStatusAuthorized)
    {
        authStatusBlock(SystemAuthStatusAuthorized);
    }
    else if (status == PHAuthorizationStatusNotDetermined)
    {
        authStatusBlock(SystemAuthStatusNotDetermined);
    }
}

- (void)judgeSystemAlbumPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
    {   // 已拒绝
        [self handleUnPermissionsFailedHandel:failedHandle];
    }
    else if (status == PHAuthorizationStatusAuthorized)
    {   // 已授权
        succeedHandler();
    }
    else if (status == PHAuthorizationStatusNotDetermined)
    {   // 未授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized)
            {
                succeedHandler();
            }
            else
            {
                [self handleUnPermissionsFailedHandel:failedHandle];
            }
        }];
    }
}

@end
