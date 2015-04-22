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

#import "Model.h"

@implementation Model

-(NSString *)dataFilePathWithFilename:(NSString*)filename{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex: 0];
    return [documentsDirectory stringByAppendingPathComponent:filename];
}
-(Settings*) loadSettings{
    Settings *settings = [[Settings alloc]init];
    NSString *filePath = [self dataFilePathWithFilename:SettingsFilename];
	if([[NSFileManager defaultManager] fileExistsAtPath: filePath]) {
		NSData *data = [[NSMutableData alloc] initWithContentsOfFile: filePath];
		NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData: data];
        settings = [unarchiver decodeObjectForKey: kSettings];
		[unarchiver finishDecoding];
        return settings;
    } else {
        return settings = [[Settings alloc]init];
	}
}
-(void) saveSettings:(Settings*)settings{
    NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData: data];
    [archiver encodeObject: settings forKey:kSettings];
	[archiver finishEncoding];
	[data writeToFile: [self dataFilePathWithFilename:SettingsFilename] atomically: YES];
}
-(NSMutableArray*) loadGames{
    NSMutableArray *games = [[NSMutableArray alloc]init];
    NSString *filePath = [self dataFilePathWithFilename:GamesFilename];
	if([[NSFileManager defaultManager] fileExistsAtPath: filePath]) {
		NSData *data = [[NSMutableData alloc] initWithContentsOfFile: filePath];
		NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData: data];
		games = [unarchiver decodeObjectForKey: kGameList];
		[unarchiver finishDecoding];
        return games;
    } else {
		games = [[NSMutableArray alloc] init];
        return games;
	}
}
-(void) saveGames:(NSMutableArray*)games{
    NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData: data];
	[archiver encodeObject: games forKey: kGameList];
	[archiver finishEncoding];
	[data writeToFile: [self dataFilePathWithFilename:GamesFilename] atomically: YES];
}
@end
