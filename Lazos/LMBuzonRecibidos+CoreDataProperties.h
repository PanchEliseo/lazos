//
//  LMBuzonRecibidos+CoreDataProperties.h
//  Lazos
//
//  Created by Carlos molina on 11/11/15.
//  Copyright © 2015 sferea. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LMBuzonRecibidos.h"

NS_ASSUME_NONNULL_BEGIN

@interface LMBuzonRecibidos (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *apellido_ahijado;
@property (nullable, nonatomic, retain) NSNumber *caso;
@property (nullable, nonatomic, retain) NSString *categoria;
@property (nullable, nonatomic, retain) NSString *fecha;
@property (nullable, nonatomic, retain) NSString *foto_ahijado;
@property (nullable, nonatomic, retain) NSString *hora;
@property (nullable, nonatomic, retain) NSNumber *id_buzon;
@property (nullable, nonatomic, retain) NSNumber *id_ahijado;
@property (nullable, nonatomic, retain) NSNumber *id_padrino;
@property (nullable, nonatomic, retain) NSNumber *nip_ahijado;
@property (nullable, nonatomic, retain) NSNumber *nip_padrino;
@property (nullable, nonatomic, retain) NSString *nombre_ahijado;
@property (nullable, nonatomic, retain) NSString *texto;
@property (nullable, nonatomic, retain) NSString *tipo;
@property (nullable, nonatomic, retain) NSString *titulo;
@property (nullable, nonatomic, retain) NSString *url_imagen_opcional;
@property (nullable, nonatomic, retain) NSString *url_imagen_respuesta;

@end

NS_ASSUME_NONNULL_END
