//
//  SystemHealthObject.m
//  SystemPermission
//
//  Created by wujian on 2018/6/19.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemHealthObject.h"
#import <HealthKit/HealthKit.h>

@implementation SystemHealthObject

- (BOOL)isSupportHealthData
{
    return [HKHealthStore isHealthDataAvailable];
}

- (void)getSystemHealthAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock quantityTypeIdentifier:(HKQuantityTypeIdentifier)identifier
{
    if (![HKHealthStore isHealthDataAvailable]) {
        authStatusBlock(SystemAuthStatusNotSupport);
    }
    else{
        HKHealthStore *healthStore = [[HKHealthStore alloc] init];
        HKObjectType *hkObjectType = [HKObjectType quantityTypeForIdentifier:identifier];
        HKAuthorizationStatus hkAuthStatus = [healthStore authorizationStatusForType:hkObjectType];
        if (hkAuthStatus == HKAuthorizationStatusNotDetermined) {
            authStatusBlock(SystemAuthStatusNotDetermined);
        } else if (hkAuthStatus == HKAuthorizationStatusSharingDenied) {
            authStatusBlock(SystemAuthStatusDenied);
        } else if (hkAuthStatus == HKAuthorizationStatusSharingAuthorized){
            authStatusBlock(SystemAuthStatusAuthorized);
        }
    }
}

//            NSSet <HKObjectType *> * healthKitTypesToRead = [[NSSet alloc] initWithArray:@[[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth],[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBloodType],[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex],[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight],[HKObjectType workoutType]]];
//            // 2. 你创建了另一个NSSet对象，里面有你需要向Store写入的信息的所有类型（锻炼与健身的信息、BMI、能量消耗、运动距离）
//            NSSet <HKSampleType *> * healthKitTypesToWrite = [[NSSet alloc] initWithArray:@[[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex],[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned],[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning]]];
//
//            [healthStore requestAuthorizationToShareTypes:healthKitTypesToWrite readTypes:healthKitTypesToRead completion:^(BOOL success, NSError *error) {
//
//            }];

@end
