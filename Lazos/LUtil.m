//
//  LUtil.m
//  Lazos
//
//  Created by Programacion on 9/10/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUtil.h"
#import "LConstants.h"

@implementation LUtil

/**
 *@brief metodo que instancia la clase
 *@return la clase instanciada
 */
+ (LUtil *)instance {
    static LUtil *store;
    if (store == nil) {
        store = [[LUtil alloc] init];
    }
    return store;
}

/**
 *@brief metodo que calcula el nivel del padrino
 *@return un string con el nivel del padrino
 */
-(NSString *)calculateDateLevel:(NSDate *)date{
    //se obtiene la fecha actual
    NSDate *today = [NSDate date];
    NSLog(@"fecha actual %@", today);
    NSLog(@"fecha del padrino %@", date);
    //se crea una fecha de tipo calendar
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    //se obtienen unidades que se van a calcular
    NSUInteger units = NSYearCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit;
    //se realizan los calculos entre las fechas
    NSDateComponents *components = [gregorian components:units fromDate:date toDate:today options:0];
    
    //se obtienen los dias, meses y años que hay de diferencia entre las dos fechas
    NSInteger years = [components year];
    NSInteger months = [components month];
    NSInteger days = [components day];
    NSLog(@"años: %ld meses: %ld dias: %ld", (long)years, (long)months, (long)days);
    //sacando los meses con la fecha que se hizo padrino y la fecha actual
    NSInteger fechaNivel = (years*12) + months;
    NSLog(@"los meses obtenidos segun la fecha que entro el padrino %ld", (long)fechaNivel);
    NSString *tipoNivel = @"";
    if(fechaNivel < 12){
        tipoNivel = @"Junior";
    }else if(fechaNivel >= 12 && fechaNivel <= 24){
        tipoNivel = @"Senior";
    }else if(fechaNivel >= 24 && fechaNivel <= 36){
        tipoNivel = @"Master";
    }else if(fechaNivel > 36){
        tipoNivel = @"Elite";
    }
    
    NSLog(@"Fecha pasada a calculateDateLevel:%@", date);
    
    return tipoNivel;
}

/**
 *@brief metodo que se utiliza para obtener el padrino de la base de datos local del dispositivo
 *@ return el modelo con los datos del padrino
 */
-(LMPadrino*)oftenPadrino{
    //se hace la peticion al webservice de ahijados
    LManagerObject * store = [LManagerObject sharedStore];
    NSArray * arregloPadrino = [store showData:@"LMPadrino"];
    
    //casteo
    LMPadrino * padrino = [arregloPadrino objectAtIndex:0];
    NSLog(@"LUtil - Imprime el padrino de la base: %@", padrino);
    return padrino;
}

/**
 *@brief metodo que obtiene la url del pdf de la factura del padrino
 *@return la url correcta del pdf
 */
-(NSString *)obtenerPDF:(NSString *)url{
    
    NSArray *arraySeparate = [url componentsSeparatedByString:@"&fc="];
    NSString *idUrl;
    for(int cont=0; cont<[arraySeparate count]; cont++){
        NSLog(@"queeeee %d ----- %@", cont, [arraySeparate objectAtIndex:cont]);
        if(cont == 1){
            idUrl = [arraySeparate objectAtIndex:cont];
        }
    }
    
    NSString *nuevaUrl = [NSString stringWithFormat:@"%@%@", @"http://201.159.133.54/face5/f4/extensiones/pdf_factura.php?idf=", idUrl];
    NSLog(@"La nueva url %@", nuevaUrl);
    NSURL *googleURL = [NSURL URLWithString:nuevaUrl];
    NSError *error;
    NSString *page = [NSString stringWithContentsOfURL:googleURL
                                              encoding:NSASCIIStringEncoding
                                                 error:&error];
    NSString *textoFormateado = [self stringByStrippingHTML:page];
    NSArray *arrayTexto = [textoFormateado componentsSeparatedByString:@"\""];
    NSString *nombrePdf;
    for(int cont=0; cont<[arrayTexto count]; cont++){
        NSLog(@"-----------------> %d %@", cont, [arrayTexto objectAtIndex:cont]);
        if(cont == 1){
            nombrePdf = [arrayTexto objectAtIndex:cont];
        }
    }
    NSString *urlPdfFinal = [NSString stringWithFormat:@"%@%@", @"http://201.159.133.54/face5/f4/extensiones/", nombrePdf];
    return urlPdfFinal;
    
}

