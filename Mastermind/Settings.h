/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * -------------------------------------------------
 * Settings.h
 * -------------------------------------------------
 * Settings for the game
 * - sameColor : Games secret code difficulty
 * - timer : Game timer if on/off
 * - currentUser : User logged in
 **/

#import <Foundation/Foundation.h>

@interface Settings : NSObject <NSCopying, NSCoding>{
    bool sameColor;
    bool timer;
    NSString *currentUser;
}

@property () bool sameColor;
@property () bool timer;
@property () NSString*currentUser;

-(id) init;
-(id) initWithSettings:(Settings*)set;
-(id) initWithSameColor:(bool)sc timer:(bool)t user:(NSString*)u;
-(id) copyWithZone:(NSZone *)zone;
-(id) initWithCoder:(NSCoder *)aDecoder;
-(void)encodeWithCoder: (NSCoder *) encoder;

@end
