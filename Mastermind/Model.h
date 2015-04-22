/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * -------------------------------------------------
 * Model.h
 * -------------------------------------------------
 * Handles data storage
 * Two object to be saved into bundle
 *      1) Settings object
 *      2) Array of all completed games
 * -this data model object will process the saving and loading
 *  of the two objects
 **/

#import <Foundation/Foundation.h>
#import "Settings.h"
#import "Game.h"

#define GamesFilename	 @"GamesArchive"
#define SettingsFilename @"SettingsArchive"
#define kGameList	@"GamesKey"
#define kSettings   @"SettingsKey"

@interface Model : NSObject

-(NSString*)dataFilePathWithFilename:(NSString*)filename;

-(Settings*) loadSettings;
-(void) saveSettings:(Settings*)settings;

-(NSMutableArray*) loadGames;
-(void) saveGames:(NSMutableArray*)games;
@end
