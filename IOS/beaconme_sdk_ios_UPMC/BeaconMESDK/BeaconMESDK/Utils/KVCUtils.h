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

#ifndef STR_PROP
    #define STR_PROP( prop ) NSStringFromSelector(@selector(prop))
#endif

#pragma mark - NSCoding helpers


#ifndef STR_PROP
    #define STR_PROP( prop ) NSStringFromSelector(@selector(prop))
#endif


#ifndef PROPERTY_CODECS
    #define PROPERTY_CODECS

    #define ENCODE_BOOL_PROPERTY( coder , prop )\
        [coder encodeBool:self.prop forKey:@#prop]
    #define ENCODE_INTEGER_PROPERTY( coder , prop )\
        [coder encodeInteger:self.prop forKey:@#prop]
    #define ENCODE_DOUBLE_PROPERTY( coder , prop )\
        [coder encodeDouble:self.prop forKey:@#prop]
    #define ENCODE_FLOAT_PROPERTY( coder , prop )\
        [coder encodeFloat:self.prop forKey:@#prop]
    #define ENCODE_OBJECT_PROPERTY( coder , prop )\
        [coder encodeObject:self.prop forKey:@#prop]

    #define DECODE_BOOL_PROPERTY( decoder , prop )\
        self.prop = [decoder decodeBoolForKey:@#prop]
    #define DECODE_INTEGER_PROPERTY( decoder , prop )\
        self.prop = [decoder decodeIntegerForKey:@#prop]
    #define DECODE_DOUBLE_PROPERTY( decoder , prop )\
        self.prop = [decoder decodeDoubleForKey:@#prop]
    #define DECODE_FLOAT_PROPERTY( decoder , prop )\
        self.prop = [decoder decodeFloatForKey:@#prop]
    #define DECODE_OBJECT_PROPERTY( decoder , prop )\
        self.prop = [decoder decodeObjectForKey:@#prop]
#endif


// Debug info: values for all properties of an object.
NSString *po(id object);
