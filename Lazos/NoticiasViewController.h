//
//  NoticiasViewController.h
//  Lazos
//
//  Created by sferea on 04/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticiasViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

///Botón superior para acceder al menú
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end