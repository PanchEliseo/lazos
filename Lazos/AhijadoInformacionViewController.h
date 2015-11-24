//
//  AhijadoInformacionViewController.h
//  Lazos
//
//  Created by sferea on 22/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMAhijado.h"

@interface AhijadoInformacionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *ahijadoFoto;
@property (weak, nonatomic) IBOutlet UILabel *ahijadoNombre;
@property (weak, nonatomic) IBOutlet UILabel *ahijadoNipEncabezado;
@property (weak, nonatomic) IBOutlet UILabel *ahijadoNipInformacion;
@property (weak, nonatomic) IBOutlet UILabel *ahijadoFilial;
@property (weak, nonatomic) IBOutlet UILabel *ahijadoFechaNacimiento;
@property (weak, nonatomic) IBOutlet UILabel *ahijadoEscuela;
@property (weak, nonatomic) IBOutlet UILabel *ahijadoNivelEscolar;
@property (weak, nonatomic) IBOutlet UILabel *ahijadoGradoGrupo;
@property (weak, nonatomic) IBOutlet UILabel *ahijadoCicloEscolar;
@property (weak, nonatomic) IBOutlet UILabel *ahijadoCalificacionEspanol;
@property (weak, nonatomic) IBOutlet UILabel *ahijadoCalificacionMatematicas;
@property (weak, nonatomic) IBOutlet UILabel *ahijadoCalificacionCiencias;
@property (weak, nonatomic) IBOutlet UILabel *ahijadoGustos;
@property (weak, nonatomic) IBOutlet UILabel *ahijadoTallaRopa;
@property (weak, nonatomic) IBOutlet UILabel *ahijadoTallaCalzado;

@end
