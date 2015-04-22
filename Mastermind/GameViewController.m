/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * ---------------------------------------
 * GameViewController.m
 * ---------------------------------------
 * Main Game Board. 
 * - Dynamically draw users guesses, hints, ui elements
 * - Loads current users settings
 * - Button handlers, timer, alerts
 * - Saves all winning games to be displayed into highscores.
 **/

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

@synthesize purpleButton,redButton,orangeButton,brownButton,blackButton,blueButton,greenButton,yellowButton,UserCodeOne,UserCodeTwo,UserCodeThree,UserCodeFour,guessCodeCount,checkButton,rowCount,guesses,masterCode,userCode,hintCode,timerLabel,mainMenuButton,revealMaster,newgameButton,quitButton,settings,timerOff,rowArrow;

-(void)viewDidLoad{
    [super viewDidLoad];
    model = [[Model alloc]init];
    settings = [[Settings alloc]initWithSettings:[model loadSettings]];
    games = [[NSMutableArray alloc]initWithArray:[model loadGames]];
    [self initialize];
}

#pragma INITIALIZATION
-(void) initialize{
    [self initGameVariables];
    [self initSettings];
    [self initGameBoard];
    NSLog(@"MASTER CODE: %@",[masterCode getCodeStringFormat]);
}
-(void) initGameVariables{
    currentGame = [[Game alloc]init];
    guesses = [[NSMutableArray alloc]init];
    userCode = [[Code alloc] init];
    hintCode = [[Code alloc] init];
    if(settings.sameColor){
        masterCode = [[Code alloc] initWithRandomCode];
    }else{
        masterCode = [[Code alloc] initWithRandomCodeNoDuplicates];
    }
    guessCodeCount = 0;
    rowCount = 0;
    firstGuess = true;
    tag = 1;
    timerSec = 0;
}
-(void) initSettings{
    [currentGame setUser:settings.currentUser];
    if(settings.timer){
        timerOff.hidden = YES;
    }else{
        timerOff.hidden = NO;
        timerLabel.text = @"";
    }
}
-(void) initGameBoard{
    UIImage *i = [UIImage imageNamed:@"indicator.png"];
    rowArrow = [[UIImageView alloc] initWithImage:i];
    rowArrow.frame =CGRectMake(3, 390, 19, 19);
    [self.view addSubview:rowArrow];
    
    [self drawDotted];
    [self enableAllButtons];
    [self toggleNewGamePopup:NO];
    [self toggleUserCode:NO];
    [self toggleCheckButton:NO];
    [self hideSelectors];
}

#pragma IBACTION BUTTON CLICK
// Color Buttons
-(IBAction)buttonClickRED:(id)sender{
    [self colorButtonPress:RED];
}
-(IBAction)buttonClickBLUE:(id)sender{
    [self colorButtonPress:BLUE];
}
-(IBAction)buttonClickPURPLE:(id)sender{
    [self colorButtonPress:PURPLE];
}
-(IBAction)buttonClickORANGE:(id)sender{
    [self colorButtonPress:ORANGE];
}
-(IBAction)buttonClickGREEN:(id)sender{
   [self colorButtonPress:GREEN];
}
-(IBAction)buttonClickYELLOW:(id)sender{
    [self colorButtonPress:YELLOW];
}
-(IBAction)buttonClickBROWN:(id)sender{
    [self colorButtonPress:BROWN];
}
-(IBAction)buttonClickBLACK:(id)sender{
   [self colorButtonPress:BLACK];
}

// User Buttons
-(IBAction)buttonClickUserOne:(id)sender{
    [self userButtonPress];
}
-(IBAction)buttonClickUserTwo:(id)sender{
    [self userButtonPress];
}
-(IBAction)buttonClickUserThree:(id)sender{
    [self userButtonPress];
}
-(IBAction)buttonClickUserFour:(id)sender{
    [self userButtonPress];
}

