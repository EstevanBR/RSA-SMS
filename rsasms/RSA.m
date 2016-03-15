//
//  RSA.m
//  rsasms
//
//  Created by Estevan Hernandez on 2/25/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

#import "RSA.h"
#import "rsalib.h"
@interface RSA ()
@property (strong, nonatomic) NSNumber *dKey;
@property (assign) char *cString;
@end
@implementation RSA
-(id)init {
    self = [super init];
    self.nKey = [NSNumber numberWithLong:3904567];
    self.eKey = [NSNumber numberWithLong:7];
    self.dKey = [NSNumber numberWithLong:9943];
    return self;
}

+(NSString *)getStringFromEncodedNSURL:(NSURL *)aUrl {
    NSString *string = [aUrl lastPathComponent];
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];
    string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}
+(NSString *)getEncodedStringForString:(NSString *)aString {
    NSData *data = [aString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64 = [data base64EncodedStringWithOptions:0];
    return base64;
}
+(NSString *)newDeepLinkForText:(NSString *)aText {
    NSLog(@"new deep link before %@", aText);
    NSString *publicKeyBase64String = @"rsasms://Estevan/7/3904567/";
    aText = [publicKeyBase64String stringByAppendingString:[RSA getEncodedStringForString:aText]];
    return aText;
}
-(NSString *)encryptString:(NSString *)aString {
    const char *string = aString.UTF8String;
    unsigned long max = [aString length];
    unsigned long encoded[max];
    unsigned long _n = [self.nKey unsignedLongValue];
    unsigned long _e = [self.eKey unsignedLongValue];
    unsigned long i;
    for (i = 0; i < max; i++) {
        encoded[i] = modpow(string[i], _e, _n);
    }
    return [NSString stringWithUTF8String:string];
}
-(NSString *)decryptString:(NSString *)aString {
    //    const unichar *banana = [aString ];
    const char *string = aString.UTF8String;
    unsigned long max = [aString length];
    unsigned long decoded[max];
    unsigned long _n = [self.nKey unsignedLongValue];
    unsigned long _d = [self.dKey unsignedLongValue];
    unsigned long i;
    for (i = 0; i < max; i++) {
        decoded[i] = modpow(string[i], _d, _n);
    }
    return [NSString stringWithUTF8String:string];
}

@end
