//
//  SystemCameraObject.h
//  SystemPermission
//
//  Created by wujian on 2018/6/14.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemPermissionObject.h"

@interface SystemCameraObject : SystemPermissionObject

/** 获取当前相机权限对app的授权 **/
- (void)getSystemCameraAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock;
/** 相机权限 **/
- (void)judgeSystemCameraPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

@end
