//
//  F8ViewController.h
//  Focus-8
//
//  Created by Glaser on 4/10/14.
//  Copyright (c) 2014 Mike Montgomery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface F8ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate> {
    NSDate *destinationDate;
    NSTimer *timer;
    IBOutlet UILabel *countdownLabel;
}
@property (nonatomic, strong)IBOutlet UIPickerView *myPickerView;
@property (nonatomic, strong)NSArray *itemsArray;

- (IBAction)startCountdown:(id)sender;
- (IBAction)resetCountdown:(id)sender;

@end
