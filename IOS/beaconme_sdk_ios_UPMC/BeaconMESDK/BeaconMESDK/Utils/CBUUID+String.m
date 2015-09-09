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

#import "CBUUID+String.h"

@implementation CBUUID (String)

- (NSString *)stringValue
{
    // Available in iOS 7.1 and later.
    if ([self respondsToSelector:@selector(UUIDString)]) {
        return self.UUIDString;
    }
    // Convert manualy in iOS 7.0.
    else {
        NSData* data = self.data;
        if ([data length] == 2) {
            const unsigned char *tokenBytes = [data bytes];
            return [NSString stringWithFormat:@"%02X%02X", tokenBytes[0], tokenBytes[1]];
        }
        else if ([data length] == 16)
        {
            NSUUID* nsuuid = [[NSUUID alloc] initWithUUIDBytes:[data bytes]];
            return [nsuuid UUIDString];
        }

        // We should not be here!
        return [self description];
    }
}

@end
