//
//  LUIViewControllerDetalleMensajeEnviados.m
//  Lazos
//
//  Created by Programacion on 10/2/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerDetalleMensajeEnviados.h"
#import "LManagerObject.h"
#import "LMAhijado.h"
#import "LUIViewControllerEstatus.h"
#import "LUIviewControllerEstatusRegalos.h"
@interface LUIViewControllerDetalleMensajeEnviados()

@property(strong, nonatomic)LMBuzon *buzon;
@property(strong, nonatomic)NSNumber *sesionId;
@property(strong, nonatomic)NSString *tipo;

@end

@implementation LUIViewControllerDetalleMensajeEnviados

-(void)viewDidLoad{
    
    [super viewDidLoad];
    //se obtiene el ide de la carata enviada, de las preferencias del telefono
    self.sesionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"idBuzon"];
    NSLog(@"en el detalle %@", self.sesionId);
    NSString *idBuzon = [NSString stringWithFormat:@"%@", self.sesionId];
    LManagerObject *store = [LManagerObject sharedStore];
    self.buzon = [store shareIdBuzon:idBuzon];
    [self addDataView];
    /*if([self.buzon.tipo isEqualToString:@"Cartas"]){
        [self addDataView];
    }else{
        //crear el estatus del regalos
    }*/
    
}

/**
 Metodo que agrega la informacion requerida a la pantalla
 */
-(void)addDataView{
    
    //se obtiene de las preferencias el nip del ahijado
    NSNumber *sesionNip = [[NSUserDefaults standardUserDefaults] objectForKey:@"LNipAhijado"];
    NSLog(@"el nip del ahijado %@", sesionNip);
    //se instancia el manejoador de la base de datos
    LManagerObject *store = [LManagerObject sharedStore];
    //se obtienen el ahijado por el nip guardado
    LMAhijado *ahijado = [store shareNip:sesionNip];
    //se da a la vista el texto de la carta
    self.nombreAhijado.text = ahijado.nombre_ahijado;
    NSString *apellidos = [NSString stringWithFormat:@"%@%@%@", ahijado.apellido_paterno_ahijado, @" " , ahijado.apellido_materno_ahijado];
    self.apellidosAhijado.text = apellidos;
    self.descripcionCarta.text = self.buzon.descripcion;
    
    ///Se le da el formato requerido a la fecha
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate * date = [formatter dateFromString:self.buzon.fecha_buzon];
    //se le da el formato requerido a la fecha del envio de la carta
    NSDateFormatter *formatterFecha = [[NSDateFormatter alloc] init];
    formatterFecha.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
    [formatterFecha setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatterFecha setDateFormat:@"dd/MMMM/YYYY"];
    NSString *fechaEnvio = [formatterFecha stringFromDate:date];
    self.fechaCarta.text = fechaEnvio;
    //se le da el formato requerido a la hora
    NSDateFormatter *formatterHora = [[NSDateFormatter alloc] init];
    [formatterHora setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatterHora setDateFormat:@"HH:mm a"];
    NSDate * hour = [formatter dateFromString:self.buzon.fecha_buzon];
    NSString *horaEnvio = [formatterHora stringFromDate:hour];
    self.horaCarta.text = [NSString stringWithFormat:@"%@%@", horaEnvio, @" hrs."];
    NSLog(@"Imprime fecha de envio %@",horaEnvio);
    
    NSString *nameCadena = self.buzon.nombre;
    //se busca en la cadena los que estan separados por el caracter para obtener en la segunda posicion el nip del ahijado y el numero de plantilla
    NSArray *arraySeparate = [nameCadena componentsSeparatedByString:@" "];
    NSString *numeroPlantilla;
    for(int cont=0; cont<[arraySeparate count]; cont++){
        NSLog(@"que locoooooo %d *** %@", cont, [arraySeparate objectAtIndex:cont]);
        if(cont == 7){
            //se guarda en un nuevo arreglo el nip de padrino y la plantilla, para despues separarlos y utilizar cada dato
            numeroPlantilla = [arraySeparate objectAtIndex:cont];
        }
    }
    NSLog(@"que tiene la plantilla %@", numeroPlantilla);
    if([numeroPlantilla isEqualToString:@"1"]) {
        self.imagenPlantilla.image = [UIImage imageNamed:@"ic_image_plantilla_papalote.png"];
    }else if([numeroPlantilla isEqualToString:@"2"]){
        self.imagenPlantilla.image = [UIImage imageNamed:@"ic_image_plantilla_muneca.png"];
    }else if([numeroPlantilla isEqualToString:@"3"]){
        self.imagenPlantilla.image = [UIImage imageNamed:@"ic_image_plantilla_robot.png"];
    }else if([numeroPlantilla isEqualToString:@"4"]){
        self.imagenPlantilla.image = [UIImage imageNamed:@"ic_image_plantilla_avion.png"];
    }
    
}

/**
 Metodo que se encarga de realizar la accion de enviar a la siguiente pantalla al pulsar el boton de estatus
 */
- (IBAction)actionShow:(id)sender {
    if([self.buzon.tipo isEqualToString:@"Cartas"]){
        [self performSegueWithIdentifier:@"segueCartas" sender:self];
    }else{
        [self performSegueWithIdentifier:@"segueRegalos" sender:self];
    }
}

/**
 Metodo que envia informacion a la siguiente pantalla por el metodo del seague
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"entra al metodo del seague?");
    if([self.buzon.tipo isEqualToString:@"Cartas"]){
        LUIViewControllerEstatus *estatus = [segue destinationViewController];
        estatus.estatus = self.buzon.estatus;
    }else{
        LUIviewControllerEstatusRegalos *estatus = [segue destinationViewController];
        estatus.estatus = self.buzon.estatus;
    }
}

@end