// Top bar Buttons
-(IBAction)buttonCheck:(id)sender{
    
    [self toggleCheckButton:NO];
    [self hideSelectors];
    [self toggleUserCode:NO];
    if([userCode isComplete]){
        
        [guesses addObject:userCode];
        Code *hint = [[Code alloc]init];

        if([userCode compareToMaster:masterCode storeIn:hint]){
            [self showWinAlert];
            [self drawMasterCode];
        }else{
            if(rowCount == 9){
                [self showLoseAlert];
                [self drawMasterCode];
            }else{
                [self animateRowArrow];
                for(UIImageView *a in self.view.subviews){
                    if(a.tag == (rowCount + 1)){
                        [a removeFromSuperview];
                    }
                }
            }

        }

        [self drawHints:hint atRow:rowCount];
    }
    [self drawGuesses:rowCount];
    [self resetUserCode];
    if(firstGuess){
        if(settings.timer){
            [self startTimer];
            firstGuess = false;
        }
    }
    rowCount++;
    
}
-(IBAction)buttonClickReveal:(id)sender{
    [self pauseTimer];
    [self showGiveUpAlert];
}
-(IBAction)buttonClickNewGame:(id)sender {
    [self resetGame];
    
}
-(IBAction)buttonClickQuit:(id)sender {
    [self performSegueWithIdentifier:@"toMainMenuSegue" sender:self];
}
-(IBAction)buttonClickMainMenu:(id)sender{
    [self showMainMenuAlert];
}

#pragma BUTTON HANDLERS
-(void)colorButtonPress:(Color)color{
    [self hideSelectors];
    if(guessCodeCount < 4){
        [self toggleUserCode:YES];
        [userCode setColor:color InPosition:guessCodeCount];
        switch (guessCodeCount) {
            case 0:
                UserCodeOne.enabled = YES;
                [UserCodeOne setImage:[userCode getPeg:0].largeIMG forState:UIControlStateNormal];break;
            case 1:
                UserCodeTwo.enabled = YES;
                [UserCodeTwo setImage:[userCode getPeg:1].largeIMG forState:UIControlStateNormal];break;
            case 2:
                UserCodeThree.enabled = YES;
                [UserCodeThree setImage:[userCode getPeg:2].largeIMG forState:UIControlStateNormal];break;
            case 3:
                UserCodeFour.enabled = YES;
                [UserCodeFour setImage:[userCode getPeg:3].largeIMG forState:UIControlStateNormal];break;
            default:;break;
        }
        UIImage *sel = [UIImage imageNamed: @"selector.png"];
        switch (color) {
            case RED:  [redButton setImage:sel forState:UIControlStateNormal];   break;
            case BLUE:  [blueButton setImage:sel forState:UIControlStateNormal];  break;
            case YELLOW:[yellowButton setImage:sel forState:UIControlStateNormal];break;
            case GREEN: [greenButton setImage:sel forState:UIControlStateNormal]; break;
            case ORANGE:[orangeButton setImage:sel forState:UIControlStateNormal];break;
            case PURPLE:[purpleButton setImage:sel forState:UIControlStateNormal];break;
            case BLACK: [blackButton setImage:sel forState:UIControlStateNormal]; break;
            case BROWN: [brownButton setImage:sel forState:UIControlStateNormal]; break;
            default:break;
        }
        if(guessCodeCount == 3){
            checkButton.enabled = YES;
            checkButton.hidden = NO;
        }
        guessCodeCount++;
    }else{
        
    }
}
-(void)userButtonPress{
    
    switch (guessCodeCount) {
        case 0: break;
        case 1:
             UserCodeOne.enabled = NO;
            [UserCodeOne setImage:[UIImage imageNamed:@"default.png"] forState:UIControlStateNormal];break;
        case 2:
             UserCodeTwo.enabled = NO;
            [UserCodeTwo setImage:[UIImage imageNamed:@"default.png"] forState:UIControlStateNormal];break;
        case 3:
             UserCodeThree.enabled = NO;
            [UserCodeThree setImage:[UIImage imageNamed:@"default.png"] forState:UIControlStateNormal];break;
        case 4:
             UserCodeFour.enabled = NO;
            [UserCodeFour setImage:[UIImage imageNamed:@"default.png"] forState:UIControlStateNormal];break;
        default:;break;
    }
     guessCodeCount--;
    
    if (guessCodeCount<4){
      checkButton.enabled = NO;
        checkButton.hidden = YES;
    }
    
}

