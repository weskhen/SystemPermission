//
//  SystemSpeechObject.m
//  SystemPermission
//
//  Created by wujian on 2018/6/15.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemSpeechObject.h"
#import <Speech/Speech.h>

@implementation SystemSpeechObject

- (void)getSystemSpeechAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock
{
    if (@available(iOS 10.0, *)) {
        SFSpeechRecognizerAuthorizationStatus authStatus = [SFSpeechRecognizer authorizationStatus];
        if (authStatus == SFSpeechRecognizerAuthorizationStatusNotDetermined) {
            authStatusBlock(SystemAuthStatusNotDetermined);
        } else if (authStatus == SFSpeechRecognizerAuthorizationStatusAuthorized) {
            authStatusBlock(SystemAuthStatusAuthorized);
        }
        else if (authStatus == SFSpeechRecognizerAuthorizationStatusDenied)
        {
            authStatusBlock(SystemAuthStatusDenied);
        }
        else if (authStatus == SFSpeechRecognizerAuthorizationStatusRestricted)
        {
            authStatusBlock(SystemAuthStatusRestricted);
        }
    } else {
        // Fallback on earlier versions
        authStatusBlock(SystemAuthStatusNotSupport);
    }

}

- (void)judgeSystemSpeechPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    if (@available(iOS 10.0, *)) {
        SFSpeechRecognizerAuthorizationStatus authStatus = [SFSpeechRecognizer authorizationStatus];
        if (authStatus == SFSpeechRecognizerAuthorizationStatusNotDetermined) {
            [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
                if (status == SFSpeechRecognizerAuthorizationStatusAuthorized) {
                    succeedHandler();
                } else {
                    [self handleUnPermissionsFailedHandel:failedHandle];
                }
            }];
        }
        else if (authStatus == SFSpeechRecognizerAuthorizationStatusAuthorized)
        {
            succeedHandler();
        }
        else if(authStatus == SFSpeechRecognizerAuthorizationStatusDenied || authStatus == SFSpeechRecognizerAuthorizationStatusRestricted)
        {
            [self handleUnPermissionsFailedHandel:failedHandle];
        }
    } else {
        // Fallback on earlier versions
        failedHandle(SystemPermissionTypeDisable);
    }
}

@end
