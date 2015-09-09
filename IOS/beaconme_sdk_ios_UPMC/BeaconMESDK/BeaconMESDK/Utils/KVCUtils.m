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

#import "KVCUtils.h"

// Libraries
#import <objc/runtime.h>


NSString *po(id object)
{
    Class objectClass = [object class];
    NSMutableString *description = [NSMutableString string];
    [description appendFormat:@"Object %@ [%@]:",
        [NSValue valueWithPointer:(void *)object], NSStringFromClass(objectClass)];

    unsigned int numberOfProperties = 0;
    objc_property_t *properties = class_copyPropertyList(objectClass, &numberOfProperties);
    for (NSUInteger i = 0; i < numberOfProperties; i++) {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [description appendFormat:@"\n%@: %@", name, [object valueForKey:name]];
    }
    free(properties);

    return description;
}