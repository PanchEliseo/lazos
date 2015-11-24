//
//  LServicesObjectNoticia.h
//  Lazos
//
//  Created by sferea on 09/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import "LServiceObject.h"

@interface LServicesObjectNoticia : LServiceObject

- (id)initWithNoticia:(NSString *) nip tokenPadrino:(NSString *) token;
- (void)startDownloadWithCompletionBlock:(void (^) (NSDictionary * response, NSError * error))block;

@end
