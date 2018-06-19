//
//  SystemCameraObject.m
//  SystemPermission
//
//  Created by wujian on 2018/6/14.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemCameraObject.h"
#import <AVFoundation/AVFoundation.h>

@implementation SystemCameraObject

- (void)getSystemCameraAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        authStatusBlock(SystemAuthStatusDenied);
    }
    else if (authStatus == AVAuthorizationStatusRestricted)
    {
        authStatusBlock(SystemAuthStatusRestricted);
    }
    else if(authStatus == AVAuthorizationStatusAuthorized)
    {
        authStatusBlock(SystemAuthStatusAuthorized);
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined){
        authStatusBlock(SystemAuthStatusNotDetermined);
    }
}

- (void)judgeSystemCameraPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted) {
        // 已拒绝
        [self handleUnPermissionsFailedHandel:failedHandle];
    }
    else if(authStatus == AVAuthorizationStatusAuthorized)
    {   // 已授权
        succeedHandler();
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined){
        // 未授权
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                succeedHandler();
            }
            else {
                [self handleUnPermissionsFailedHandel:failedHandle];
            }
        }];
    }
    
}

@end