#pragma UI DRAWING FUNCTIONS
-(void) removeDotted:(int)row{
    int yDis = 34;
    int y = 388;
    int x = 68;
    for(int i = 0 ; i < 10 ; i++){
        
        UIImage *img = [UIImage imageNamed:@"dotted.png"];
        UIImageView *iv = [[UIImageView alloc] initWithImage: img];
        iv.frame = CGRectMake(x, y, 127, 21);
        [self.view addSubview:iv];
        y-=yDis;
    }
}
-(void) drawDotted{
    int yDis = 34;
    int y = 388;
    int x = 68;
    for(int i = 0 ; i < 10 ; i++){
        UIImage *img = [UIImage imageNamed:@"dotted.png"];
        UIImageView *iv = [[UIImageView alloc] initWithImage: img];
        iv.frame = CGRectMake(x, y, 127, 21);
        [self assignTag:iv];
        [self.view addSubview:iv];
        y-=yDis;
    }
}
-(void) drawGuesses:(int)row{
    int xDis = 35;
    int yDis = 34;
    int xStart = 68;
    int y = 388;
    int x = xStart;
    
    y-=(yDis*row);
    
    for(int j = 0 ; j < 4 ; j++){
        Peg *o = [[guesses objectAtIndex:row] getPeg:j];
        UIImageView *iv = [[UIImageView alloc] initWithImage:o.smallIMG];
        iv.frame = CGRectMake(x, y, 21, 21);
        [self assignTag:iv];
        [self.view addSubview:iv];
        x+=xDis;
    }
}
-(void) drawHints:(Code*)hints atRow:(int)row{
    
    int yDis = 34;
    int y = 394;
    int x = 229;
    
    y-=(yDis*row);
    
    CGRect frame = CGRectMake(x, y, 7, 7);
    
    UIImageView *iv = [[UIImageView alloc] initWithImage: [hints getPeg:0].hintIMG];
    UIImageView *iv2 = [[UIImageView alloc] initWithImage: [hints getPeg:1].hintIMG];
    UIImageView *iv3 = [[UIImageView alloc] initWithImage: [hints getPeg:2].hintIMG];
    UIImageView *iv4 = [[UIImageView alloc] initWithImage: [hints getPeg:3].hintIMG];
    
    [self assignTag:iv];
    [self assignTag:iv2];
    [self assignTag:iv3];
    [self assignTag:iv4];
    iv.frame = CGRectMake(frame.origin.x - frame.size.width, frame.origin.y - frame.size.height, 8, 8);
    iv2.frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y - frame.size.height, 8, 8);
    iv3.frame = CGRectMake(frame.origin.x - frame.size.width, frame.origin.y + frame.size.height, 8, 8);
    iv4.frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y +frame.size.height, 8, 8);
    
    [self.view addSubview:iv];
    [self.view addSubview:iv2];
    [self.view addSubview:iv3];
    [self.view addSubview:iv4];
    
}
-(void) drawMasterCode{
    int xDis = 41;
    int xStart = 63;
    int y = 29;
    int x = xStart;
    
    for(int j = 0 ; j < 4 ; j++){
        UIImageView *iv = [[UIImageView alloc] initWithImage:[masterCode getPeg:j].largeIMG];
        iv.frame = CGRectMake(x, y, 33, 33);
        [self assignTag:iv];
        [self.view addSubview:iv];
        
        x+=xDis;
    }
}

#pragma TIMER 
-(void) startTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countup) userInfo:nil repeats:YES];
}
-(void) resetTimer{
    timerSec = 0;
    [timer invalidate];
    self.timerLabel.text = @"00:00";
}
-(void) pauseTimer{
    [timer invalidate];
}
-(void) countup{
    timerSec++;
    int min = timerSec / 60;
    int sec = timerSec % 60;
    self.timerLabel.text = [NSString stringWithFormat:@"%02d:%02d", min,sec];
}


