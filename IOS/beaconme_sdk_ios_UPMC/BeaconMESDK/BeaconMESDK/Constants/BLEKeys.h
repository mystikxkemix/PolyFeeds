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

// Standard keys.
extern NSString *const kBLEFirmwareRevisionUUIDString;

extern NSString *const kBLEBatteryLevelServiceUUIDString;
extern NSString *const kBLEBatteryLevelCharacteristicUUIDString;

// Custom Orange BeaconTags keys.
extern NSString *const kBLEBeaconUUIDUUIDString;
extern NSString *const kBLEBeaconMajorUUIDString;
extern NSString *const kBLEBeaconMinorUUIDString;

extern NSString *const kBLEBeaconBatteryThresholdUUIDString;

extern NSString *const kBLEConfigurationModeService;
extern NSString *const kBLEConfigurationTxPowerCharacteristic;
extern NSString *const kBLEConfigurationIntervalCharacteristic;

extern NSString *const kBLEWakeUpServiceUUIDString;
extern NSString *const kBLEWakeUpSleepDelayCharacteristic;
extern NSString *const kBLEWakeUpAccelerationCharacteristic;
extern NSString *const kBLEWakeUpThermometerCharacteristic;
extern NSString *const kBLEWakeUpAngularCharacteristic;

// Max number of iBeacon regions that can be monitored by system.
extern NSInteger kMaxMonitoredBeaconRegions;