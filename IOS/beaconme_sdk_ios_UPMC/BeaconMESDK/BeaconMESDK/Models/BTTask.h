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

typedef NS_ENUM(NSUInteger, BTTaskType) {
    btTaskTypeUnknown,
    btTaskTypeCheckUUID,
    btTaskTypeWriteValue
};

typedef NS_ENUM(NSUInteger, BTTaskState) {
    btTaskStateUnknown = 0,
    btTaskStateCancelled,
    btTaskStateNotStarted,
    btTaskStateRunning,
    btTaskStateFinished,
    btTaskStateFailed
};


@interface BTTask : NSObject
@property (nonatomic, readonly) BTTaskType type;
@property (nonatomic) BTTaskState state;
// For optional tasks there are no 'failed' state, only 'finished'.
@property (nonatomic) BOOL optional;
@property (nonatomic) BOOL disconnectAfterFinishing;

// Tasks we wait to finish before starting this task.
@property (nonatomic, readonly) NSArray *dependencies;
- (void)addDependency:(BTTask *)task;

// Identify target Beacon Tag by its iBeacon UUID.
@property (nonatomic, copy) NSUUID *beaconTagUUID;
@property (nonatomic, copy) NSNumber *beaconTagMajor;
@property (nonatomic, copy) NSNumber *beaconTagMinor;
@property (nonatomic, readonly) NSString *beaconTagIdentifier;

@property (nonatomic, copy) NSString *serviceUUID;

// Characteristac UUID (NSString) -> characteristic value(NSData)
@property (nonatomic, readonly) NSMutableDictionary *characteristicValues;

@property (nonatomic) NSTimeInterval timeout;

@property (nonatomic, copy) void(^completed)(BTTask *task);
@property (nonatomic, copy) void(^failed)(NSError *error);

+ (instancetype)taskWithType:(BTTaskType)taskType;
@end
