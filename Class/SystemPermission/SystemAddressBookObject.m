//
//  SystemAddressBookObject.m
//  SystemPermission
//
//  Created by wujian on 2018/6/14.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemAddressBookObject.h"
#import <AddressBook/AddressBook.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <Contacts/Contacts.h>
#endif

@interface SystemAddressBookObject ()

@property (nonatomic, assign)   ABAddressBookRef addressBook;

@end

@implementation SystemAddressBookObject

- (void)getSystemAddressBookAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock
{
    if (@available(iOS 9.0, *)) {
        CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (authStatus == CNAuthorizationStatusNotDetermined) {
            authStatusBlock(SystemAuthStatusNotDetermined);
        }
        else if (authStatus == CNAuthorizationStatusDenied) {
            authStatusBlock(SystemAuthStatusDenied);
        }
        else if (authStatus == CNAuthorizationStatusRestricted)
        {
            authStatusBlock(SystemAuthStatusRestricted);
        }
        else if (authStatus == CNAuthorizationStatusAuthorized)
        {
            authStatusBlock(SystemAuthStatusAuthorized);
        }
    } else {
        // Fallback on earlier versions
        ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
        if (authStatus == kABAuthorizationStatusNotDetermined) {
            authStatusBlock(SystemAuthStatusNotDetermined);
        }
        else if (authStatus == kABAuthorizationStatusDenied)
        {
            authStatusBlock(SystemAuthStatusDenied);
        }
        else if (authStatus == kABAuthorizationStatusRestricted)
        {
            authStatusBlock(SystemAuthStatusRestricted);
        }
        else if (authStatus == kABAuthorizationStatusAuthorized)
        {
            authStatusBlock(SystemAuthStatusAuthorized);
        }
    }
}

- (void)judgeSystemAddressBookPermissionsSuccess:(void (^)(void))succeedHandler withFailedHandel:(void (^)(SystemPermissionType permissionType))failedHandle
{
    if (@available(iOS 9.0, *)) {
        CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (authStatus == CNAuthorizationStatusNotDetermined) {
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    // 成功
                    succeedHandler();
                }
                else
                {// 失败
                    [self handleUnPermissionsFailedHandel:failedHandle];
                }
            }];
        }
        else if (authStatus == CNAuthorizationStatusDenied || authStatus == CNAuthorizationStatusRestricted) {
            [self handleUnPermissionsFailedHandel:failedHandle];
        }
        else if (authStatus == CNAuthorizationStatusAuthorized)
        {
            succeedHandler();
        }
    } else {
        // Fallback on earlier versions
        ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
        if (authStatus == kABAuthorizationStatusNotDetermined) {
            if (&ABAddressBookRequestAccessWithCompletion != NULL)
            {
                ABAddressBookRequestAccessWithCompletion(self.addressBook, ^(bool granted, CFErrorRef error)
                {
                    if (granted) {
                        succeedHandler();
                    }
                    else
                    {
                        [self handleUnPermissionsFailedHandel:failedHandle];
                    }
                    if (self.addressBook) {
                        CFRelease(self.addressBook);
                        self.addressBook = NULL;
                    }
                });
            }
        }
        else if (authStatus == kABAuthorizationStatusDenied || authStatus == kABAuthorizationStatusRestricted)
        {
            [self handleUnPermissionsFailedHandel:failedHandle];
        }
        else if (authStatus == kABAuthorizationStatusAuthorized)
        {
            succeedHandler();
        }
    }
}

#pragma mark - setter/getter
- (ABAddressBookRef )addressBook
{
    @synchronized (self)
    {
        if (_addressBook == NULL)
        {
            if (&ABAddressBookCreateWithOptions)
            {
                _addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
            }
        }
        return _addressBook;
    }
}

@end
