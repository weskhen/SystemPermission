//
//  SystemAddressBookObject.h
//  SystemPermission
//
//  Created by wujian on 2018/6/14.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemPermissionObject.h"

@interface SystemAddressBookObject : SystemPermissionObject

/** 获取当前通讯录对app的授权 **/
- (void)getSystemAddressBookAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock;

/** 通讯录权限 **/
- (void)judgeSystemAddressBookPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

@end
