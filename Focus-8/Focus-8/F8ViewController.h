//
//  F8ViewController.h
//  Focus-8
//
//  Created by Glaser on 4/10/14.
//  Copyright (c) 2014 Mike Montgomery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface F8ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
- (IBAction)startCountdown:(id)sender;

@end
