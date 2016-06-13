//
//  RSAConversationTableViewCell.h
//  rsasms
//
//  Created by Estevan Hernandez on 6/9/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface RSAConversationTableViewCell : UITableViewCell

@property (weak, nonatomic) Message *message;

@end
