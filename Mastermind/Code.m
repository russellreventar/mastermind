/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * -------------------------------------------------
 * Code.h
 * -------------------------------------------------
 * A code is made up of 4 pegs.
 * - pegs are declared using an array of size 4
 * - Code object can create, modify, compare
 *   and reset the code
 **/

#import "Code.h"
#import "Peg.h"
@implementation Code

@synthesize pegs;

-(id)init{
    pegs = [[NSMutableArray alloc]init];
    for(int i = 0; i<4 ; i++) [pegs addObject:[[Peg alloc]init]];
    return self;
}
-(id)initWithRandomCode{
    pegs = [[NSMutableArray alloc]init];
    for(int i = 0; i<4 ; i++)
        [pegs addObject:[[Peg alloc]initWithRandomColor]];
    return self;
}
-(id)initWithRandomCodeNoDuplicates{
    pegs = [[NSMutableArray alloc]init];
    NSMutableArray *colors = [[NSMutableArray alloc]init];
    [colors addObject:[[Peg alloc]initWithColor:RED]];
    [colors addObject:[[Peg alloc]initWithColor:YELLOW]];
    [colors addObject:[[Peg alloc]initWithColor:BLUE]];
    [colors addObject:[[Peg alloc]initWithColor:ORANGE]];
    [colors addObject:[[Peg alloc]initWithColor:GREEN]];
    [colors addObject:[[Peg alloc]initWithColor:BLACK]];
    [colors addObject:[[Peg alloc]initWithColor:PURPLE]];
    [colors addObject:[[Peg alloc]initWithColor:BROWN]];
    
    //shuffle color array
    int count = colors.count;
    for (int i = 0; i < count; ++i) {
        int nElements = count - i;
        int n = arc4random_uniform(nElements) + i;
        [colors exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    //select code
    for(int i = 0; i<4 ; i++){
        [pegs addObject:[colors objectAtIndex:i]];
    }
    
    return self;
}
-(id)initWithColors:(Color)one second:(Color)two third:(Color)three fourth:(Color)four{
    pegs = [[NSMutableArray alloc]init];
    for(int i = 0; i<4 ; i++)
        [pegs addObject:[[Peg alloc]init]];
    
    [[pegs objectAtIndex:0] setPegColor: one];
    [[pegs objectAtIndex:1] setPegColor: two];
    [[pegs objectAtIndex:2] setPegColor: three];
    [[pegs objectAtIndex:3] setPegColor: four];
    return self;
}
-(id)initWithCode:(Code*)code{
    pegs = [[NSMutableArray alloc]init];
    for(int i = 0; i<4 ; i++)
        [pegs addObject:[[Peg alloc]init]];
    
    [[pegs objectAtIndex:0] setPegColor: [code getPeg:0].color];
    [[pegs objectAtIndex:1] setPegColor: [code getPeg:1].color];
    [[pegs objectAtIndex:2] setPegColor: [code getPeg:2].color];
    [[pegs objectAtIndex:3] setPegColor: [code getPeg:3].color];
    return self;
}

#pragma GET Functions
-(Peg*)getPeg:(int)pos{
    return [pegs objectAtIndex:pos];
}
-(NSString*)getCodeStringFormat{
    return [NSString stringWithFormat:(@"%@,%@,%@,%@"),[[pegs objectAtIndex:0] getString],
          [[pegs objectAtIndex:1] getString],
          [[pegs objectAtIndex:2] getString],
          [[pegs objectAtIndex:3] getString]];
}

#pragma SET Functions
-(void)setColor:(Color)color InPosition:(int)pos{
    [[pegs objectAtIndex:pos] setPegColor: color];
}
-(void)SetColors:(Color)one second:(Color)two third:(Color)three fourth:(Color)four{
    [[pegs objectAtIndex:0] setPegColor: one];
    [[pegs objectAtIndex:1] setPegColor: two];
    [[pegs objectAtIndex:2] setPegColor: three];
    [[pegs objectAtIndex:3] setPegColor: four];
}

#pragma Helper Functions
/* Compare two codes alogrithm */
-(BOOL)compareToMaster:(Code*)m storeIn:(Code*)hint{
    
    /*-- initialize the three codes --*/
    [hint reset];   //hint will be stored here
    Code *mCopy = [[Code alloc]initWithCode:m];     //master code copy
    Code *uCopy = [[Code alloc]initWithCode:self];  //users guess code copy
    
    int white = 0;  //number of white peg hints
    int black = 0;  //number of black peg hints
    int uCount = 0; //user guess code index
    
    //Check if peg has the right color with right position
    //black hints
    for(int i = 0; i < 4 ; i++){
        if([mCopy getPeg:i].color == [uCopy getPeg:i].color){
            [mCopy setColor:BLANK InPosition:i]; //delete pegs when found
            [uCopy setColor:BLANK InPosition:i];
            black++;
        }
    }
    
    //Check if peg will have same color in the other positions
    //white hints
    for(int i=0; i<4; i++){
        uCount = 0;
        if([mCopy getPeg:i].color != BLANK){
            while(uCount < 4){
                if([mCopy getPeg:i].color == [uCopy getPeg:uCount].color){
                    [uCopy setColor:BLANK InPosition:uCount]; //delete and break loop when found
                    white++;
                    uCount = 5;
                }else{
                    uCount++;
                }
            }
        }
    }
    
    //set hint code with appropriate hint colors
    for(int b = 0; b < black ; b++)
        [hint setColor:BLACK InPosition:b];
    
    for(int w = black; w < black+white; w++)
        [hint setColor:WHITE InPosition:w];
    
    //return true if codes are exact
    if(black == 4) return true;
    else return false;
}
-(Boolean)isComplete{
    if([[pegs objectAtIndex:0]getPegColor] != BLANK &&
       [[pegs objectAtIndex:1]getPegColor] != BLANK &&
       [[pegs objectAtIndex:2]getPegColor] != BLANK &&
       [[pegs objectAtIndex:3]getPegColor] != BLANK)return true;
    else{
        return false;
    }
    
}
-(void)reset{
    for(Peg *a in pegs)
        [a init];
}
#pragma Copy & Coding Functions
-(id)copyWithZone:(NSZone *)zone{
    Code *codeCopy = [[Code alloc] init];
    codeCopy.pegs = [pegs copyWithZone: zone];
    return codeCopy;
}
-(id)initWithCoder: (NSCoder *) decoder{
    self = [super init];
    if( self != nil ){
        self.pegs = [decoder decodeObjectForKey:@"kCodepegs"];
    }
    return self;
}
-(void)encodeWithCoder: (NSCoder *) encoder{
    [encoder encodeObject:self.pegs forKey:@"kCodepegs"];

}

@end
