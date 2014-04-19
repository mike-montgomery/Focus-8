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


int timeTick = 3600;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
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

-(void)addPickerView{
    pickerArray = [[NSArray alloc] initWithObjects:@"Casual(20min)",@"Fair(40min)", @"Difficult(1 hr)", @"Intense(1 hr 15min)", nil];
    myTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 100, 300, 30)];
    myTextField.borderStyle = UITextBorderStyleRoundedRect;
    myTextField.delegate = self;
    [self.view addSubview:myTextField];
    [myTextField setPlaceholder:@"Pick Difficulty of Work"];
    myPickerView = [[UIPickerView alloc]init];
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-myPickerView.frame.size.height-50, 320, 50)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:doneButton, nil];
    [toolBar setItems:toolbarItems];
    myTextField.inputView = myPickerView;
    myTextField.inputAccessoryView = toolBar;
}

#pragma mark - Text field delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
       
    }
}
#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    [myTextField setText:[pickerArray objectAtIndex:row]];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

@end
