//
//  SystemAlbumObject.h
//  SystemPermission
//
//  Created by wujian on 2018/6/14.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemPermissionObject.h"

@interface SystemAlbumObject : SystemPermissionObject

/** 获取当前相册权限对app的授权 **/
- (void)getSystemAlbumAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock;

/** 相册权限 **/
- (void)judgeSystemAlbumPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

@end
