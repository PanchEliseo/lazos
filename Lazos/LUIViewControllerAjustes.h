//
//  LUIViewControllerAjustes.h
//  Lazos
//
//  Created by Programacion on 10/16/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUIViewControllerAjustes : UIViewController

//propiedades de la clase
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthView;
@property (weak, nonatomic) IBOutlet UILabel *tipoPadrino;
@property (weak, nonatomic) IBOutlet UILabel *nombre;
@property (weak, nonatomic) IBOutlet UILabel *apellidos;
@property (weak, nonatomic) IBOutlet UILabel *nip;
@property (weak, nonatomic) IBOutlet UISwitch *estatusCartasRegalos;
@property (weak, nonatomic) IBOutlet UISwitch *actualizacion;
@property (weak, nonatomic) IBOutlet UISwitch *pagos;
@property (weak, nonatomic) IBOutlet UIButton *cerrarSesion;

- (IBAction)toggleAction:(UISwitch*)sender;
- (IBAction)logout:(id)sender;

@end
