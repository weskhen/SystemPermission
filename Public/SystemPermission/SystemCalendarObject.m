//
//  SystemCalendarObject.m
//  SystemPermission
//
//  Created by wujian on 2018/6/15.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemCalendarObject.h"
#import <EventKit/EventKit.h>

@implementation SystemCalendarObject

/** 获取当前日历权限对app的授权**/
- (void)getSystemCalendarAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock
{
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    if (status == EKAuthorizationStatusNotDetermined) {
        authStatusBlock(SystemAuthStatusNotDetermined);
    }
    else if (status == EKAuthorizationStatusAuthorized)
    {
        authStatusBlock(SystemAuthStatusAuthorized);
    }
    else if (status == EKAuthorizationStatusDenied)
    {
        authStatusBlock(SystemAuthStatusDenied);
    }
    else if (status == EKAuthorizationStatusRestricted)
    {
        authStatusBlock(SystemAuthStatusRestricted);
    }
}

- (void)judgeSystemCalendarPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    if (status == EKAuthorizationStatusNotDetermined) {
        //查询是否获取日历或备忘录权限
        @autoreleasepool{
            EKEventStore *store = [[EKEventStore alloc]init];
            [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    succeedHandler();
                }
                else{
                    [self handleUnPermissionsFailedHandel:failedHandle];
                }
            }];
        }
    }
    else if (status == EKAuthorizationStatusAuthorized)
    {
        succeedHandler();
    }
    else if (status == EKAuthorizationStatusDenied || status == EKAuthorizationStatusRestricted)
    {
        [self handleUnPermissionsFailedHandel:failedHandle];
    }
}

@end
