//
//  RSAConversationTableViewCell.m
//  rsasms
//
//  Created by Estevan Hernandez on 6/9/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

#import "RSAConversationTableViewCell.h"

@interface RSAConversationTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *senderLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;

@end

@implementation RSAConversationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessage:(Message *)message {
    self.senderLabel.text = message.sender;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"y MM dd hh:mm:ss"];
    self.timeStampLabel.text = [dateFormatter stringFromDate:message.date];
    self.messageTextView.text = message.encryptedMessage;
}

@end
