//
//  LServiceObjectRegistrarRegalo.h
//  Lazos
//
//  Created by sferea on 09/10/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import "LServiceObject.h"

@interface LServiceObjectRegistrarRegalo : LServiceObject

- (id)initWithDataGift:(NSString *) nipPadrino token:(NSString *) token nipAhijado:(NSString *) nipAhijado tipo:(NSString *)tipo descripcion:(NSString *) descripcion ahijadoFilial:(NSString *) ahijadoFilial escuela:(NSString *) escuela generoPadrino:(NSString *) generoPadrino;
- (id)initWithDataApilazos:(NSString *)nip token:(NSString *)token;
- (void)startDownloadWithCompletionBlock:(void (^) (NSDictionary * response, NSError * error))block;

@end
