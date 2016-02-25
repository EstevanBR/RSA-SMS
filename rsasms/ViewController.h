//
//  ViewController.h
//  rsasms
//
//  Created by Estevan Hernandez on 2/25/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextViewDelegate, MFMessageComposeViewControllerDelegate>
@property (strong,nonatomic) IBOutlet UITextView *textView;
@property (strong,nonatomic) IBOutlet UIButton *button;


@end