#pragma ALERTS
-(void) showMainMenuAlert {
    alert = QUIT;
    UIAlertView *MainMenuAlert = [[UIAlertView alloc] initWithTitle:@"End Game" message:@"Are you sure you want to quit?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"YES", nil];
    [MainMenuAlert show];
}
-(void) showGiveUpAlert {
    alert = GIVEUP;
    UIAlertView *MainMenuAlert = [[UIAlertView alloc] initWithTitle:@"Give Up?" message:@"Show me hidden code" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"YES", nil];
    [MainMenuAlert show];
}
-(void) showWinAlert {
    [self pauseTimer];
    alert = WIN;
    UIAlertView *WinAlert = [[UIAlertView alloc] initWithTitle:@"You Win!" message:nil delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"New Game", nil];
    [WinAlert show];
}
-(void) showLoseAlert{
    [self pauseTimer];
    alert = LOSE;
    UIAlertView *LoseAlert = [[UIAlertView alloc] initWithTitle:@"You Lose!" message:nil delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"New Game", nil];
    [LoseAlert show];
}
-(void) alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
   
    switch(alert){
        case QUIT:
            if (buttonIndex == 0){
            }else{
                [self performSegueWithIdentifier:@"toMainMenuSegue" sender:self];
            }break;
        case GIVEUP:
            if (buttonIndex == 0){
                [self startTimer];
            }else{
                [self pauseTimer];
                [self disableAllButtons];
                [self drawMasterCode];
                [self toggleNewGamePopup:YES];
                [self animateNewGamePopup];
            }break;
        case WIN:
            if(buttonIndex == 0){
                [self addWinningGame];
                [self performSegueWithIdentifier:@"toMainMenuSegue" sender:self];
            }else{
                [self addWinningGame];
                [self resetGame];
            }break;
        case LOSE:
            if(buttonIndex == 0){
                [self performSegueWithIdentifier:@"toMainMenuSegue" sender:self];
            }else{
                [self resetGame];
            }break;
    }
}

