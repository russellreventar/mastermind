/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * -------------------------------------------------
 * Game.h
 * -------------------------------------------------
 * A game object holds the games data in which user is playing
 * - user : User playing the game
 * - code : Secret Code for the game
 * - time : time it took to guess the code
 * - attempts: number of tries taken
 * - completed: If user won or lost the game
 **/

#import "Game.h"

@implementation Game

@synthesize user,code,time,attempts,completed,date;

-(id)init{
    user = @"AAA";
    code = [[Code alloc]init];
    time = 0;
    attempts = 0;
    completed = NO;
    [self setDateAndTime];
    return self;
}
-(id)initWithUser:(NSString*)u{
    user = u;
    code = [[Code alloc]init];
    time = 0;
    attempts = 0;
    completed = NO;
    [self setDateAndTime];
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    Game *gameCopy = [[[self class] allocWithZone:zone] init];
    gameCopy.user = user;
    gameCopy.code = code;
    gameCopy.time = time;
    gameCopy.attempts = attempts;
    gameCopy.completed = completed;
    gameCopy.date = date;
    return gameCopy;
}

-(id)initWithCoder: (NSCoder *) decoder{
    self = [super init];
    if( self != nil ){
        self.user = [decoder decodeObjectForKey:@"kGameUser"];
        self.code = [decoder decodeObjectForKey:@"kGameCode"];
        self.time = [decoder decodeIntForKey:@"kGameTime"];
        self.attempts = [decoder decodeIntForKey:@"kGameAttempts"];
        self.completed = [decoder decodeBoolForKey:@"kGameCompleted"];
        self.date = [decoder decodeObjectForKey:@"kGameDate"];
    }
    return self;
}

-(void)encodeWithCoder: (NSCoder *) encoder{
    [encoder encodeObject:self.user forKey:@"kGameUser"];
    [encoder encodeObject:self.code forKey:@"kGameCode"];
    [encoder encodeInt:self.time forKey:@"kGameTime"];
    [encoder encodeInt:self.attempts forKey:@"kGameAttempts"];
    [encoder encodeBool:self.completed forKey:@"kGameCompleted"];
    [encoder encodeObject:self.date forKey:@"kGameDate"];
}

-(void) setDateAndTime{
    date = [NSDate date];

}
-(void) setCodeTo:(Code *)c{
    for(int i = 0; i<4;i++)
    [code setColor:[c getPeg:0].color InPosition:0];
}
-(Code*) getCode{
    return code;
}
-(NSString*) getUser{
    return user;
}
-(int) getTime{
    return time;
}
-(int) getAttempts{
    return attempts;
}
-(BOOL) isCompleted{
    return completed;
}
-(void) print{
    NSLog(@"%@", user);
    NSLog(@"cmplted: %d",completed);
    NSLog(@"time: %d",time);
    NSLog(@"attempts: %d",attempts);
}
@end
