/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * -------------------------------------------------
 * HowToViewController.m
 * -------------------------------------------------
 * Instructions on how to play the game.
 * - Uses UIPageView to slide through steps
 * - Calls its child view to display the different steps
 **/

#import "HowToViewController.h"

@interface HowToViewController ()

@end

@implementation HowToViewController
@synthesize pageController;


- (void)viewDidLoad{
    
    [super viewDidLoad];
	self.navigationController.navigationBarHidden = YES;
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    CGRect rect = CGRectMake(0, 20, 320, 420);
    [[self.pageController view] setFrame:rect];
    
    HowToChildViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}

- (HowToChildViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    HowToChildViewController *childViewController = [[HowToChildViewController alloc] initWithNibName:@"HowToChildViewController" bundle:nil];
    childViewController.index = index;
    return childViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(HowToChildViewController *)viewController index];
    if (index == 0) {
        return nil;
    }
    // Decrease the index by 1 to return
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(HowToChildViewController *)viewController index];
    index++;
    if (index == 4) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 4;
}
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
