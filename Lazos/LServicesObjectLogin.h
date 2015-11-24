//
//  LServicesObjectLogin.h
//  Lazos
//
//  Created by Programacion on 9/3/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//
#import "LServiceObject.h"
@interface LServicesObjectLogin : LServiceObject

- (id)initWithUser:(NSString *) nip clavePadrino:(NSString *) clave tipo:(NSString *)tipo;
- (void)startDownloadWithCompletionBlock:(void (^) (NSDictionary * response, NSError * error))block;

- (id)initWithUserApilazos:(NSString *) nip nombre:(NSString *) nombre apellidoPaterno:(NSString *) aPaterno apellidoMaterno:(NSString *) aMaterno token:(NSString *) token tipo:(NSString *)tipo;

- (id)initWithEspeciales:(NSString *) nip token:(NSString *)token tipo:(NSString *)tipo;

@end