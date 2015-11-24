//
//  LUIViewControllerDetalleMensajeRecibidos.h
//  Lazos
//
//  Created by Carlos molina on 11/11/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUIViewControllerDetalleMensajeRecibidos : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nombresRecibidos;
@property (weak, nonatomic) IBOutlet UILabel *apellidosRecibidos;
@property (weak, nonatomic) IBOutlet UILabel *fechaRecibidos;
@property (weak, nonatomic) IBOutlet UILabel *horaRecibidos;
@property (weak, nonatomic) IBOutlet UIImageView *imageCarta;

@end
