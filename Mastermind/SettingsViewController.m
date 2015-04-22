/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * -------------------------------------------------
 * SettingsViewController.m
 * -------------------------------------------------
 * Settings page allows user to adjust game settings
 * - input own username to be displayed in highscores
 * - change difficulty
 * - turn on/off timer
 **/

#import "SettingsViewController.h"

@interface SettingsViewController ()
@end
@implementation SettingsViewController
@synthesize settings, sameColorSwitch,timerSwitch,usernameTextField;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initialize];
}

-(void) initialize{
    usernameTextField.delegate = self;
    model = [[Model alloc]init];
    
    //load users settings
    settings = [[Settings alloc]initWithSettings:[model loadSettings]];
    usernameTextField.text = settings.currentUser;
    sameColorSwitch.on = settings.sameColor;
    timerSwitch.on = settings.timer;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    settings.currentUser = usernameTextField.text;
    [usernameTextField resignFirstResponder];
    return NO;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 4) ? NO : YES;
}
- (IBAction)sameColorSwitchToggled:(id)sender {
    settings.sameColor = sameColorSwitch.on;
}
- (IBAction)timerSwitchToggled:(id)sender {
    settings.timer = timerSwitch.on;
}
-(void) viewDidDisappear:(BOOL)animated{
    [model saveSettings:settings];
}

@end
