/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * -------------------------------------------------
 * Peg.m
 * -------------------------------------------------
 * A peg is the individual color 
 * - 8 possible colors for a peg.
 * - also contains image data for displaying on game board
 **/

#import "Peg.h"

@implementation Peg

@synthesize strName,color,largeIMG,smallIMG,hintIMG;

-(id)init{
    color = BLANK;
    [self setImage];
    [self setName];
    return self;
}

-(id)initWithColor:(Color)c{
    color = c;
    [self setName];
    [self setImage];
    return self;
}

-(id)initWithRandomColor{
    color = [self generateRandomColor];
    [self setImage];
    [self setName];
    return self;
}

-(Color)generateRandomColor{
    int lowerBound = 1;
    int upperBound = 8;
    int randomValue = lowerBound + arc4random()%(upperBound-lowerBound+1);
    switch (randomValue) {
        case 1: return  RED;    break;
        case 2: return  BLUE;   break;
        case 3: return  YELLOW; break;
        case 4: return  GREEN;  break;
        case 5: return  ORANGE; break;
        case 6: return  PURPLE; break;
        case 7: return  BLACK;  break;
        case 8: return  BROWN;  break;
        default:return  BLANK;  break;
    }
}
-(void)setImage{
    switch (color) {
        case RED:   smallIMG = [UIImage imageNamed: @"red.png"];
                    largeIMG = [UIImage imageNamed: @"redButton.png"];
            break;
        case BLUE:  smallIMG = [UIImage imageNamed: @"blue.png"];
                    largeIMG = [UIImage imageNamed: @"blueButton.png"];
            break;
        case YELLOW:smallIMG = [UIImage imageNamed: @"yellow.png"];
                    largeIMG = [UIImage imageNamed: @"yellowButton.png"];
            break;
        case GREEN: smallIMG = [UIImage imageNamed: @"green.png"];
                    largeIMG = [UIImage imageNamed: @"greenButton.png"];
            break;
        case ORANGE:smallIMG = [UIImage imageNamed: @"orange.png"];
                    largeIMG = [UIImage imageNamed: @"orangeButton.png"];
            break;
        case PURPLE:smallIMG = [UIImage imageNamed: @"purple.png"];
                    largeIMG = [UIImage imageNamed: @"purpleButton.png"];
            break;
        case BROWN: smallIMG = [UIImage imageNamed: @"brown.png"];
                    largeIMG = [UIImage imageNamed: @"brownButton.png"];
            break;
        case BLACK: smallIMG = [UIImage imageNamed: @"black.png"];
                    largeIMG = [UIImage imageNamed: @"blackButton.png"];
                    hintIMG  = [UIImage imageNamed: @"hintBlack"];
            break;
        case WHITE: hintIMG  = [UIImage imageNamed: @"hintWhite.png"];
            break;
        case BLANK:
                    smallIMG = [UIImage imageNamed: @"default.png"];
                    largeIMG = [UIImage imageNamed: @"default.png"];
                    hintIMG  = [UIImage imageNamed: @"default.png"];
            break;
        default:    smallIMG = [UIImage imageNamed: @"default.png"];
                    largeIMG = [UIImage imageNamed: @"default.png"];
                    hintIMG  = [UIImage imageNamed: @"default.png"];
            break;
    }
}
-(void)setPegColor:(Color)c{
    color = c;
    [self setImage];
    [self setName];
}

-(Color)getPegColor{
    return color;
}

-(NSString*)getString{
    return strName;
}
-(void)setName{
    switch (color) {
        case RED:   strName = @"RED";   break;
        case BLUE:  strName = @"BLUE";  break;
        case YELLOW:strName = @"YELLOW";break;
        case GREEN: strName = @"GREEN"; break;
        case ORANGE:strName = @"ORANGE";break;
        case PURPLE:strName = @"PURPLE";break;
        case BLACK: strName = @"BLACK"; break;
        case BROWN: strName = @"BROWN"; break;
        case BLANK: strName = @"BLANK"; break;
        default:break;
    }
}
-(id) copyWithZone: (NSZone *) zone{
    Peg *pegCopy = [[[self class] allocWithZone: zone] init];
    pegCopy.color = color;
    pegCopy.strName = strName;
    pegCopy.smallIMG= smallIMG;
    pegCopy.largeIMG= largeIMG;
    pegCopy.hintIMG = hintIMG;
	
    return pegCopy;
}
-(id)initWithCoder: (NSCoder *) decoder{
    self = [super init];
    if( self != nil ){
        self.color = [decoder decodeIntForKey:@"kPegColor"];
        self.strName = [decoder decodeObjectForKey:@"kPegStringName"];
        self.smallIMG = [decoder decodeObjectForKey:@"kPegSmallImg"];
        self.largeIMG = [decoder decodeObjectForKey:@"kPegLargeImg"];
        self.hintIMG = [decoder decodeObjectForKey:@"kPegHintImg"];
    }
    return self;
}

-(void)encodeWithCoder: (NSCoder *) encoder{
    [encoder encodeInt:self.color forKey:@"kPegColor"];
    [encoder encodeObject:self.strName forKey:@"kPegStringName"];
    [encoder encodeObject:self.smallIMG forKey:@"kPegSmallImg"];
    [encoder encodeObject:self.largeIMG forKey:@"kPegLargeImg"];
    [encoder encodeObject:self.hintIMG forKey:@"kPegHintImg"];
}
@end
