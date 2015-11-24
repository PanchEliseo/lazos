//
//  LServicesObjectAhijado.h
//  Lazos
//
//  Created by sferea on 25/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import "LServiceObject.h"

@interface LServicesObjectAhijado : LServiceObject

- (id)initWithUser:(NSString *) nip token:(NSString *) token;
- (id)initWithAhijado:(NSString *) nip token:(NSString *) token nipAhijado:(NSString *)nipAhijado tipo:(NSString *)tipo response:(NSDictionary *)response;
- (void)startDownloadWithCompletionBlock:(void (^) (NSDictionary * response, NSError * error))block;
- (id)initWithUserApilazos:(NSString *) nip token:(NSString *)token tipo:(NSString *)tipo;
- (id)guardaCasos:(NSString *) nip token:(NSString *)token;
@end
