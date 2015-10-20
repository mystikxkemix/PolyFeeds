#import "BeaconMESDK.h"
#import "ConfigurationController.h"
#import "TriggeringController.h"
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

#import "LoggingRoutines.h"
#import "BeaconTagConfiguration.h"

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>


@interface BeaconMESDK () <TriggeringControllerDelegate, ConfigurationControllerDataSource,
    ConfigurationControllerDelegate>
@property (nonatomic) TriggeringController *triggeringController;
@property (nonatomic) ConfigurationController *configurationController;
@property (nonatomic) BOOL started;
@end


@implementation BeaconMESDK

#pragma mark - Public methods

- (void)start
{
    self.started = YES;
    
    self.triggeringController = [[TriggeringController alloc] init];
    self.triggeringController.delegate = self;
    self.triggeringController.configurations = self.configurations;
    [self.triggeringController start];
    
    BOOL configurationModeEnabled = NO;
    for (BeaconTagConfiguration *configuration in self.configurations) {
        if (configuration.configurationModeEnabled) {
            configurationModeEnabled = YES;
            break;
        }
    }
    if (configurationModeEnabled) {
        [self setupConfigurationController];
    }
}

- (void)stop
{
    self.started = NO;
    
    [self.triggeringController stop];
    [self.configurationController stop];
}

#pragma mark - Accessors

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static id _sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });

    return _sharedInstance;
}

- (void)setConfigurations:(NSArray *)configurations
{
    _configurations = [configurations copy];
    self.triggeringController.configurations = configurations;
}

#pragma mark - Private methods

- (void)setupConfigurationController
{
    // Just in case.
    [self.configurationController stop];
    self.configurationController = nil;

    self.configurationController = [[ConfigurationController alloc] init];
    self.configurationController.delegate = self;
    self.configurationController.dataSource = self;
    [self.configurationController start];
}

#pragma mark Controllers callbacks

- (void)triggeringController:(TriggeringController *)triggeringController
	triggeredOnConfiguration:(BeaconTagConfiguration *)configuration bIsInside:(BOOL) bIsInside
{
	[self.delegate beaconMe:self triggeredActionForConfiguration:configuration bIsInside:bIsInside];
}

- (void)triggeringController:(TriggeringController *)triggeringController
    changedAuthenticationStatus:(BOOL)authenticated
{
    DDLogInfo(@"New authorization status: %i.", authenticated);
}

- (NSArray *)configurationsForController:(ConfigurationController *)configurationController
{
    return self.configurations;
}

- (void)configurationController:(ConfigurationController *)configurationController
    finishedConfiguration:(BeaconTagConfiguration *)configuration successfully:(BOOL)successfully
{
    if (successfully) {
        if ([self.delegate respondsToSelector:@selector(beaconMe:didWriteConfiguration:)]) {
            [self.delegate beaconMe:self didWriteConfiguration:configuration];
        }
    }
}

@end
