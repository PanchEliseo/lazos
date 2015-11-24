//
//  LUIViewControllerMensajes.h
//  Lazos
//
//  Created by Programacion on 9/22/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUIViewControllerMensajes : UIViewController<UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) UIViewController *viewController;

@end