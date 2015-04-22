/**
 * Created by Mark Reventar on 2013-12-05.
 * 100 429 397
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * ---------------------------------------
 * MainMenuViewController.m
 * ---------------------------------------
 * Game index. Navigate to different views from here
 **/

#import "MainMenuViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

-(void) viewDidLoad{
    [super viewDidLoad];
}
-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
-(void) viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

@end
