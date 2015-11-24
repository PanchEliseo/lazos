//
//  LMAportaciones+CoreDataProperties.h
//  Lazos
//
//  Created by Programacion on 10/7/15.
//  Copyright © 2015 sferea. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LMAportaciones.h"

NS_ASSUME_NONNULL_BEGIN

@interface LMAportaciones (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *periodicidad;
@property (nullable, nonatomic, retain) NSString *monto;
@property (nullable, nonatomic, retain) NSDate *fecha_cargo;
@property (nullable, nonatomic, retain) NSString *resibo_c;

@end

NS_ASSUME_NONNULL_END
