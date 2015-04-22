/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * -------------------------------------------------
 * Settings.m
 * -------------------------------------------------
 * Settings for the game
 * - sameColor : Games secret code difficulty
 * - timer : Game timer if on/off
 * - currentUser : User logged in
 **/
#import "Settings.h"

@implementation Settings
@synthesize sameColor,timer,currentUser;

-(id) init{
    sameColor = YES;
    timer = YES;
    currentUser = @"NIL";
    return self;
}
-(id) initWithSettings:(Settings*)set{
    self = set;
    return self;
}
-(id) initWithSameColor:(bool)sc timer:(bool)t user:(NSString*)u{
    sameColor = sc;
    timer = t;
    currentUser = u;
    return self;
}
-(id) copyWithZone:(NSZone *)zone{
    Settings *settingsCopy = [[[self class] allocWithZone:zone] init];
    settingsCopy.sameColor = sameColor;
    settingsCopy.timer = timer;
    settingsCopy.currentUser = currentUser;
    return settingsCopy;
}
-(id) initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if( self != nil ){
        self.sameColor = [decoder decodeBoolForKey:@"kSettingsSameColor"];
        self.timer = [decoder decodeBoolForKey:@"kSettingsTimer"];
        self.currentUser = [decoder decodeObjectForKey:@"kSettingsCurrentUser"];
    }
    return self;
}
-(void)encodeWithCoder: (NSCoder *) encoder{
    [encoder encodeBool:self.sameColor forKey:@"kSettingsSameColor"];
    [encoder encodeBool:self.timer forKey:@"kSettingsTimer"];
    [encoder encodeObject:self.currentUser forKey:@"kSettingsCurrentUser"];

}

@end
