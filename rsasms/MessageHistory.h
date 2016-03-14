//
//  MessageHistory.h
//  rsasms
//
//  Created by Estevan Hernandez on 3/12/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageHistory : NSObject <NSCoding>
@property (strong, nonatomic) NSArray *messages;
+(void)saveMessagesToArchive:(MessageHistory *)aMessageHistory;
//+(NSString *)getPathToArchive;
+(MessageHistory *)getMessagesFromArchive;
@end
