//
//  Message.h
//  rsasms
//
//  Created by Estevan Hernandez on 3/14/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
@property (strong, nonatomic) NSString *contact;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSDate *date;


@end
