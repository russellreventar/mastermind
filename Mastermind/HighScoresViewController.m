/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * -------------------------------------------------
 * HighScoresViewController.m
 * -------------------------------------------------
 * List of all games completed.
 * - Show time it took to complete, amount of tries, code and user
 **/

#import "HighScoresViewController.h"

@interface HighScoresViewController ()

@end

@implementation HighScoresViewController
@synthesize games;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initialize];
}
-(void) initialize{
    model = [[Model alloc]init];
    games = [[NSMutableArray alloc]initWithArray:[model loadGames]];
    self.title = @"High Scores";
    [self sortScores];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return games.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"HighScoresCell";
    HighScoresCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HighScoresCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.userLabel.text = [[games objectAtIndex:indexPath.row]getUser];
    cell.placeLabel.text = [NSString stringWithFormat:@"%d", (indexPath.row + 1)];

    int y = 28;
    int x = 125;
    int orbSize = 13;
    
    CGRect frame = CGRectMake(x, y, 11, 11);
    
    UIImageView *iv = [[UIImageView alloc] initWithImage: [[[games objectAtIndex:indexPath.row]getCode] getPeg:0].smallIMG];
    UIImageView *iv2 = [[UIImageView alloc] initWithImage: [[[games objectAtIndex:indexPath.row]getCode] getPeg:1].smallIMG];
    UIImageView *iv3 = [[UIImageView alloc] initWithImage: [[[games objectAtIndex:indexPath.row]getCode] getPeg:2].smallIMG];
    UIImageView *iv4 = [[UIImageView alloc] initWithImage: [[[games objectAtIndex:indexPath.row]getCode] getPeg:3].smallIMG];
    
    
    iv.frame = CGRectMake(frame.origin.x - frame.size.width, frame.origin.y - frame.size.height, orbSize, orbSize);
    iv2.frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y - frame.size.height, orbSize, orbSize);
    iv3.frame = CGRectMake(frame.origin.x - frame.size.width, frame.origin.y + frame.size.height, orbSize, orbSize);
    iv4.frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y +frame.size.height, orbSize, orbSize);
    
    [cell addSubview:iv];
    [cell addSubview:iv2];
    [cell addSubview:iv3];
    [cell addSubview:iv4];
    
    if([[games objectAtIndex:indexPath.row] getTime] <=60){
    cell.timeLabel.text = [NSString stringWithFormat:@"%d s",[[games objectAtIndex:indexPath.row] getTime]];
    }else{
        cell.timeLabel.text = [NSString stringWithFormat:@"%dm %ds",([[games objectAtIndex:indexPath.row] getTime] / 60),([[games objectAtIndex:indexPath.row] getTime] % 60)];
    }
    cell.attemptsLabel.text = [NSString stringWithFormat:@"%d",[[games objectAtIndex:indexPath.row] getAttempts]];

    
    return cell;
}

-(void) sortScores{
    [games sortUsingDescriptors: [NSArray arrayWithObjects:
                                   [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES], nil]];
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewDidDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
@end
