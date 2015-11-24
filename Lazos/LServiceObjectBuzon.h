//
//  LServiceObjectBuzon.h
//  Lazos
//
//  Created by Programacion on 9/30/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import "LServiceObject.h"

@interface LServiceObjectBuzon : LServiceObject

- (id)initWithData:(NSString *) nip token:(NSString *) token tipo:(NSString *)tipo;
- (void)startDownloadWithCompletionBlock:(void (^) (NSDictionary * response, NSError * error))block;
- (id)initRecibidos:(NSString *) nip token:(NSString *) token;

@end