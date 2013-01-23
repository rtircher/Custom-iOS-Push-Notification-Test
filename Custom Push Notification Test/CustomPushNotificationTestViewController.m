//
//  CustomPushNotificationTestViewController.m
//  Custom Push Notification Test
//
//  Created by Renaud Tircher on 1/23/13.
//  Copyright (c) 2013 Renaud Tircher. All rights reserved.
//

#import "CustomPushNotificationTestViewController.h"

@interface CustomPushNotificationTestViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property(nonatomic) NSInteger counter;


@end

@implementation CustomPushNotificationTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)buttonClicked:(id)sender {
    self.counter++;

    self.label.text = [NSString stringWithFormat:@"Button clicked %i times", self.counter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
