//
//  STManagerObject.h
//  Lazos
//
//  Created by Programacion on 9/4/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "LMAhijado.h"
#import "LMBuzon.h"

@interface LManagerObject : NSObject

+ (LManagerObject *)sharedStore;
- (void)saveLocalContext;
-(void)saveDataGodfather:(NSString *)token nip:(NSNumber *)nip_godfather name:(NSString *)name apellidos:(NSString *)apellidos gender:(NSString *)gender number:(NSNumber *)no_godchildren date:(NSString *)date_entered rfc:(NSString *)RFC;
- (void)deleteData:(NSManagedObject *)manage;
-(NSArray*)showData:(NSString*)name;

///Método para la pantalla principal Noticias
-(void)saveDataNews:(NSNumber *)idNoticia titulo:(NSString *)titulo noticia_descripcion:(NSString *)noticia_descripcion fecha_noticia:(NSDate *)fecha hora_noticia:(NSString *)hora url_imagen:(NSString *)url_imagen url_video:(NSString *)url_video tipo_noticia:(NSString *)tipo muestra:(NSString *)mostrar;

///Método para la pantalla de información del Ahijado
-(void)saveDataAhijadoInformacion:(NSString *)apellido_materno_ahijado apellidoPaternoAhijado:(NSString *)apellido_paterno_ahijado calificacionCiencias:(NSNumber *)calificacion_ciencias calificacionEspanol:(NSNumber *)calificacion_espanol calificacionMatematicas:(NSNumber *)calificacion_matematicas cicloEscolar:(NSString *)ciclo_escolar fechaNacimientoAhijado:(NSDate *)fecha_nacimiento_ahijado filial:(NSString *)filial fotoAhijado:(NSString *)foto_ahijado grado:(NSNumber *)grado grupo:(NSString *)grupo gustos:(NSString *)gustos nipAhijado:(NSString *)nip_ahijado nombreAhijado:(NSString *)nombre_ahijado nombreEscuela:(NSString *)nombre_escuela nivel:(NSString *)nivel tallaCalzado:(NSNumber *)talla_calzado tallaRopa:(NSNumber *)talla_ropa nip_escuela:(NSString *)nip_escuela;

-(LMAhijado*)shareNip:(NSNumber*)nip;

-(void)saveDataBuzon:(NSString *)id_buzon fecha:(NSString *)fecha_buzon descripcion:(NSString *)descripcion filial:(NSString *)filial nombre:(NSString *)nombre nip_padrino:(NSString *)nip_padrino estatus:(NSString *)estatus tipo:(NSString *)tipo;

-(LMBuzon*)shareIdBuzon:(NSString*)idBuzon;

- (void)saveDataRecibidos:(NSString *)apellido caso:(NSNumber *)caso categoria:(NSString *)categoria fecha:(NSString *)fecha foto:(NSString *)foto hora:(NSString *)hora id_buzon:(NSNumber *)id_buzon id_ahijado:(NSNumber *)id_ahijado id_padrino:(NSNumber *)id_padrino nip_ahijado:(NSNumber *)nip_ahijado nip_padrino:(NSNumber *)nip_padrino nombre:(NSString *)nombre texto:(NSString *)texto tipo:(NSString *)tipo titulo:(NSString *)titulo url_imagen_opcional:(NSString *)url_imagen_opcional url_imagen_respuesta:(NSString *)url_imagen_respuesta;

@end