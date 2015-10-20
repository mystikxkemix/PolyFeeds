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


@class CLBeaconRegion;
@class ConfigurationController;
@class BeaconTagConfiguration;


@protocol ConfigurationControllerDataSource <NSObject>
- (NSArray *)configurationsForController:(ConfigurationController *)configurationController;
@end


@protocol ConfigurationControllerDelegate <NSObject>
- (void)configurationController:(ConfigurationController *)configurationController
    finishedConfiguration:(BeaconTagConfiguration *)configuration
    successfully:(BOOL)configuredSuccessfully;
@end


@interface ConfigurationController : NSObject
@property (nonatomic, weak) id<ConfigurationControllerDataSource> dataSource;
@property (nonatomic, weak) id<ConfigurationControllerDelegate> delegate;
@property (nonatomic, readonly) BOOL btPoweredOn;
- (void)start;
- (void)stop;
@end
