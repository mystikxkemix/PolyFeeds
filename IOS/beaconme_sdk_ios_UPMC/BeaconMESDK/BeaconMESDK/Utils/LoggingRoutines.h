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

// Libraries
//#import <CocoaLumberjack/DDLog.h>
//
//
//#ifdef DEBUG
//    #define ddLogLevel LOG_LEVEL_VERBOSE
//#else
//    #define ddLogLevel LOG_LEVEL_WARN
//#endif
//
//
//void setupApplicationLogging();

#ifdef DEBUG
    #define DDLogVerbose(...) NSLog(__VA_ARGS__)
    #define DDLogDebug(...) NSLog(__VA_ARGS__)
    #define DDLogInfo(...) NSLog(__VA_ARGS__)
    #define DDLogWarn(...) NSLog(__VA_ARGS__)
    #define DDLogError(...) NSLog(__VA_ARGS__)
#else
    #define DDLogVerbose(...) while(NO){}
    #define DDLogDebug(...) while(NO){}
    #define DDLogInfo(...) while(NO){}
    #define DDLogWarn(...) NSLog(__VA_ARGS__)
    #define DDLogError(...) NSLog(__VA_ARGS__)
#endif
