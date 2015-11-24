//
//  LServiceObjectAportaciones.h
//  Lazos
//
//  Created by Programacion on 10/7/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import "LServiceObject.h"

@interface LServiceObjectAportaciones : LServiceObject

- (id)initWithData:(NSString *) nip token:(NSString *) token;
- (void)startDownloadWithCompletionBlock:(void (^) (NSDictionary * response, NSError * error))block;

@end
