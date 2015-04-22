/**
 * Created by Mark Reventar on 2013-12-05.
 * Copyright (c) 2013 Reventar. All rights reserved.
 *
 * -------------------------------------------------
 * HowToChildViewController.h
 * -------------------------------------------------
 * View for each page of the instruction pages.
 * - change image in imageview depending on index
 *   controlled by HowToViewController
 **/

#import <UIKit/UIKit.h>

@interface HowToChildViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (assign, nonatomic) NSInteger index;
@end
