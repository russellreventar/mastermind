/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * -------------------------------------------------
 * HighScoresViewController.h
 * -------------------------------------------------
 * List of all games completed.
 * - Show time it took to complete, amount of tries, code and user
 **/

#import <UIKit/UIKit.h>
#import "Game.h"
#import "HighScoresCell.h"
#import "Model.h"
@interface HighScoresViewController : UITableViewController{
    Model *model;
    NSMutableArray *games;
}

@property (nonatomic,strong) NSMutableArray *games;

@end
