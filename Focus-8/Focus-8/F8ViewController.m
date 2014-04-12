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

- (void)viewDidLoad
{
    [super viewDidLoad];
	//Set destination date equal to 1 hour from now
    destinationDate = [NSDate dateWithTimeIntervalSinceNow:3600];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startCountdown:(id)sender {
    
    //Set up a timer that calls the updateTime method every second to update the label
    NSTimer *timer;
    timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(updateTime) userInfo:Nil repeats:YES];
}

-(void)updateTime
{
    //Get the time left until the specified date
    NSInteger ti = (NSInteger)destinationDate;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600) % 24;
   
    
    //Update the label with the remaining time
    self.countdownLabel.text = [NSString stringWithFormat:@"%i hrs %i min %i sec",hours, minutes, seconds];
}
@end
