//
//  AhijadoRegaloContentViewController.m
//  Lazos
//
//  Created by sferea on 30/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AhijadoRegaloContentViewController.h"
#import "AhijadoRegaloDetalleMensajeViewController.h"
#import "LMPadrino.h"
#import "LManagerObject.h"
#import "AMPopTip.h"
#import "LConstants.h"
#import "ConfiguraLabel.h"

@interface AhijadoRegaloContentViewController ()
@property(strong, nonatomic) LMAhijado *ahijado;
@property(strong, nonatomic) LMPadrino *padrino;
@property (nonatomic, strong) AMPopTip *popTip;
@property (nonatomic) UIEdgeInsets edgeInsets;
@end

@implementation AhijadoRegaloContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///Se crea la variable de sesión que contiene el Nip del ahijado
    NSNumber *sesion = [[NSUserDefaults standardUserDefaults] objectForKey:@"LNipAhijado"];
    ///Consulta y trae de la base la información del ahijado pasándole el nip
    LManagerObject *store = [LManagerObject sharedStore];
    self.ahijado = [store shareNip:sesion];
    NSLog(@"Nombre del ahijado de la Base de datos en RegaloContent- nombre %@", self.ahijado.nombre_ahijado);
    NSArray *arrayPadrino = [store showData:@"LMPadrino"];
    self.padrino = [arrayPadrino objectAtIndex:0];
    NSLog(@"Nombre del padrino de la Base de datos en RegaloContent- nombre %@", self.padrino.name);
    [self addData];
    ///Agrega un borde redondeado a los botones de ‘Registrar regalo’
    self.botonRegistrarRegalo0.layer.cornerRadius = 5;
    self.botonRegistrarRegalo1.layer.cornerRadius = 5;
    self.botonRegistrarRegalo2.layer.cornerRadius = 5;
    self.botonRegistrarRegalo3.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)addData {
    ///Se agrega el nombre del padrino en la pantalla debajo de "Tu nombre completo:"
    self.padrinoNombre.text = [NSString stringWithFormat:@"%@%@%@", self.padrino.name, @" ", self.padrino.apellidos];
    NSLog(@"Impresión Nombre - en AhijadoRegaloContent, pantalla de cómo entregar regalo %@", self.padrino.name);
    NSLog(@"Impresión Apellidos - en AhijadoRegaloContent, pantalla de cómo entregar regalo %@", self.padrino.apellidos);
    
    ///Se agrega el nip del padrino en la pantalla debajo de "Tu nip de Padrino:"
    self.padrinoNip.text = [NSString stringWithFormat:@"%@", self.padrino.nip_godfather];
    NSLog(@"Impresión de NIP en AhijadoRegaloContent, pantalla de cómo entregar regalo %@", self.padrino.nip_godfather);
}

///Método que al dar click en el botón de "Registrar regalo" hace segue a la pantalla donde se redacta la descripción del regalo
- (IBAction)actionShow:(id)sender {
    [self.parentViewController.parentViewController performSegueWithIdentifier:@"segueRegistraRegalo" sender:self.parentViewController.parentViewController];
    NSLog(@"Realiza la transición a Registrar regalo tras presionar el botón");
}


/**
 Método que se encarga de mostrar los regalos sugeridos
 */

