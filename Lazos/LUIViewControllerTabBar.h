//
//  LUIViewControllerTabBar.h
//  Lazos
//
//  Created by Programacion on 9/14/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUIViewControllerTabBar : UITabBarController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (strong, nonatomic)NSString *tipo;

@end
