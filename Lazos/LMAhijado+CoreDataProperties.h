//
//  LMAhijado+CoreDataProperties.h
//  Lazos
//
//  Created by Programacion on 9/30/15.
//  Copyright © 2015 sferea. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LMAhijado.h"

NS_ASSUME_NONNULL_BEGIN

@interface LMAhijado (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *apellido_materno_ahijado;
@property (nullable, nonatomic, retain) NSString *apellido_paterno_ahijado;
@property (nullable, nonatomic, retain) NSNumber *calificacion_ciencias;
@property (nullable, nonatomic, retain) NSNumber *calificacion_espanol;
@property (nullable, nonatomic, retain) NSNumber *calificacion_matematicas;
@property (nullable, nonatomic, retain) NSString *ciclo_escolar;
@property (nullable, nonatomic, retain) NSDate *fecha_nacimiento_ahijado;
@property (nullable, nonatomic, retain) NSString *filial;
@property (nullable, nonatomic, retain) NSString *foto_ahijado;
@property (nullable, nonatomic, retain) NSNumber *grado;
@property (nullable, nonatomic, retain) NSString *grupo;
@property (nullable, nonatomic, retain) NSString *gustos;
@property (nullable, nonatomic, retain) NSString *nip_ahijado;
@property (nullable, nonatomic, retain) NSString *nivel;
@property (nullable, nonatomic, retain) NSString *nombre_ahijado;
@property (nullable, nonatomic, retain) NSString *nombre_escuela;
@property (nullable, nonatomic, retain) NSNumber *talla_calzado;
@property (nullable, nonatomic, retain) NSNumber *talla_ropa;
@property (nullable, nonatomic, retain) NSString *ni_escuela;

@end

NS_ASSUME_NONNULL_END
