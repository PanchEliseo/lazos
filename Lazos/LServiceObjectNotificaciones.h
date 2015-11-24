//
//  LServiceObjectNotificaciones.h
//  Lazos
//
//  Created by sferea on 17/11/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import "LServiceObject.h"

@interface LServiceObjectNotificaciones : LServiceObject

- (id)initWithDataNotificacion:(NSString *) nip token:(NSString *)token tipo:(NSString *)tipo habilitar:(NSString *)habilitar;
- (void)startDownloadWithCompletionBlock:(void (^) (NSDictionary * response, NSError * error))block;

@end
