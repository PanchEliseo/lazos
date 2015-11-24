//
//  LMNoticia+CoreDataProperties.h
//  Lazos
//
//  Created by Carlos molina on 10/11/15.
//  Copyright © 2015 sferea. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LMNoticia.h"

NS_ASSUME_NONNULL_BEGIN

@interface LMNoticia (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *fecha;
@property (nullable, nonatomic, retain) NSString *hora;
@property (nullable, nonatomic, retain) NSNumber *id_noticia;
@property (nullable, nonatomic, retain) NSString *mostrar;
@property (nullable, nonatomic, retain) NSString *noticia_descripcion;
@property (nullable, nonatomic, retain) NSString *tipo_noticia;
@property (nullable, nonatomic, retain) NSString *titulo;
@property (nullable, nonatomic, retain) NSString *url_imagen;
@property (nullable, nonatomic, retain) NSString *url_video;

@end

NS_ASSUME_NONNULL_END
