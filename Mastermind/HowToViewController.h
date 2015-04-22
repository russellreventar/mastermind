/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * ---------------------------------------
 * HowToViewController.h
 * ---------------------------------------
 * Instructions on how to play the game. 
 **/

#import <UIKit/UIKit.h>
#import "HowToChildViewController.h"
@interface HowToViewController : UIViewController<UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageController;

@end
