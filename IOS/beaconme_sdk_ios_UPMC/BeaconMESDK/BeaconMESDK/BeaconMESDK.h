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
#import <BeaconMESDK/BeaconTagConfiguration.h>
#import <BeaconMESDK/BeaconTagConfigurationValues.h>

/**
 *
 * For proper functioning of this library you must follow the next rules:
 *
 * 1. In the host app target build settings turn on linking with
 *    CoreLocation and CoreBluetooth frameworks.
 *
 * 2. In the host app target build settings add custom linker flag "-ObjC".
 *
 * 3. In the host app target Info.plist file add appropriate value for the
 *    NSLocationAlwaysUsageDescription key.
 *
 */


/**
 * Library version.
 *
 * Don't edit this string manualy. Value is copied automatically
 * from latest Git tag message on each build.
 */
#define BEACON_ME_SDK_VERSION @"1.1.1"


@class BeaconMESDK;


@protocol BeaconMEDelegate <NSObject>
- (void)beaconMe:(BeaconMESDK *)beaconME
    triggeredActionForConfiguration:(BeaconTagConfiguration *)configuration bIsInside:(BOOL) bIsInside;
@optional
- (void)beaconMe:(BeaconMESDK *)beaconME
    didWriteConfiguration:(BeaconTagConfiguration *)configuration;
@end


@interface BeaconMESDK : NSObject
@property (nonatomic, weak) id<BeaconMEDelegate> delegate;

/**
 * Beacon Tag configurations.
 * This values will be written during pairing with specified Beacon Tag.
 * You are expected to set all the values before starting the library.
 */
@property (nonatomic, copy) NSArray *configurations;

/**
 * Default instance of BeaconME library, that is always available.
 * You are still welcome to create an instance manually.
 */
+ (instancetype)sharedInstance;

/**
 * This methods enable / disable iBeacons monitoring.
 * To receive alerts library instance must be started.
 */
- (void)start;
- (void)stop;
@end
