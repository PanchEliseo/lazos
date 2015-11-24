//
//  LServiceObjectLogros.h
//  Lazos
//
//  Created by sferea on 21/10/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import "LServiceObject.h"

@interface LServiceObjectLogros : LServiceObject

- (id)initWithLogros:(NSString *) nip tokenPadrino:(NSString *) token;
- (void)startDownloadWithCompletionBlock:(void (^) (NSDictionary * response, NSError * error))block;

@end
