//
//  LMPadrino+CoreDataProperties.h
//  Lazos
//
//  Created by Programacion on 10/19/15.
//  Copyright © 2015 sferea. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LMPadrino.h"

NS_ASSUME_NONNULL_BEGIN

@interface LMPadrino (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *apellidos;
@property (nullable, nonatomic, retain) NSString *date_entered;
@property (nullable, nonatomic, retain) NSString *gender;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *nip_godfather;
@property (nullable, nonatomic, retain) NSNumber *no_godchildren;
@property (nullable, nonatomic, retain) NSString *rfc;
@property (nullable, nonatomic, retain) NSString *token;

@end

NS_ASSUME_NONNULL_END
