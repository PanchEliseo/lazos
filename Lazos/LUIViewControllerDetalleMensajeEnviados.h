//
//  LUIViewControllerDetalleMensajeEnviados.h
//  Lazos
//
//  Created by Programacion on 10/2/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUIViewControllerDetalleMensajeEnviados : UIViewController

@property(strong, nonatomic) IBOutlet UILabel *nombreAhijado;
@property (weak, nonatomic) IBOutlet UILabel *apellidosAhijado;
@property (weak, nonatomic) IBOutlet UILabel *fechaCarta;
@property (weak, nonatomic) IBOutlet UILabel *horaCarta;
@property (weak, nonatomic) IBOutlet UITextView *descripcionCarta;
@property (weak, nonatomic) IBOutlet UIImageView *imagenPlantilla;

@end