//
//  LServiceObjectEnviarCarta.h
//  Lazos
//
//  Created by Programacion on 9/29/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import "LServiceObject.h"

@interface LServiceObjectEnviarCarta : LServiceObject

- (id)initWithData:(NSString *) nip token:(NSString *) token nipAhijado:(NSString *) nipAhijado plantilla:(NSString *) tipoPlantilla tipo:(NSString *)tipo descripcion:(NSString *) descripcion ahijadoFilial:(NSString *) ahijadoFilial escuela:(NSString *) escuela genero:(NSString *)genero;
- (id)initWithDataApilazos:(NSString *)nip token:(NSString *)token;
- (void)startDownloadWithCompletionBlock:(void (^) (NSDictionary * response, NSError * error))block;

@end