#pragma HELPER FUNCTIONS
-(void) addWinningGame{
    [currentGame setCompleted:YES];
    [currentGame setTime:timerSec];
    [currentGame setAttempts:rowCount];
    [currentGame setCode:masterCode];
    [currentGame setDateAndTime];
    [games addObject:currentGame];
}
-(void) resetGame{
    [self toggleUserCode:NO];
    [self removeSubviews];
    [self resetTimer];
    [self initialize];
}
-(void) animateRowArrow{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    rowArrow.frame = CGRectMake(rowArrow.frame.origin.x, (rowArrow.frame.origin.y - 34), rowArrow.frame.size.width, rowArrow.frame.size.height);
    [UIView commitAnimations];
}
-(void) removeSubviews{
    [rowArrow removeFromSuperview];
    for(UIImageView *a in self.view.subviews){
        if(a.tag > 0 && a.tag < tag){
            [a removeFromSuperview];
        }
    }
}
-(void) resetUserCode{
    [userCode reset];
    [UserCodeOne setImage:[userCode getPeg:0].largeIMG forState:UIControlStateNormal];
    [UserCodeTwo setImage:[userCode getPeg:1].largeIMG forState:UIControlStateNormal];
    [UserCodeThree setImage:[userCode getPeg:2].largeIMG forState:UIControlStateNormal];
    [UserCodeFour setImage:[userCode getPeg:3].largeIMG forState:UIControlStateNormal];
    guessCodeCount = 0;
}
-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
-(void) disableAllButtons{
    blackButton.enabled = NO;
    brownButton.enabled = NO;
    redButton.enabled = NO;
    orangeButton.enabled = NO;
    yellowButton.enabled = NO;
    purpleButton.enabled = NO;
    blueButton.enabled = NO;
    greenButton.enabled = NO;
    
    UserCodeOne.enabled = NO;
    UserCodeTwo.enabled = NO;
    UserCodeThree.enabled = NO;
    UserCodeFour.enabled = NO;
    
    mainMenuButton.enabled = NO;
    revealMaster.enabled = NO;
}
-(void) enableAllButtons{
    blackButton.enabled = YES;
    brownButton.enabled = YES;
    redButton.enabled = YES;
    orangeButton.enabled = YES;
    yellowButton.enabled = YES;
    purpleButton.enabled = YES;
    blueButton.enabled = YES;
    greenButton.enabled = YES;
    
    UserCodeOne.enabled = YES;
    UserCodeTwo.enabled = YES;
    UserCodeThree.enabled = YES;
    UserCodeFour.enabled = YES;
    
    mainMenuButton.enabled = YES;
    revealMaster.enabled = YES;
}
-(void) hideSelectors{
    [redButton setImage:[UIImage imageNamed:@"default.png"]forState:UIControlStateNormal];
    [blueButton setImage:[UIImage imageNamed:@"default.png"] forState:UIControlStateNormal];
    [yellowButton setImage:[UIImage imageNamed:@"default.png"] forState:UIControlStateNormal];
    [orangeButton setImage:[UIImage imageNamed:@"default.png"] forState:UIControlStateNormal];
    [blackButton setImage:[UIImage imageNamed:@"default.png"] forState:UIControlStateNormal];
    [brownButton setImage:[UIImage imageNamed:@"default.png"] forState:UIControlStateNormal];
    [greenButton setImage:[UIImage imageNamed:@"default.png"] forState:UIControlStateNormal];
    [purpleButton setImage:[UIImage imageNamed:@"default.png"] forState:UIControlStateNormal];
}
-(void) toggleNewGamePopup:(BOOL)enable{
    if(enable){
        self.shadeImageView.hidden = NO;
        self.newgameButton.hidden = NO;
        self.quitButton.hidden = NO;
        self.newgameButton.enabled = YES;
        self.quitButton.enabled = YES;
    }else{
        self.shadeImageView.hidden = YES;
        self.newgameButton.hidden = YES;
        self.quitButton.hidden = YES;
        self.newgameButton.enabled = NO;
        self.quitButton.enabled = NO;
    }
}
-(void) animateNewGamePopup{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];

    
    newgameButton.frame = CGRectMake(newgameButton.frame.origin.x, (newgameButton.frame.origin.y - 100.0), newgameButton.frame.size.width, newgameButton.frame.size.height);
    quitButton.frame = CGRectMake(quitButton.frame.origin.x, (quitButton.frame.origin.y - 100.0), quitButton.frame.size.width, quitButton.frame.size.height);

    [UIView commitAnimations];

}
-(void) toggleCheckButton:(BOOL)enable{
    if(enable){
        checkButton.enabled = YES;
        checkButton.hidden = NO;
    }else{
        checkButton.enabled = NO;
        checkButton.hidden = YES;
    }
}
-(void) toggleUserCode:(BOOL)enable{
    
    if(enable){
        UserCodeOne.hidden = NO;
        UserCodeTwo.hidden = NO;
        UserCodeThree.hidden = NO;
        UserCodeFour.hidden = NO;
        
        UserCodeOne.enabled = YES;
        UserCodeTwo.enabled = YES;
        UserCodeThree.enabled = YES;
        UserCodeFour.enabled = YES;
    }else{
        UserCodeOne.enabled = NO;
        UserCodeTwo.enabled = NO;
        UserCodeThree.enabled = NO;
        UserCodeFour.enabled = NO;
        
        UserCodeOne.hidden = YES;
        UserCodeTwo.hidden = YES;
        UserCodeThree.hidden = YES;
        UserCodeFour.hidden = YES;
    }
}
-(void) assignTag:(UIImageView*)view{
    view.tag = tag;
    tag++;
}

-(void) viewDidDisappear:(BOOL)animated{
    [model saveGames:games];
}

@end
