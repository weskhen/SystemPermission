//
//  SystemSpeechObject.h
//  SystemPermission
//
//  Created by wujian on 2018/6/15.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemPermissionObject.h"

@interface SystemSpeechObject : SystemPermissionObject

/** 获取当前语音识别权限对app的授权**/
- (void)getSystemSpeechAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock;

/** 语音识别权限 info.plist中 **/
- (void)judgeSystemSpeechPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle;

@end
