//
//  RSA.h
//  rsasms
//
//  Created by Estevan Hernandez on 2/25/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

#import <Foundation/Foundation.h>
//@import Security;
@import Foundation;

@interface RSA : NSObject
@property (strong, nonatomic) NSNumber *e;
@property (strong, nonatomic) NSNumber *n;

+(NSString *)getStringFromEncodedNSURL:(NSURL *)aUrl;
+(NSString *)getEncodedStringForString:(NSString *)aString;
+(NSString *)newDeepLinkForText:(NSString *)aText;
@end
