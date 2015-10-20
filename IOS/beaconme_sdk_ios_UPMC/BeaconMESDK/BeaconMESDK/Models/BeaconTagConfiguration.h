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
#import "BeaconTagConfigurationValues.h"


@interface BeaconTagConfiguration : NSObject

/**
 * Enable configuration mode for the device.
 */
@property (nonatomic) BOOL configurationModeEnabled;

/**
 * These properties define which BeaconTag
 * will be automatically connected and configured.
 * These properties are required.
 */
@property (nonatomic, copy) NSUUID *beaconTagUUID;
@property (nonatomic, copy) NSNumber *beaconTagMajor;
@property (nonatomic, copy) NSNumber *beaconTagMinor;

/**
 * Transmitter output power.
 * Allowed dBm values are listed in enum.
 * Default value is 0 dBm.
 */
@property (nonatomic) BeaconTagTxPower txPower;

/**
 * Advertising interval in units of 625µs.
 * Allowed range for the value is 160..16000.
 * Default value is 160 (160 * 625µs = 100 ms).
 */
@property (nonatomic) UInt16 advertisingInterval;

/**
 * Delay in seconds, which defines
 * how long the BeaconTag transmits after wake up condition is met.
 * Allowed range for the value is 1..65535.
 * A value of 0 disables sleeping.
 * This property is required for conditional workflows (temperature, movement).
 */
@property (nonatomic) UInt16 sleepDelay;

/**
 * Temperature wake range in ºC.
 * Used for temperature workflow condition.
 * Upper boundary must be greater than or equal to lower boundary.
 * Boundaries are inclusive.
 * Default range is 15º..25º C.
 */
@property (nonatomic) SInt8 temperatureLowerBoundary;
@property (nonatomic) SInt8 temperatureUpperBoundary;

/**
 * Acceleration wake level in m/s².
 * Used for movement workflow condition.
 * Allowed range for the value is 0.1569064 .. 156.9064 m/s².
 * Default value is 0.980665 m/s².
 */
@property (nonatomic) Float32 accelerationWakeLevel;

/**
 * For movement and temperature services BeaconTag transmits only when
 * respective conditions are met.
 * Default value is "enter region".
 */
@property (nonatomic) WorkflowConditionType workflowConditionType;

@end
