/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * ---------------------------------------
 * GameViewController.h
 * ---------------------------------------
 * Main Game Board.
 * - Dynamically draw users guesses, hints, ui elements
 * - Loads current users settings
 * - Button handlers, timer, alerts
 * - Saves all winning games to be displayed into highscores.
 **/

#import <UIKit/UIKit.h>
#import "Code.h"
#import "Peg.h"
#import "Game.h"
#import "Settings.h"
#import "Model.h"

typedef enum{
    GIVEUP,
    QUIT,
    WIN,
    LOSE
}alertID;
typedef enum{
    IDLE,
    ACTIVE
}uState;

@interface GameViewController : UIViewController<UIAlertViewDelegate,UINavigationControllerDelegate>{
    Settings *settings;
    NSMutableArray *games;
    Game *currentGame;
    Model *model;
    
    Code *masterCode;
    Code *userCode;
    Code *hintCode;
    
    NSMutableArray *guesses;
    alertID alert;
    
    int tag;
    int guessCodeCount;
    int rowCount;
    bool firstGuess;
    
    int timerSec;
    UILabel *timerLabel;
    NSTimer *timer;
    
    UIButton *checkButton;
    UIButton *UserCodeOne;
    UIButton *UserCodeTwo;
    UIButton *UserCodeThree;
    UIButton *UserCodeFour;
    
    UIButton *redButton;
    UIButton *blueButton;
    UIButton *whiteButton;
    UIButton *orangeButton;
    UIButton *greenButton;
    UIButton *yellowButton;
    UIButton *purpleButton;
    UIButton *blackButton;
    
    UIImageView *rowArrow;
}
@property (nonatomic,strong)  Settings *settings;
@property (strong, nonatomic) IBOutlet UIButton *revealMaster;
@property (nonatomic,strong) NSMutableArray *guesses;
@property (nonatomic,strong) UIImageView *rowArrow;
@property (nonatomic,strong) Code *userCode;
@property (nonatomic,strong) Code *masterCode;
@property (nonatomic,strong) Code *hintCode;

@property ()int guessCodeCount;
@property ()int rowCount;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic,strong) IBOutlet UIButton *UserCodeOne;
@property (nonatomic,strong) IBOutlet UIButton *UserCodeTwo;
@property (nonatomic,strong) IBOutlet UIButton *UserCodeThree;
@property (nonatomic,strong) IBOutlet UIButton *UserCodeFour;

@property (nonatomic,strong) IBOutlet UIButton *redButton;
@property (nonatomic,strong) IBOutlet UIButton *blueButton;
@property (nonatomic,strong) IBOutlet UIButton *purpleButton;
@property (nonatomic,strong) IBOutlet UIButton *orangeButton;
@property (nonatomic,strong) IBOutlet UIButton *greenButton;
@property (nonatomic,strong) IBOutlet UIButton *yellowButton;
@property (nonatomic,strong) IBOutlet UIButton *brownButton;
@property (nonatomic,strong) IBOutlet UIButton *blackButton;

@property (nonatomic,strong) IBOutlet UIButton *checkButton;

@property (strong, nonatomic) IBOutlet UIButton *mainMenuButton;
@property (strong, nonatomic) IBOutlet UIImageView* shadeImageView;

@property (strong, nonatomic) IBOutlet UIButton *newgameButton;
@property (strong, nonatomic) IBOutlet UIButton *quitButton;


@property (strong, nonatomic) IBOutlet UIImageView *timerOff;

- (IBAction)buttonClickNewGame:(id)sender;
- (IBAction)buttonClickQuit:(id)sender;

-(IBAction)buttonClickMainMenu:(id)sender;
-(IBAction)buttonCheck:(id)sender;
-(IBAction)buttonClickReveal:(id)sender;
-(IBAction)buttonClickRED:(id)sender;
-(IBAction)buttonClickBLUE:(id)sender;
-(IBAction)buttonClickPURPLE:(id)sender;
-(IBAction)buttonClickORANGE:(id)sender;
-(IBAction)buttonClickGREEN:(id)sender;
-(IBAction)buttonClickYELLOW:(id)sender;
-(IBAction)buttonClickBROWN:(id)sender;
-(IBAction)buttonClickBLACK:(id)sender;

-(IBAction)buttonClickUserOne:(id)sender;
-(IBAction)buttonClickUserTwo:(id)sender;
-(IBAction)buttonClickUserThree:(id)sender;
-(IBAction)buttonClickUserFour:(id)sender;


@end
