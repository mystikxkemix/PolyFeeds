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

#import "BeaconTagConfiguration.h"


static BeaconTagTxPower const kDefaultBeaconTagTxPower = beaconTagTxPower_0;
static UInt16 const kDefaultAdvertisingInterval = 160;
static SInt8 const kDefaultTemperatureLowerBoundary = 15;
static SInt8 const kDefaultTemperatureUpperBoundary = 25;
static WorkflowConditionType const kDefaultWorkflowConditionType = workflowConditionTypeEnterRegion;
static UInt16 const kDefaultSleepDelay = 0;
static Float32 const kDefaultAccelerationThreshold = 0.980665f;


@implementation BeaconTagConfiguration

#pragma mark - Object lifecycle.

- (instancetype)init
{
    self = [super init];
    if (self) {
        _beaconTagUUID = nil;
        _beaconTagMajor = nil;
        _beaconTagMinor = nil;
        _workflowConditionType = kDefaultWorkflowConditionType;
        _txPower = kDefaultBeaconTagTxPower;
        _advertisingInterval = kDefaultAdvertisingInterval;
        _sleepDelay = kDefaultSleepDelay;
        _accelerationWakeLevel = kDefaultAccelerationThreshold;
        _temperatureLowerBoundary = kDefaultTemperatureLowerBoundary;
        _temperatureUpperBoundary = kDefaultTemperatureUpperBoundary;
    }
    return self;
}

@end
