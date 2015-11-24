//
//  ViewController.h
//  Lazos
//
//  Created by Programacion on 8/27/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface ViewController : UIViewController<UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;
@property (strong, nonatomic) UIViewController *principalMenuController;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) SWRevealViewController *revealViewController;

@end

