/*
 Copyright (C) 2015 Orange
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WorkflowConditionType) {
    workflowConditionTypeUnknown = 0,
    workflowConditionTypeEnterRegion,
    workflowConditionTypeLeaveRegion,
	workflowConditionTypeEnterAndLeaveRegion,
    workflowConditionTypeTouchAnObject,
    workflowConditionTypeMovement,    
    workflowConditionTypeTemperature
};


typedef NS_ENUM(NSInteger, BeaconTagMode) {
    beaconTagModeUnknown = 0,
    beaconTagModePulsar,
    beaconTagModeAccelerometer,
    beaconTagModeThermo
};
BeaconTagMode beaconTagModeForConditionType(WorkflowConditionType conditionType);


typedef NS_ENUM(NSUInteger, BeaconTagTxPower) {
    beaconTagTxPowerUnknown = 0,
    beaconTagTxPower_minus_62,
    beaconTagTxPower_minus_52,
    beaconTagTxPower_minus_48,
    beaconTagTxPower_minus_44,
    beaconTagTxPower_minus_40,
    beaconTagTxPower_minus_36,
    beaconTagTxPower_minus_32,
    beaconTagTxPower_minus_30,
    beaconTagTxPower_minus_20,
    beaconTagTxPower_minus_16,
    beaconTagTxPower_minus_12,
    beaconTagTxPower_minus_8,
    beaconTagTxPower_minus_4,
    beaconTagTxPower_0,
    beaconTagTxPower_plus_4
};
SInt8 valueForBeaconTagTxPower(BeaconTagTxPower power);

