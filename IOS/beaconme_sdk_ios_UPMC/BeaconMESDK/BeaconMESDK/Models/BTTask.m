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

#import "BTTask.h"

// Utils and constants
#import "KVCUtils.h"


@interface BTTask ()
@property (nonatomic, readwrite) BTTaskType type;
@property (nonatomic, readwrite) NSMutableDictionary *characteristicValues;
@property (nonatomic, readwrite) NSArray *dependencies;
@end


@implementation BTTask

#pragma mark - Object lifecycle

+ (instancetype)taskWithType:(BTTaskType)taskType
{
    BTTask *instance = [[BTTask alloc] init];
    instance.type = taskType;
    instance.characteristicValues = [[NSMutableDictionary alloc] init];
    instance.dependencies = @[];
    return instance;
}

#pragma mark - Public methods

- (void)addDependency:(BTTask *)task
{
    NSMutableArray *dependencies = [self mutableArrayValueForKey:STR_PROP(dependencies)];
    [dependencies addObject:task];
}

- (NSString *)beaconTagIdentifier
{
    return [NSString stringWithFormat:@"%@:%04X:%04X",
        self.beaconTagUUID.UUIDString, self.beaconTagMajor.intValue, self.beaconTagMinor.intValue];
}

@end
