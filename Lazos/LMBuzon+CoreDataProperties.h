//
//  LMBuzon+CoreDataProperties.h
//  Lazos
//
//  Created by Programacion on 10/1/15.
//  Copyright © 2015 sferea. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LMBuzon.h"

NS_ASSUME_NONNULL_BEGIN

@interface LMBuzon (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *fecha_buzon;
@property (nullable, nonatomic, retain) NSString *descripcion;
@property (nullable, nonatomic, retain) NSString *filial;
@property (nullable, nonatomic, retain) NSString *nombre;
@property (nullable, nonatomic, retain) NSString *nip_padrino;
@property (nullable, nonatomic, retain) NSString *estatus;
@property (nullable, nonatomic, retain) NSString *tipo;
@property (nullable, nonatomic, retain) NSString *id_buzon;

@end

NS_ASSUME_NONNULL_END
