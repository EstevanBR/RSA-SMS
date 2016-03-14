//
//  MessageHistory.m
//  rsasms
//
//  Created by Estevan Hernandez on 3/12/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

#import "MessageHistory.h"
#import "Message.h"
#define kMessages @"messages"
@implementation MessageHistory
-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    self.messages = [aDecoder decodeObjectForKey:kMessages];
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.messages forKey:kMessages];
}
+(void)saveMessagesToArchive:(MessageHistory *)aMessageHistory {
    [NSKeyedArchiver archiveRootObject:aMessageHistory toFile:[MessageHistory getPathToArchive]];
}
+(NSString *)getPathToArchive {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [paths objectAtIndex:0];
    return [docsDir stringByAppendingString:@"messages.model"];

}
+(MessageHistory *)getMessagesFromArchive {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[MessageHistory getPathToArchive]];
    
}

-(void)addMessageToHistory:(Message *)aMessage {
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self.messages];
    [mutableArray addObject:aMessage];
    self.messages = (NSArray *)mutableArray;
    
}

@end
