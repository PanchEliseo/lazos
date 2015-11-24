//
//  BuzonEnviadosViewController.h
//  Lazos
//
//  Created by sferea on 18/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuzonEnviadosViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *tableView;
@property (strong, nonatomic) NSDictionary *response;
@property (strong, nonatomic) NSDictionary *responseAhijados;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSString *tipoMenu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintButton;
@end
