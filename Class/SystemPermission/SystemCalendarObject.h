//
//  SystemCalendarObject.h
//  SystemPermission
//
//  Created by wujian on 2018/6/15.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemPermissionObject.h"

@interface SystemCalendarObject : SystemPermissionObject

/** 获取当前日历/备忘录权限对app的授权**/
- (void)getSystemCalendarAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock;

/** 日历/备忘录权限 info.plist中 日历NSCalendarsUsageDescription 提醒事项:NSRemindersUsageDescription **/
- (void)judgeSystemCalendarPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

@end
