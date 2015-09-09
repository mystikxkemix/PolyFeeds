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

//// Utils and constants
//#import "UIColor+HexString.h"
//
//// Libraries
//#import <CocoaLumberjack/DDASLLogger.h>
//#import <CocoaLumberjack/DDTTYLogger.h>
//#import <CocoaLumberjack/DDMultiFormatter.h>
//#import <CocoaLumberjack/DDDispatchQueueLogFormatter.h>
//
//
//void setupApplicationLogging()
//{
//    DDASLLogger *aslLogger = [DDASLLogger sharedInstance];
//    if (![[DDLog allLoggers] containsObject:aslLogger]) {
//        [DDLog addLogger:aslLogger];
//    }
//
//    setenv("XcodeColors", "YES", 1);
//    DDTTYLogger *ttyLogger = [DDTTYLogger sharedInstance];
//    ttyLogger.colorsEnabled = YES;
//    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithHexValue:0x4B2B10]
//        backgroundColor:nil forFlag:LOG_FLAG_DEBUG];
//    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithHexValue:0x666666]
//        backgroundColor:nil forFlag:LOG_FLAG_VERBOSE];
//
//    if (![[DDLog allLoggers] containsObject:ttyLogger]) {
//        [DDLog addLogger:ttyLogger];
//    }
//    
//}
