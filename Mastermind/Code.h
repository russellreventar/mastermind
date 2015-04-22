/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * -------------------------------------------------
 * Code.h
 * -------------------------------------------------
 * A code is made up of 4 pegs.
 * - Pegs are declared using an array of size 4
 * - Objects can handle create, modify, compare 
 *   and reset the code functionality
 **/

#import <Foundation/Foundation.h>
#import "Peg.h"

@interface Code : NSObject <NSCopying, NSCopying>{
    @public
    NSMutableArray *pegs;
}

@property(nonatomic,strong)NSMutableArray *pegs;

-(id)init;
-(id)initWithRandomCode;
-(id)initWithRandomCodeNoDuplicates;
-(id)initWithColors:(Color)one second:(Color)two third:(Color)three fourth:(Color)four;
-(id)initWithCode:(Code*)code;
-(Peg*)getPeg:(int)pos;
-(BOOL)compareToMaster:(Code *)m storeIn:(Code*)hint;
-(void)setColor:(Color)color InPosition:(int)pos;
-(void)SetColors:(Color)one second:(Color)two third:(Color)three fourth:(Color)four;
-(NSString*)getCodeStringFormat;
-(Boolean)isComplete;
-(void)reset;

-(id)copyWithZone:(NSZone*)Zone;
-(id)initWithCoder: (NSCoder *) decoder;
-(void)encodeWithCoder: (NSCoder *) encoder;
@end
