/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * -------------------------------------------------
 * Peg.h
 * -------------------------------------------------
 * A peg is the individual color that makes up a code
 * - 8 possible colors for a peg.
 * - also contains image data for displaying on game board
 **/

#import <Foundation/Foundation.h>
typedef enum {
    RED,
    YELLOW,
    BLUE,
    ORANGE,
    GREEN,
    BLACK,
    PURPLE,
    BROWN,
    WHITE,
    BLANK
} Color;
@interface Peg : NSObject <NSCopying,NSCoding>{
        Color color;
        NSString *strName;
        UIImage *smallIMG;
        UIImage *largeIMG;
        UIImage *hintIMG;
    
}
@property()int colorLimit;
@property()NSString *strName;
@property()Color color;
@property(nonatomic,strong)UIImage *smallIMG;
@property(nonatomic,strong)UIImage *largeIMG;
@property(nonatomic,strong)UIImage *hintIMG;

-(id)init;
-(id)initWithColor: (Color)color;
-(id)initWithRandomColor;
-(Color)generateRandomColor;
-(Color)getPegColor;
-(void)setPegColor:(Color)color;
-(NSString*)getString;

-(id)copyWithZone:(NSZone*)Zone;
-(id)initWithCoder: (NSCoder *) decoder;
-(void)encodeWithCoder: (NSCoder *) encoder;
@end
