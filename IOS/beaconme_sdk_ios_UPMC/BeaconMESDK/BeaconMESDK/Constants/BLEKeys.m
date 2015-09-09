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

#import "BLEKeys.h"

NSString *const kBLEFirmwareRevisionUUIDString = @"2A26";

NSString *const kBLEBatteryLevelServiceUUIDString = @"180F";
NSString *const kBLEBatteryLevelCharacteristicUUIDString = @"2A19";

NSString *const kBLEBeaconUUIDUUIDString = @"59EC0A00-0B1E-4063-8B16-B00B50AA3A7E";
NSString *const kBLEBeaconMajorUUIDString = @"59EC0A02-0B1E-4063-8B16-B00B50AA3A7E";
NSString *const kBLEBeaconMinorUUIDString = @"59EC0A01-0B1E-4063-8B16-B00B50AA3A7E";

NSString *const kBLEBeaconBatteryThresholdUUIDString = @"59EC0A0A-0B1E-4063-8B16-B00B50AA3A7E";

NSString *const kBLEConfigurationModeService = @"59EC0800-0B1E-4063-8B16-B00B50AA3A7E";
NSString *const kBLEConfigurationTxPowerCharacteristic = @"59EC0A05-0B1E-4063-8B16-B00B50AA3A7E";
NSString *const kBLEConfigurationIntervalCharacteristic = @"59EC0A04-0B1E-4063-8B16-B00B50AA3A7E";

NSString *const kBLEWakeUpServiceUUIDString = @"59EC0802-0B1E-4063-8B16-B00B50AA3A7E";
NSString *const kBLEWakeUpSleepDelayCharacteristic = @"59EC0A07-0B1E-4063-8B16-B00B50AA3A7E";
NSString *const kBLEWakeUpAccelerationCharacteristic = @"59EC0A0B-0B1E-4063-8B16-B00B50AA3A7E";
NSString *const kBLEWakeUpThermometerCharacteristic = @"59EC0A08-0B1E-4063-8B16-B00B50AA3A7E";
NSString *const kBLEWakeUpAngularCharacteristic = @"59EC0A09-0B1E-4063-8B16-B00B50AA3A7E";

NSInteger kMaxMonitoredBeaconRegions = 20;