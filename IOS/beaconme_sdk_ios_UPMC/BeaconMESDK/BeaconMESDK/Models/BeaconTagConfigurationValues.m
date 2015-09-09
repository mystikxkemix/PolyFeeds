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

#import "BeaconTagConfigurationValues.h"

SInt8 valueForBeaconTagTxPower(BeaconTagTxPower power)
{
    switch (power) {
        case beaconTagTxPower_minus_62: return -62;
        case beaconTagTxPower_minus_52: return -52;
        case beaconTagTxPower_minus_48: return -48;
        case beaconTagTxPower_minus_44: return -44;
        case beaconTagTxPower_minus_40: return -40;
        case beaconTagTxPower_minus_36: return -36;
        case beaconTagTxPower_minus_32: return -32;
        case beaconTagTxPower_minus_30: return -30;
        case beaconTagTxPower_minus_20: return -20;
        case beaconTagTxPower_minus_16: return -16;
        case beaconTagTxPower_minus_12: return -12;
        case beaconTagTxPower_minus_8: return -8;
        case beaconTagTxPower_minus_4: return -4;
        case beaconTagTxPower_0: return 0;
        case beaconTagTxPower_plus_4: return 4;
        default: return 0xFF;
    }
}

BeaconTagMode beaconTagModeForConditionType(WorkflowConditionType conditionType)
{
    switch (conditionType) {
        case workflowConditionTypeEnterRegion:
        case workflowConditionTypeLeaveRegion:
		case workflowConditionTypeEnterAndLeaveRegion:
        case workflowConditionTypeTouchAnObject:
            return beaconTagModePulsar;
        
        case workflowConditionTypeTemperature:
            return beaconTagModeThermo;
        
        case workflowConditionTypeMovement:
            return beaconTagModeAccelerometer;

        default:
            return beaconTagModeUnknown;
    }
}