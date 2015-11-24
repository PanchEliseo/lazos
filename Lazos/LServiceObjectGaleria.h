//
//  LServiceObjectGaleria.h
//  Lazos
//
//  Created by Programacion on 9/25/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import "LServiceObject.h"

@interface LServiceObjectGaleria : LServiceObject

- (id)initWithGaleria:(NSString *) nip tokenPadrino:(NSString *) token;
- (id)initWithGaleriaApilazos:(NSString *)nip tokenPadrino:(NSString *)token;
- (void)startDownloadWithCompletionBlock:(void (^) (NSDictionary * response, NSError * error))block;

@end