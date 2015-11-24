//
//  BuzonCartaTableViewCell.h
//  Lazos
//
//  Created by sferea on 21/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface BuzonCartaTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *tituloCarta;
@property (weak, nonatomic) IBOutlet UILabel *descripcionCarta;
@property (weak, nonatomic) IBOutlet UILabel *fechaCarta;
@property (weak, nonatomic) IBOutlet UIImageView *imagenAhijadoCarta;

@end