/**
 *@brief metodo que se utiliza para quitar las etiquetas del html
 @param string a formatear
 @return el string sin etiquetas
 */
-(NSString *) stringByStrippingHTML:(NSString *)textoHtml {
    NSRange range;
    while ((range = [textoHtml rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        textoHtml = [textoHtml stringByReplacingCharactersInRange:range withString:@""];
    return textoHtml;
}

/*!
 *  @brief  Metodo que guarda en la base de datos el ahijado seleccionado
 *
 *  @param json  respuesta de la peticion
 *  @param store Instancia de la clase manajadora de la base de datos
 */
- (void)saveData:(NSDictionary *) json methodDave:(LManagerObject*) store contador:(NSInteger) cont response:(NSDictionary *) response{
    NSLog(@"que traeeee %@ = %@", [[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LNipAhijado], [[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LNombreAhijado]);
    if([json[LAhijadoJson] count] > 0){
        NSString *ahijadoApellidoMaterno;
        if(![[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LApellidoMaternoAhijado] isEqual:[NSNull null]]){
            ahijadoApellidoMaterno = [NSString stringWithFormat:@"%@",[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LApellidoMaternoAhijado]];
        }else{
            ahijadoApellidoMaterno = @"";
        }
        NSString *ahijadoApellidoPaterno;
        if(![[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LApellidoPaternoAhijado] isEqual:[NSNull null]]){
            ahijadoApellidoPaterno = [NSString stringWithFormat:@"%@",[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LApellidoPaternoAhijado]];
        }else{
            ahijadoApellidoPaterno = @"";
        }
        NSNumber *ahijadoCalificacionCiencias = @([[response[LCalificaciones] objectForKey:LCalificacionCiencias] floatValue]);
        if(![response[LMensajeAhijados] isEqualToString:LDatosIncorrectos] && ![[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LCalificacionCiencias] isEqual:[NSNull null]]){
            ahijadoCalificacionCiencias = @([[response[LCalificaciones] objectForKey:LCalificacionCiencias] floatValue]);
        }else{
            ahijadoCalificacionCiencias = 0;
        }
        NSLog(@"para guardar espanol %@", [response[LCalificaciones] objectForKey:LCalificacionEspanol]);
        NSNumber *ahijadoCalificacionEspanol;
        if(![response[LMensajeAhijados] isEqualToString:LDatosIncorrectos] && ![[response[LCalificaciones] objectForKey:LCalificacionEspanol] isEqual:[NSNull null]]){
            ahijadoCalificacionEspanol = @([[response[LCalificaciones] objectForKey:LCalificacionEspanol] floatValue]);
        }else{
            ahijadoCalificacionEspanol = 0;
        }
        NSNumber *ahijadoCalificacionMatematicas;
        if(![response[LMensajeAhijados] isEqualToString:LDatosIncorrectos] && ![[response[LCalificaciones] objectForKey:LCalificacionMatematicas] isEqual:[NSNull null]]){
            ahijadoCalificacionMatematicas = @([[response[LCalificaciones] objectForKey:LCalificacionMatematicas] floatValue]);
        }else{
            ahijadoCalificacionMatematicas = 0;
        }
        //NSLog(@"que pasa %@", ahijadoCalificacionMatematicas);
        NSString *ahijadoCicloEscolar;
        NSLog(@"que tiene %@ -- %@", response[LMensajeAhijados], response[LCalificaciones]);
        if(![response[LMensajeAhijados] isEqualToString:LDatosIncorrectos] && ![[response[LCalificaciones] objectForKey:LCicloEscolar] isEqual:[NSNull null]]){
            ahijadoCicloEscolar = [NSString stringWithFormat:@"%@",[response[LCalificaciones] objectForKey:LCicloEscolar]];
        }else{
            ahijadoCicloEscolar = @"";
        }
        
        //NSLog(@"que pasa %@", [[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LFechaNacimientoAhijado]);
        //Formato de fecha de nacimiento
        NSDateFormatter *dateformatterFecha = [[NSDateFormatter alloc] init];
        [dateformatterFecha setFormatterBehavior:NSDateFormatterBehavior10_4];
        [dateformatterFecha setDateFormat:@"yyyy-MM-dd"];
        NSDate *ahijadoFechaN;
        if(![[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LFechaNacimientoAhijado] isEqual:[NSNull null]]){
            ahijadoFechaN = [dateformatterFecha dateFromString:[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LFechaNacimientoAhijado]];
        }
        //NSLog(@"Fecha de nacimiento del ahijado: %@", ahijadoFechaN);
        
        NSString *ahijadoFilial;
        if(![[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LFilial] isEqual:[NSNull null]]){
            ahijadoFilial = [NSString stringWithFormat:@"%@",[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LFilial]];
        }else{
            ahijadoFilial = @"";
        }
        NSString *ahijadoFoto;
        if(![[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LFotoAhijado] isEqual:[NSNull null]]){
            ahijadoFoto = [NSString stringWithFormat:@"%@",[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LFotoAhijado]];
        }else{
            ahijadoFoto = @"";
        }
        NSNumber *ahijadoGrado;
        if(![[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LGrado] isEqual:[NSNull null]]){
            ahijadoGrado = @([[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LGrado] integerValue]);
        }else{
            ahijadoGrado = 0;
        }
        NSString *ahijadoGrupo;
        if(![[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LGrupo] isEqual:[NSNull null]]){
            ahijadoGrupo = [NSString stringWithFormat:@"%@",[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LGrupo]];
        }else{
            ahijadoGrupo = @"";
        }
        NSString *ahijadoGustos;
        if(![[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LGustos] isEqual:[NSNull null]]){
            ahijadoGustos = [NSString stringWithFormat:@"%@",[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LGustos]];
        }else{
            ahijadoGustos = @"";
        }
        NSString *ahijadoNip;
        if(![[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LNipAhijado] isEqual:[NSNull null]]){
            ahijadoNip = [[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LNipAhijado];
        }else{
            ahijadoNip = @"";
        }
        NSString *ahijadoNombre;
        if(![[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LNombreAhijado] isEqual:[NSNull null]]){
            ahijadoNombre = [[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LNombreAhijado];
        }else{
            ahijadoNombre = @"";
        }
        NSString *ahijadoEscuela;
        if(![[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LNombreEscuela] isEqual:[NSNull null]]){
            ahijadoEscuela = [[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LNombreEscuela];
        }else{
            ahijadoEscuela = @"";
        }
        NSString *ahijadoNivelEscolar;
        if(![[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LNivel] isEqual:[NSNull null]]){
            ahijadoNivelEscolar = [[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LNivel];
        }else{
            ahijadoNivelEscolar = @"";
        }
        NSNumber *ahijadoTallaRopa;
        if(![[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LCalificacionEspanol] isEqual:[NSNull null]]){
            ahijadoTallaRopa = @([[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LCalificacionEspanol] floatValue]);
        }else{
            ahijadoTallaRopa = 0;
        }
        NSNumber *ahijadoTallaCalzado;
        if(![[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LTallaCalzado] isEqual:[NSNull null]]){
            ahijadoTallaCalzado = @([[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LTallaCalzado] floatValue]);
        }else{
            ahijadoTallaCalzado = 0;
        }
        //NSLog(@"que pasa %@", ahijadoTallaCalzado);
        NSString *ahijadoNipEscuela;
        if(![[[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LNipEscuela] isEqual:[NSNull null]]){
            ahijadoNipEscuela = [[json[LAhijadoJson] objectAtIndex:cont] objectForKey:LNipEscuela];
        }else{
            ahijadoNipEscuela = @"";
        }
        
        ///Se guarda en base de datos el ahijado
        [store saveDataAhijadoInformacion:ahijadoApellidoMaterno apellidoPaternoAhijado:ahijadoApellidoPaterno calificacionCiencias:ahijadoCalificacionCiencias calificacionEspanol:ahijadoCalificacionEspanol calificacionMatematicas:ahijadoCalificacionMatematicas cicloEscolar:ahijadoCicloEscolar fechaNacimientoAhijado:ahijadoFechaN filial:ahijadoFilial fotoAhijado:ahijadoFoto grado:ahijadoGrado grupo:ahijadoGrupo gustos:ahijadoGustos nipAhijado:ahijadoNip nombreAhijado:ahijadoNombre nombreEscuela:ahijadoEscuela nivel:ahijadoNivelEscolar tallaCalzado:ahijadoTallaCalzado tallaRopa:ahijadoTallaRopa nip_escuela:ahijadoNipEscuela];
    }
}

@end