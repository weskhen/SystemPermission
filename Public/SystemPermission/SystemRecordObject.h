//
//  SystemRecordObject.h
//  SystemPermission
//
//  Created by wujian on 2018/6/14.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemPermissionObject.h"

@interface SystemRecordObject : SystemPermissionObject

/** 获取当前录音权限对app的授权 **/
- (void)getSystemRecordAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock;

/** 录音权限 **/
- (void)judgeSystemRecordPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

@end
