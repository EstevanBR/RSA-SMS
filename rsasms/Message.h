//
//  Message.h
//  rsasms
//
//  Created by Estevan Hernandez on 3/14/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject <NSCoding>
@property (strong, nonatomic) NSString *sender;
@property (strong, nonatomic) NSNumber *eKey;
@property (strong, nonatomic) NSNumber *nKey;
@property (strong, nonatomic) NSString *encryptedMessage;
@property (weak, nonatomic) NSString *message;
@property (strong, nonatomic) NSDate *date;


@end
