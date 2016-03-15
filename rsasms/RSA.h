//
//  RSA.h
//  rsasms
//
//  Created by Estevan Hernandez on 2/25/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Foundation;

@interface RSA : NSObject
@property (strong, nonatomic) NSNumber *eKey;
@property (strong, nonatomic) NSNumber *nKey;

+(NSString *)getStringFromEncodedNSURL:(NSURL *)aUrl;
+(NSString *)getEncodedStringForString:(NSString *)aString;
+(NSString *)newDeepLinkForText:(NSString *)aText;
-(NSString *)encryptString:(NSString *)aString;
-(NSString *)decryptString:(NSString *)aString;
@end
