//
//  SystemMediaPlayerObject.h
//  SystemPermission
//
//  Created by wujian on 2018/6/15.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemPermissionObject.h"

@interface SystemMediaPlayerObject : SystemPermissionObject

/** 获取当前媒体资料库权限对app的授权**/
- (void)getSystemMediaPlayerAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock;

/** 媒体资料库权限 info.plist中 **/
- (void)judgeSystemMediaPlayerPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

@end
