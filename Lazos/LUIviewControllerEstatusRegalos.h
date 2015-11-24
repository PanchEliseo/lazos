//
//  LUIviewControllerEstatusRegalos.h
//  Lazos
//
//  Created by Programacion on 10/2/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUIviewControllerEstatusRegalos : UIViewController

@property(strong, nonatomic)NSString *estatus;
@property (weak, nonatomic) IBOutlet UIImageView *imagenEstatus1;
@property (weak, nonatomic) IBOutlet UIImageView *imagenEstatus2;
@property (weak, nonatomic) IBOutlet UIImageView *imagenEstatus3;
@property (weak, nonatomic) IBOutlet UIImageView *imagenRegaloEstatus1;
@property (weak, nonatomic) IBOutlet UIImageView *imagenRegaloEstatus2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightWiew;

@end
