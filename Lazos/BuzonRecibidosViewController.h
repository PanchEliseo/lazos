//
//  BuzonRecibidosViewController.h
//  Lazos
//
//  Created by sferea on 28/10/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuzonRecibidosViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSDictionary *response;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintButton;
@property (strong, nonatomic) NSString *tipoMenu;
@end
