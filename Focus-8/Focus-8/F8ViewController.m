//
//  F8ViewController.m
//  Focus-8
//
//  Created by Glaser on 4/10/14.
//  Copyright (c) 2014 Mike Montgomery. All rights reserved.
//

#import "F8ViewController.h"

@interface F8ViewController ()
@end
@implementation F8ViewController

int timeTick = 60;

- (void)viewDidLoad
{
    [super viewDidLoad];
	//Set destination date equal to 1 hour from now
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startCountdown:(id)sender {
    
    //Set up a timer that calls the updateTime method every second to update the label
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:Nil repeats:YES];
    destinationDate = [NSDate dateWithTimeIntervalSinceNow:timeTick];
    
    //Create a notification to appear when destinationDate is reached
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = @"Take a break! You deserved it!";
    note.fireDate = destinationDate;
}

-(void)updateTime
{
    if (timeTick == 0) {
        [timer invalidate];
        
        //Create an alert to appear once the timer has stopped
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Take a break!" message:@"You deserved it! Press OK then start break." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [message show];
    }
    else{
    timeTick--;
    //Create a NSCalendar to count the time
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    //Get units of time from calendar
    int units = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    //Create componets from units and set the time from now
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date] toDate:destinationDate options:0];
    
    //Update label with values from components
    [countdownLabel setText:[NSString stringWithFormat:@"%ld%c:%ld%c:%ld%c", (long)[components hour], 'h', (long)[components minute], 'm', (long)[components second], 's']];
    }
}

- (IBAction)resetCountdown:(id)sender {
    [timer invalidate];
    [countdownLabel setText:@"00h:00m:00s"];
}

@end
