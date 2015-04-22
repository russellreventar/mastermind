/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * -------------------------------------------------
 * HowToChildViewController.m
 * -------------------------------------------------
 * View for each page of the instruction pages.
 * - change image in imageview depending on index
 *   controlled by HowToViewController
 **/

#import "HowToChildViewController.h"

@interface HowToChildViewController ()

@end

@implementation HowToChildViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"howto%d.png", (self.index +1)]];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end

