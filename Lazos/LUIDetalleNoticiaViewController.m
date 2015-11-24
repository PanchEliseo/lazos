//
//  LUIDetalleNoticiaViewController.m
//  Lazos
//
//  Created by Programacion on 9/11/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIDetalleNoticiaViewController.h"
#import "LManagerObject.h"
#import "UIImageView+WebCache.h"

@implementation LUIDetalleNoticiaViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Noticias"];
    
    //se obtienen las noticias de la base de datos
    NSLog(@"que traeeeee %@", self.noticia.id_noticia);
    [self addData];
    
}

-(void)addData{
    NSURL *url = [NSURL URLWithString:self.noticia.url_imagen];
    //se descarga la imagen con las clases del grupo de SBWebimage, que se encarga de la descarga de la imagen en segundo plano, asi como mantenerla en cache
    [self.imageNoticia sd_setImageWithURL:url placeholderImage:[UIImage alloc]];
    
    self.heightView.constant = 700;
    
    //se le da el formato requerido a la fecha
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:@"dd MMMM YYYY"];
    NSLog(@"la fecha %@ la hora %@", self.noticia.fecha, self.noticia.hora);
    NSString *resultDate = [formatter stringFromDate:self.noticia.fecha];
    
    //se le da el formato requerido a la hora considerando el formato completo: HH:mm:ss
    NSDateFormatter *formatterH = [[NSDateFormatter alloc]init];
    formatterH.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
    //HH para el formato de 24 horas
    [formatterH setDateFormat:@"HH:mm:ss"];
    NSDate * hour = [formatterH dateFromString:self.noticia.hora];
    NSLog(@"hour %@", hour);
    //se le da el formato requerido a la hora sin considerar segundos
    NSDateFormatter *formatterHora = [[NSDateFormatter alloc] init];
    formatterHora.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
    [formatterHora setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatterHora setDateFormat:@"HH:mm"];
    NSString *resultTime = [formatterHora stringFromDate:hour];
    NSLog(@"resultTime %@", resultTime);

    NSString *hora;
    if(![self.noticia.hora isEqualToString:@"00:00:00"]){
        hora = [NSString stringWithFormat:@"%@ hrs.", resultTime];
    }else{
        hora = @"";
    }
    NSString *fechaNoticia = [NSString stringWithFormat:@"%@%@%@", (resultDate?resultDate:@""), @" ", (hora?hora:@"")];
    
    //se carga la fecha en la pantalla
    self.fechaNoticia.text = fechaNoticia;
    //se agrega el titulo de la noticia a la pantalla
    self.textoNoticia.text = self.noticia.titulo;
    self.descripcionNoticia.text = self.noticia.noticia_descripcion;
    
    CGFloat width = self.descripcionNoticia.frame.size.width;
    NSLog(@"el tamaño del text %f", width);
    self.heightView.constant = width + 50;
    
}

@end