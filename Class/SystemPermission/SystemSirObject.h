//
//  SystemSirObject.h
//  SystemPermission
//
//  Created by wujian on 2018/6/15.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemPermissionObject.h"

@interface SystemSirObject : SystemPermissionObject

/** 获取当前Sir权限对app的授权**/
- (void)getSystemSirAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock;

/** Sir权限 info.plist中 **/
- (void)judgeSystemSirPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

@end
