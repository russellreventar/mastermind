/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * -------------------------------------------------
 * SettingsViewController.h
 * -------------------------------------------------
 * Settings page allows user to adjust game settings
 * - input own username to be displayed in highscores
 * - change difficulty
 * - turn on/off timer
 **/
#import <UIKit/UIKit.h>
#import "Settings.h"
#import "MainMenuViewController.h"
#import "GameViewController.h"
#import "Model.h"
@interface SettingsViewController : UIViewController<UITextFieldDelegate>{
    Settings *settings;
    Model *model;
}

@property (strong, nonatomic) Settings *settings;
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UISwitch *sameColorSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *timerSwitch;

- (IBAction)sameColorSwitchToggled:(id)sender;
- (IBAction)timerSwitchToggled:(id)sender;

@end
