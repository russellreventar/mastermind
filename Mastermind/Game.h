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

#import <Foundation/Foundation.h>
#import "Code.h"
@interface Game : NSObject <NSCopying,NSCoding>{
    NSString *user;
    Code *code;
    int time;
    int attempts;
    bool completed;
    NSDate *date;
}

@property (nonatomic,strong) Code *code;
@property (nonatomic,strong) NSString *user;
@property (nonatomic,strong) NSDate *date;
@property () int time;
@property () int attempts;
@property () bool completed;

-(id)init;
-(id)initWithUser:(NSString*)u;
-(id)copyWithZone:(NSZone*)Zone;
-(id)initWithCoder: (NSCoder *) decoder;
-(void)encodeWithCoder: (NSCoder *) encoder;

-(void) setDateAndTime;
-(void) setCodeTo:(Code*)c;
-(Code*) getCode;
-(NSString*) getUser;
-(int) getTime;
-(int) getAttempts;
-(BOOL) isCompleted;
-(void) print;

@end
