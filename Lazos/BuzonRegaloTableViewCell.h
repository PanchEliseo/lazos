//
//  BuzonRegaloTableViewCell.h
//  Lazos
//
//  Created by sferea on 18/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuzonRegaloTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bRegaloFoto;
@property (weak, nonatomic) IBOutlet UILabel *bRegaloSaludo;
@property (weak, nonatomic) IBOutlet UILabel *bRegaloFecha;
@property (weak, nonatomic) IBOutlet UILabel *bRegaloMensaje;

@end
