//
//  LFooterCell.h
//  Lazos
//
//  Created by Programacion on 9/10/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface LFooterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageFooter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *espacioIzquierda;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *espacioDerecha;

@end

