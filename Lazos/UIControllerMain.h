//
//  UIControllerMain.h
//  Lazos
//
//  Created by Programacion on 9/8/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "LMPadrino.h"

@interface UIControllerMain : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *arrayMenu;
@property (strong, nonatomic) NSArray *arrayImage;
@property (strong, nonatomic) NSArray *arrayImageSelect;
@property (strong, nonatomic) NSArray *dataBase;

@end
