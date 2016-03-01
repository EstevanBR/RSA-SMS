//
//  RSA.m
//  rsasms
//
//  Created by Estevan Hernandez on 2/25/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

#import "RSA.h"
@import Foundation;

@implementation RSA
-(id)init {
    self = [super init];
    return self;
}

+(NSString *)getStringFromEncodedNSURL:(NSURL *)aUrl {
    NSString *string = [aUrl lastPathComponent];
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];
    string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"decoded string: %@", string);
    return string;
}
+(NSString *)getEncodedStringForString:(NSString *)aString {
    NSString *base64 = [[aString dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    return base64;
}
+(NSString *)newDeepLinkForText:(NSString *)aText {
    NSLog(@"new deep link before %@", aText);
    aText = [@"rsasms://n/e/" stringByAppendingString:[RSA getEncodedStringForString:aText]];
    NSLog(@"after %@", aText);
    return aText;
}

@end