- (IBAction)muestraSugerencia:(UIButton*)sender event:(UIEvent*)event
{
    [self.popTip hide];
    
    ///Se crea un style para que el texto que debe alinearse al centro
    NSMutableParagraphStyle *paragraphStyleCenter = NSMutableParagraphStyle.new;
    paragraphStyleCenter.alignment = NSTextAlignmentCenter;
    ///Se crea un style para que el texto que debe alinearse a la izquierda
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    if(sender.tag == 1){
        if(self.popTip == nil) {
            self.popTip = [AMPopTip popTip];
            [self estableceFormatoEnPopTip];
            
            ///Se le indica que el origen se mueva hacia a la mitad del eje Y del botón: Escolares
            self.popTip.offset = CGRectGetMinY(self.boton1Escolares.frame);
            
            ///Establece el texto y su formato de la sección: Escolares
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:@"\u2022 Libros adecuados para su edad, de fácil lectura y con mensajes positivos.\n\n\u2022 Libros para colorear o recortar.\n\n\u2022 Artículos que faciliten sus actividades escolares.\n\n\u2022 Juegos educativos que refuercen su aprendizaje." attributes:@{ NSFontAttributeName: [UIFont fontWithName:@"Arial" size:12], NSForegroundColorAttributeName: [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:133.0/255.0 alpha:1], NSParagraphStyleAttributeName:paragraphStyle}];
            
            ///Muestra la ventana
            [self.popTip showAttributedText:attributedText direction:AMPopTipDirectionDown maxWidth:270 inView:self.vistaContenido fromFrame:self.vistaEscolares.frame];
            
        }else{
            self.popTip = nil;
        }
    }else if(sender.tag == 2){
        if(self.popTip == nil) {
            self.popTip = [AMPopTip popTip];
            [self estableceFormatoEnPopTip];
            
            ///Se le indica que el origen se mueva hacia a la mitad del eje Y del botón: Juegos
            self.popTip.offset = CGRectGetMinY(self.boton2Juegos.frame);
            
            ///Establece el texto y su formato de la sección: Juegos
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:@"\u2022 Juegos de mesa que motiven el trabajo colaborativo.\n\n\u2022 Kits de arte que estimulen la creatividad.\n\n\u2022 Juguetes que promuevan la actividad física.\n\n\u2022 Juguetes que no promuevan la violencia.\n\n\u2022 Juguetes que no dependan de electricidad o baterías." attributes:@{ NSFontAttributeName: [UIFont fontWithName:@"Arial" size:12], NSForegroundColorAttributeName: [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:133.0/255.0 alpha:1], NSParagraphStyleAttributeName:paragraphStyle}];
            
            ///Muestra la ventana
            [self.popTip showAttributedText:attributedText direction:AMPopTipDirectionDown maxWidth:270 inView:self.vistaContenido fromFrame:self.vistaJuegos.frame];
            
        }else{
            self.popTip = nil;
        }
    }else if(sender.tag == 3){
        if(self.popTip == nil) {
            self.popTip = [AMPopTip popTip];
            [self estableceFormatoEnPopTip];
            
            ///Se le indica que el origen se mueva hacia a la mitad del eje Y del botón: Juegos
            self.popTip.offset = CGRectGetMinY(self.boton3RopaCalzado.frame);
            
            ///Establece el texto y su formato de la sección:
            ///Se crean estos arreglos que le dan atributos a los strings para darle un formato como el que se encuentra en el road map
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:@"\u2022 Ropa adecuada para su edad y género.\n\n\u2022 Calzado escolar y/o deportivo.\n\n" attributes:@{ NSFontAttributeName: [UIFont fontWithName:@"Arial" size:12], NSForegroundColorAttributeName: [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:133.0/255.0 alpha:1], NSParagraphStyleAttributeName:paragraphStyle}];
            
            [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"(No olvides validar las tallas de tu ahijado en la sección \"Mis ahijados\")" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial" size:12], NSForegroundColorAttributeName: [UIColor colorWithRed:170/255 green:170/255 blue:170/255 alpha:1], NSParagraphStyleAttributeName:paragraphStyle}]];
            
            ///Muestra la ventana
            [self.popTip showAttributedText:attributedText direction:AMPopTipDirectionDown maxWidth:270 inView:self.vistaContenido fromFrame:self.vistaRopa.frame];
            
        }else{
            self.popTip = nil;
        }
    }else if(sender.tag == 4){
        if(self.popTip == nil) {
            
            self.popTip = [AMPopTip popTip];
            [self estableceFormatoEnPopTip];
            ///Se le indica que el origen se mueva hacia a la mitad del eje Y del botón: Juegos
            self.popTip.offset = CGRectGetMinY(self.boton4Dulces.frame);
            
            ///Establece el texto y su formato de la sección: Juegos
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:@"\u2022 En Lazos promovemos la adecuada alimentación de tu ahijado, por ello si deseas, puedes acompañar tu regalo con una pequeña porción de dulces de fácil manejo, no perecederos." attributes:@{ NSFontAttributeName: [UIFont fontWithName:@"Arial" size:12], NSForegroundColorAttributeName: [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:133.0/255.0 alpha:1], NSParagraphStyleAttributeName:paragraphStyleCenter}];
            
            ///Muestra la ventana
            [self.popTip showAttributedText:attributedText direction:AMPopTipDirectionDown maxWidth:270 inView:self.vistaContenido fromFrame:self.vistaDulces.frame];
            
            CGFloat width = [UIScreen mainScreen].bounds.size.width;
            CGFloat height = [UIScreen mainScreen].bounds.size.height;
            NSLog(@"el ancho %lu", (long)width);
            NSLog(@"el alto %lu", (long)height);
            
        }else{
            self.popTip = nil;
        }
    }
}

///Establece el formato de los PopTips
-(void)estableceFormatoEnPopTip {
    ///Establece el fondo blanco con texto color azul
    self.popTip.popoverColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
    self.popTip.textColor = [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:133.0/255.0 alpha:1];
    ///Establece tamaño del borde y color
    self.popTip.borderWidth = 1;
    self.popTip.borderColor = [UIColor grayColor];
    ///Agrega espaciado a las orillas
    self.popTip.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
}

@end