//
//  Viewself.messageVCm
//  rsasms
//
//  Created by Estevan Hernandez on 2/25/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//
@import UIKit;
#import "RSA.h"
#import "ViewController.h"
#import "Message.h"
#import "MessageHistory.h"
#define MAX_STRING_LENGTH 255

@interface ViewController () <UIApplicationDelegate>
@property (strong, nonatomic) MFMessageComposeViewController *messageVC;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) IBOutlet UILabel *characterCount;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *characterCountBottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendButtonBottomSpace;

@property (strong, nonatomic) MessageHistory *messageHistory;
@property (strong, nonatomic) RSA *rsa;
@end

@implementation ViewController
-(id)initWithUrl:(NSURL *)aUrl {
    self = [super init];
    self.url = aUrl;
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    
    CGFloat height = keyboardFrame.size.height;
    
    NSLog(@"Updating constraints.");
    // Because the "space" is actually the difference between the bottom lines of the 2 views,
    // we need to set a negative constant value here.
    self.sendButtonBottomSpace.constant = height-40;
    self.characterCountBottomSpace.constant = height-40;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

-(void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.sendButtonBottomSpace.constant = 10;
    self.characterCountBottomSpace.constant = 10;
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.textView resignFirstResponder];
}

- (void)viewDidLoad {
    NSLog(@"viewLoaded");
    [super viewDidLoad];
    self.textView.delegate = self;
    [self.textView becomeFirstResponder];
    self.rsa = [[RSA alloc] init];
    //[self.textView setBackgroundColor:[UIColor blackColor]];
    [self.textView setTextColor:[UIColor whiteColor]];
    [self.button addTarget:self
                    action:@selector(buttonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gotURL:)
                                                 name:@"url"
                                               object:nil];
    self.messageHistory = [MessageHistory getMessagesFromArchive];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)gotURL:(id)sender {
    NSLog(@"sender is %@", [sender class]);
    if (![self.messageVC isEqual:[NSNull null]]) {
        [self.messageVC dismissViewControllerAnimated:YES completion:^(void){}];
    }
    sender = [sender object];
    self.url = sender;//(NSURL *)[sender object];
    NSLog(@"self.url lastPathComponent %@",[self.url lastPathComponent]);
    self.textView.userInteractionEnabled = NO;
    Message *message = [[Message alloc] init];
    message.date = [NSDate date];
    message.sender = self.url.pathComponents[2];
    //[self.textView setBackgroundColor:[UIColor blackColor]];
    [self.textView setTextColor:[UIColor grayColor]];
    NSString *string = @"Decoded message:\n";
    self.textView.text = [NSString stringWithFormat:@"%@%@",string,[RSA getStringFromEncodedNSURL:self.url]];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller
                didFinishWithResult:(MessageComposeResult)result {
    NSLog(@"result");
    [self.messageVC dismissViewControllerAnimated:YES completion:^(void){}];
    
}

-(void)buttonPressed {
    NSLog(@"button pressed");
    NSString *encryptedString = [self.rsa encryptString:self.textView.text];
    if([MFMessageComposeViewController canSendText]) {
        NSLog(@"can send messages");
        self.messageVC = [MFMessageComposeViewController new];
        self.messageVC.messageComposeDelegate = self;
        self.messageVC.body = [RSA newDeepLinkForText:encryptedString];
        self.messageVC.recipients = [NSArray arrayWithObjects:
                                     self.phoneTextField.text, nil];
        self.messageVC.messageComposeDelegate = self;
        [self.textView resignFirstResponder];
        if([MFMessageComposeViewController canSendText]) {
            [self presentViewController:self.messageVC
                               animated:YES
                             completion:^(void){}];
        } else {
            NSLog(@"cannot send messages");
        }
    } else {
        self.textView.text = [RSA newDeepLinkForText:encryptedString];
    }
}
-(void)textViewDidChange:(UITextView *)textView {
    self.characterCount.text = [NSString stringWithFormat:@"%lu / %d",
                                (unsigned long) [self.textView.text length],
                                MAX_STRING_LENGTH];
}

-(BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url
           options:(nonnull NSDictionary<NSString *,id> *)options {
    NSArray *pathComponents = [url pathComponents];
    NSString* string;
    NSLog(@"%@/", [url host]);
    for (int i = 1; i < [pathComponents count]; i++) {
        NSLog(@"%@%c", pathComponents[i], (i < pathComponents.count) ? '/' : '\0');
        string = [string stringByAppendingString:pathComponents[i]];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"url"
                                                        object:url];
    return YES;
}

@end
