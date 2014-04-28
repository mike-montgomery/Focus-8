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

@implementation F8ViewController;
@synthesize myPickerView;
@synthesize itemsArray;

int timeTick;

- (void)viewDidLoad
{
    [super viewDidLoad];
    myPickerView.delegate = self;
    myPickerView.dataSource = self;
    itemsArray = [[NSArray alloc]initWithObjects:@"Casual", @"Hard", @"Intense", @"Exhausting", nil];
    //Casual=20min, Hard=35min, Intense = 50min, Exhausting=1hour 10min
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

#pragma mark - UIPickerView DataSource
//Returns the number of 'columns' to display
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//Returns the number of rows in each component
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [itemsArray count];
}

#pragma mark - UIPickerView Delegate
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [itemsArray objectAtIndex:row];
}

//If the use choses from the pickerview, it calls this function
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //Print to the console what the user choses
    NSLog(@"Chosen item: %@", [itemsArray objectAtIndex:row]);
    NSString *chosenRow =[itemsArray objectAtIndex:row];
    if ([chosenRow  isEqualToString: @"Casual"]){
        timeTick = 20;
    }else if ([chosenRow  isEqualToString: @"Hard"]){
        timeTick = 2100;
    }else if ([chosenRow isEqualToString:@"Intense"]){
        timeTick = 3000;
    }else if ([chosenRow isEqualToString:@"Exhausting"]) {
        timeTick = 4200;
    }
        
}

@end
