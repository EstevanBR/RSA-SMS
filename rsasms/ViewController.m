//
//  ViewController.m
//  rsasms
//
//  Created by Estevan Hernandez on 2/25/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//
@import MessageUI;
@import UIKit;

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.button addTarget:self
                    action:@selector(buttonPressed)
          forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    NSLog(@"result");
    
}

-(void)buttonPressed {
    MFMessageComposeViewController *controller = [MFMessageComposeViewController new];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = @"SMS message here";
        controller.recipients = [NSArray arrayWithObjects:@"1(234)567-8910", nil];
        controller.messageComposeDelegate = self;
        //[self presentModalViewController:controller animated:YES];
        if([MFMessageComposeViewController canSendText]) {
            [self presentViewController:controller animated:YES completion:nil];
        } else {
            NSLog(@"cannot send messages");
        }
    }
    //[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms:MobileNumber"]];
}

@end
