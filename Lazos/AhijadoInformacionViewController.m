//
//  AhijadoInformacionViewController.m
//  Lazos
//
//  Created by sferea on 22/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AhijadoInformacionViewController.h"
#import "UIImageView+WebCache.h"
#import "LManagerObject.h"
#import "LMAhijado.h"

@interface AhijadoInformacionViewController ()
@property (strong, nonatomic)LMAhijado *ahijado;
@end

@implementation AhijadoInformacionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    //se le pone el nombre al navigation al momento que aparece
    [self.parentViewController.parentViewController.navigationItem setTitle:@"Mis ahijados"];
    
    [self addData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)addData{
    CGFloat boldTextFontSize = 17.0f;
    
    NSNumber *sesion = [[NSUserDefaults standardUserDefaults] objectForKey:@"LNipAhijado"];
    NSLog(@"variable de sesion - nip %@", sesion);
    LManagerObject *ahijadoDetalle = [LManagerObject sharedStore];
    self.ahijado = [ahijadoDetalle shareNip:sesion];
    NSLog(@"Nombre ahijado de Base de datos nombre: %@, nip: %@", self.ahijado.nombre_ahijado, self.ahijado.nip_ahijado);
    ///Agrega la imagen a la vista utilizando la url del json, se le concatena la ip del servidor
    NSString *ipServidorLazos = @"http://201.175.10.244/";
    NSLog(@"Url Foto de ahijado 1: %@", self.ahijado.foto_ahijado);
    NSString *urlCompleta = [NSString stringWithFormat:@"%@%@", ipServidorLazos, self.ahijado.foto_ahijado];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", urlCompleta]];
    NSLog(@"Url Foto de ahijado %@", url);
    //se descarga la imagen con las clases del grupo de SBWebimage, que se encarga de la descarga de la imagen en segundo plano, asi como mantenerla en cache
    [self.ahijadoFoto sd_setImageWithURL:url placeholderImage:[UIImage alloc]];
    
    ///Se agrega el nombre y nip del ahijado
    self.ahijadoNombre.text = [NSString stringWithFormat:@"%@%@%@%@%@", (self.ahijado.nombre_ahijado?self.ahijado.nombre_ahijado:@""), @" ", (self.ahijado.apellido_materno_ahijado?self.ahijado.apellido_materno_ahijado:@""), @" ", (self.ahijado.apellido_paterno_ahijado?self.ahijado.apellido_paterno_ahijado:@"")];
    //Concatenación de prueba
    //self.ahijadoNombre.text = [NSString stringWithFormat:@"%@%@%@%@%@", @"ADADDDSFFAFAF", @" ", @"FAFAFSDADSFAA", @" ", @"EEFEEF"];
    ///Da formato de negritas al nombre de pila del ahijado
    NSRange range1 = [self.ahijadoNombre.text rangeOfString:self.ahijado.nombre_ahijado];
    //Formato de prueba
    //NSRange range1 = [self.ahijadoNombre.text rangeOfString:@"ADADDDSFFAFAF"];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self.ahijadoNombre.text];
    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                            range:range1];
    self.ahijadoNombre.attributedText = attributedText;
    
    ///Agrega el Nip al encabezado de la vista
    self.ahijadoNipEncabezado.text = (self.ahijado.nip_ahijado?self.ahijado.nip_ahijado:@"");
    
    ///Agrega el Nip a la sección de información de la vista
    self.ahijadoNipInformacion.text = (self.ahijado.nip_ahijado?self.ahijado.nip_ahijado:@"");
    
    ///Agrega la filial a la vista
    self.ahijadoFilial.text=(self.ahijado.filial?self.ahijado.filial:@"");
    
    ///Se le da el formato requerido a la fecha
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:@"YYYY MMMM dd"];
    ///Agrega la fecha de nacimiento a la vista
    if(self.ahijado.fecha_nacimiento_ahijado)
        self.ahijadoFechaNacimiento.text = [formatter stringFromDate: self.ahijado.fecha_nacimiento_ahijado];
    else
        self.ahijadoFechaNacimiento.text = @"";
    
    ///Agrega el Nombre de escuela a la vista
    self.ahijadoEscuela.text = (self.ahijado.nombre_escuela?self.ahijado.nombre_escuela:@"");
    
    ///Agrega el Nivel escolar a la vista
    self.ahijadoNivelEscolar.text = (self.ahijado.nivel?self.ahijado.nivel:@"");
    
    ///Agrega el Grado y grupo a la vista
    self.ahijadoGradoGrupo.text = [NSString stringWithFormat:@"%@%@%@", (self.ahijado.grado?self.ahijado.grado:@""), @"-", (self.ahijado.grupo?self.ahijado.grupo:@"")];
    
    ///Agrega el Ciclo escolar a la vista
    ///Ejemplo: Ciclo escolar 2014 - 2015
    NSLog(@"el ciclo %@", self.ahijado.ciclo_escolar);
    if(self.ahijado.ciclo_escolar)
        self.ahijadoCicloEscolar.text = [NSString stringWithFormat:@"Ciclo escolar %@", self.ahijado.ciclo_escolar];
    else
        ///En caso de no tener el Ciclo escolar imprime vacío
        self.ahijadoCicloEscolar.text = @"";
    
    ///Agrega la calificación de español a la vista
    NSLog(@"Que imprimira en calificacion de español: %@", self.ahijado.calificacion_espanol);
    NSString *espanol = [NSString stringWithFormat:@"%@", (self.ahijado.calificacion_espanol?self.ahijado.calificacion_espanol:@"")];
    if(![espanol isEqualToString:@"0"])
        self.ahijadoCalificacionEspanol.text = espanol;
    
    ///Agrega la calificación de matemáticas a la vista
    NSString *matematicas = [NSString stringWithFormat:@"%@", (self.ahijado.calificacion_matematicas?self.ahijado.calificacion_matematicas:@"")];
    if(![matematicas isEqualToString:@"0"])
        self.ahijadoCalificacionMatematicas.text = matematicas;
    
    ///Agrega la calificación de ciencias a la vista
    NSString *ciencias = [NSString stringWithFormat:@"%@", (self.ahijado.calificacion_ciencias?self.ahijado.calificacion_ciencias:@"")];
    if(![ciencias isEqualToString:@"0"])
        self.ahijadoCalificacionCiencias.text = ciencias;
    
    ///Agrega los gustos a la vista
    self.ahijadoGustos.text = (self.ahijado.gustos?self.ahijado.gustos:@"");
    
    ///Agrega la talla de ropa a la vista
    NSString *talla_ropa = [NSString stringWithFormat:@"%@", (self.ahijado.talla_ropa?self.ahijado.talla_ropa:@"")];
    self.ahijadoTallaRopa.text = talla_ropa;
    
    ///Agrega la talla de calzado a la vista
    NSString *talla_calzado = [NSString stringWithFormat:@"%@", (self.ahijado.talla_calzado?self.ahijado.talla_calzado:@"")];
    if(![talla_calzado isEqualToString:@"0"])
        self.ahijadoTallaCalzado.text = talla_calzado;
}

@end
