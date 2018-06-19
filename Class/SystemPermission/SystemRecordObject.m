//
//  SystemRecordObject.m
//  SystemPermission
//
//  Created by wujian on 2018/6/14.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemRecordObject.h"
#import <AVFoundation/AVFoundation.h>

@implementation SystemRecordObject

- (void)getSystemRecordAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock
{
    AVAudioSessionRecordPermission recordPermission = [AVAudioSession sharedInstance].recordPermission;
    if (recordPermission == AVAudioSessionRecordPermissionUndetermined) {
        // 未授权
        authStatusBlock(SystemAuthStatusNotDetermined);
    }
    else if (recordPermission == AVAudioSessionRecordPermissionDenied)
    {   // 已拒绝
        authStatusBlock(SystemAuthStatusDenied);
    }
    else if (recordPermission == AVAudioSessionRecordPermissionGranted)
    {   // 已授权
        authStatusBlock(SystemAuthStatusAuthorized);
    }
}

- (void)judgeSystemRecordPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    AVAudioSessionRecordPermission recordPermission = [AVAudioSession sharedInstance].recordPermission;
    if (recordPermission == AVAudioSessionRecordPermissionUndetermined) {
        // 未授权
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            if (granted) {
                succeedHandler();
            }
            else {
                [self handleUnPermissionsFailedHandel:failedHandle];
            }
        }];
    }
    else if (recordPermission == AVAudioSessionRecordPermissionDenied)
    {   // 已拒绝
        [self handleUnPermissionsFailedHandel:failedHandle];
    }
    else if (recordPermission == AVAudioSessionRecordPermissionGranted)
    {   // 已授权
        succeedHandler();
    }
}
@end
