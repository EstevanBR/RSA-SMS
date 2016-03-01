//
//  Viewself.messageVCm
//  rsasms
//
//  Created by Estevan Hernandez on 2/25/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//
@import MessageUI;
@import UIKit;
#import "RSA.h"
#import "ViewController.h"
#define MAX_STRING_LENGTH 255

@interface ViewController ()
@property (strong, nonatomic) MFMessageComposeViewController *messageVC;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) IBOutlet UILabel *characterCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate = self;
    if([MFMessageComposeViewController canSendText])
    {
        self.messageVC = [MFMessageComposeViewController new];
        self.messageVC.messageComposeDelegate = self;
    }
    [self.button addTarget:self
                    action:@selector(buttonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gotURL:)
                                                 name:@"url"
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)gotURL:(id)sender {
    NSLog(@"sender is %@", [sender class]);
    sender = [sender object];
    self.url = sender;//(NSURL *)[sender object];
    NSLog(@"self.url lastPathComponent %@",[self.url lastPathComponent]);
    self.textView.text = [self.url lastPathComponent];
    self.textView.text = [RSA getStringFromEncodedNSURL:self.url];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    NSLog(@"result");
    [self.messageVC dismissViewControllerAnimated:YES completion:^(void){}];
    
}

-(void)buttonPressed {
    if([MFMessageComposeViewController canSendText])
    {
        self.messageVC.body = [RSA newDeepLinkForText:self.textView.text];
        self.messageVC.recipients = [NSArray arrayWithObjects:@"1(707)303-5540", nil];
        self.messageVC.messageComposeDelegate = self;
        if([MFMessageComposeViewController canSendText]) {
            [self presentViewController:self.messageVC animated:YES completion:^(void){}];
        } else {
            NSLog(@"cannot send messages");
        }
    }
}
-(void)textViewDidChange:(UITextView *)textView {
    self.characterCount.text = [NSString stringWithFormat:@"%lu / %d", [self.textView.text length], MAX_STRING_LENGTH];
}
@end
