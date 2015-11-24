//
//  AhijadoRegaloContentViewController.h
//  Lazos
//
//  Created by sferea on 30/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AhijadoRegaloContentViewController : UIViewController

///Almacena el número de la página o page index
@property NSUInteger pageIndex;

///Botones para registrar el regalo
@property (weak, nonatomic) IBOutlet UIButton *botonRegistrarRegalo0;
@property (weak, nonatomic) IBOutlet UIButton *botonRegistrarRegalo1;
@property (weak, nonatomic) IBOutlet UIButton *botonRegistrarRegalo2;
@property (weak, nonatomic) IBOutlet UIButton *botonRegistrarRegalo3;

///Botones y vistas en la que se mostrarán los PopTip
@property (weak, nonatomic) IBOutlet UIButton *boton1Escolares;
@property (weak, nonatomic) IBOutlet UIButton *boton2Juegos;
@property (weak, nonatomic) IBOutlet UIButton *boton3RopaCalzado;
@property (weak, nonatomic) IBOutlet UIButton *boton4Dulces;

@property (weak, nonatomic) IBOutlet UIView *vistaEscolares;
@property (weak, nonatomic) IBOutlet UIView *vistaRopa;
@property (weak, nonatomic) IBOutlet UIView *vistaDulces;
@property (weak, nonatomic) IBOutlet UIView *vistaJuegos;
@property (weak, nonatomic) IBOutlet UIView *vistaContenido;

///Información para el padrino con la que se debe identificar el regalo
@property (weak, nonatomic) IBOutlet UILabel *padrinoNombre;
@property (weak, nonatomic) IBOutlet UILabel *padrinoNip;
@end
