//
//  RSA.m
//  rsasms
//
//  Created by Estevan Hernandez on 2/25/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

#import "RSA.h"
@interface RSA ()
@property (strong, nonatomic) NSNumber *dKey;
@property (assign) char *cString;
@end
@implementation RSA
-(id)init {
    self = [super init];
    self.nKey = [NSNumber numberWithLong:7];
    self.eKey = [NSNumber numberWithLong:3904567];
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
    //const char *cString = malloc(sizeof(char) * [aString length]);//[[aString length]] = [aString UTF8String];
    //cString = [aString UTF8String];
    NSData *data = [aString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64 = [data base64EncodedStringWithOptions:0];
    return base64;
}
+(NSString *)newDeepLinkForText:(NSString *)aText {
    NSLog(@"new deep link before %@", aText);
    NSString *publicKeyBase64String = @"rsasms://Estevan/7/3904567/";
    aText = [publicKeyBase64String stringByAppendingString:[RSA getEncodedStringForString:aText]];
    NSLog(@"after %@", aText);
    return aText;
}

@end
