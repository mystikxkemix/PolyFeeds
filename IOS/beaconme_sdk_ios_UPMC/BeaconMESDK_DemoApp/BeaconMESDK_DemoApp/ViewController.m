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

#import "ViewController.h"
#import <BeaconMESDK/BeaconMESDK.h>

@interface ViewController () <BeaconMEDelegate>
@property (nonatomic) IBOutlet UILabel *versionNumberLabel;
@property (nonatomic) BeaconMESDK *beaconMe;
@end


@implementation ViewController

#pragma mark - VC lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupBeaconMe];

    self.versionNumberLabel.text = [NSString stringWithFormat:@"SDK version: %@",
        BEACON_ME_SDK_VERSION];
}

#pragma mark - Private methods

- (void)setupBeaconMe
{
    self.beaconMe						= [BeaconMESDK sharedInstance];
    self.beaconMe.delegate				= self;

    // Beacon en prêt à l'Université Pierre & Marie Curie (UPMC, Jussieu) > Yann Douze, sept. 2015
    BeaconTagConfiguration *beacon_UPMC	= [[BeaconTagConfiguration alloc] init];
    beacon_UPMC.beaconTagUUID			= [[NSUUID alloc] initWithUUIDString:@"3D4F13B4-D1FD-4049-80E5-D3EDCC840B66"]; // type 6 (last hex digit)
    beacon_UPMC.beaconTagMajor			= @(0x558B);
    beacon_UPMC.beaconTagMinor			= @(0xC4C9);
    beacon_UPMC.txPower					= beaconTagTxPower_minus_12;
    beacon_UPMC.workflowConditionType	= workflowConditionTypeEnterRegion;
    beacon_UPMC.configurationModeEnabled= YES;
    
    // Beacon de démo de Thierry Gaillet (TG)
	BeaconTagConfiguration *beacon_TG	= [[BeaconTagConfiguration alloc] init];
	beacon_TG.beaconTagUUID				= [[NSUUID alloc] initWithUUIDString:@"3D4F13B4-D1FD-4049-80E5-D3EDCC840B6E"]; // type E (last hex digit)
    beacon_TG.beaconTagMajor            = @(0x72AC);
    beacon_TG.beaconTagMinor            = @(0x35FF);
	beacon_TG.txPower					= beaconTagTxPower_minus_62;
	beacon_TG.advertisingInterval		= 160 * 2;									//	--> 200ms
    beacon_TG.workflowConditionType		= workflowConditionTypeEnterAndLeaveRegion;
//	beacon_TG.workflowConditionType		= workflowConditionTypeEnterRegion;
//	beacon_TG.workflowConditionType		= workflowConditionTypeLeaveRegion;
//	beacon_TG.workflowConditionType		= workflowConditionTypeTemperature;
//	beacon_TG.workflowConditionType		= workflowConditionTypeMovement;
//	beacon_TG.sleepDelay				= 2;
	beacon_TG.configurationModeEnabled	= YES;
	
    self.beaconMe.configurations		= @[
											beacon_UPMC,
											beacon_TG
											];
    [self.beaconMe start];
}

#pragma mark - BeaconME callbacks

- (void)beaconMe:(BeaconMESDK *)beaconME triggeredActionForConfiguration:(BeaconTagConfiguration *)configuration
                                                               bIsInside:(BOOL)beaconIsInside
{
    NSString *UUIDString = configuration.beaconTagUUID.UUIDString;
    NSString *typeString = [UUIDString substringFromIndex:[UUIDString length]-1]; // type = last hex digit
    NSString *condition  = beaconIsInside ? @"ENTERING" : @"LEAVING";
    
	NSString *text = [NSString stringWithFormat:@"Beacon %@ %@", typeString, condition];
    NSLog(@"%@", text);

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:text
        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)beaconMe:(BeaconMESDK *)beaconME didWriteConfiguration:(BeaconTagConfiguration *)configuration
{
    NSString *text = [NSString stringWithFormat:@"Configured %@", configuration.beaconTagUUID.UUIDString];
    NSLog(@"%@", text);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:text
        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

@end
