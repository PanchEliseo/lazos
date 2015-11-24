//
//  LUIViewControllerDetalleMensajeRecibidos.m
//  Lazos
//
//  Created by Carlos molina on 11/11/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerDetalleMensajeRecibidos.h"
#import "LManagerObject.h"
#import "LMBuzonRecibidos.h"
#import "UIImageView+WebCache.h"

@implementation LUIViewControllerDetalleMensajeRecibidos

- (void)viewDidLoad {
    [super viewDidLoad];
    LManagerObject *store = [LManagerObject sharedStore];
    //se obtiene el padrino de la base
    NSArray *recibidos = [store showData:@"LMBuzonRecibidos"];
    LMBuzonRecibidos *recibidosBuzon = [recibidos objectAtIndex:0];
    NSLog(@"que tieneneenenen %@", recibidosBuzon.id_buzon);
    
    self.nombresRecibidos.text = recibidosBuzon.nombre_ahijado;
    self.apellidosRecibidos.text = recibidosBuzon.apellido_ahijado;
    ///Se le da el formato requerido a la fecha
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate * date = [formatter dateFromString:recibidosBuzon.fecha];
    NSLog(@"fecha recibido %@", recibidosBuzon.fecha);

    //se le da el formato requerido a la fecha del envio de la carta
    NSDateFormatter *formatterFecha = [[NSDateFormatter alloc] init];
    formatterFecha.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
    [formatterFecha setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatterFecha setDateFormat:@"dd/MMMM/YYYY"];
    NSString *fechaEnvio = [formatterFecha stringFromDate:date];
    self.fechaRecibidos.text = fechaEnvio;
    
    //se le da el formato requerido a la hora
    NSLog(@"fecha recibido %@", recibidosBuzon.hora);
    NSDateFormatter *formatterHora = [[NSDateFormatter alloc] init];
    formatterFecha.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
    [formatterHora setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatterHora setDateFormat:@"HH:mm"];
    NSString *horaEnvio = [formatterHora stringFromDate:date];
    self.horaRecibidos.text = [NSString stringWithFormat:@"%@%@", horaEnvio, @" hrs."];
    
    //aqui descomentar para colocar la imagen del json
    //NSURL *url = [NSURL URLWithString:recibidosBuzon.url_imagen_respuesta];
    //[self.imageCarta sd_setImageWithURL:url placeholderImage:[UIImage alloc]];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end