//
//  LServiceObjectLogros.m
//  Lazos
//
//  Created by sferea on 21/10/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import "LServiceObjectLogros.h"

@implementation LServiceObjectLogros

- (id)initWithLogros:(NSString *) nip tokenPadrino:(NSString *) token{
    self = [super init];
    if (self)
    {
        NSString *urlLogros = [NSString stringWithFormat:@"%@%@%@%@", @"http://apilazos.sferea.com/logros?nippadrino=", nip, @"&token=", token];
        self.urlService = [NSURL URLWithString:urlLogros];
        //self.jsonRequest = [self createJsonPostUser: usuario];
        self.typePetition = LServicePetitionGET;
        self.typeService = SSServiceLogin;
    }
    return self;
}

- (void)startDownloadWithCompletionBlock:(void (^) (NSDictionary * response, NSError * error))block;
{
    self.customBlock = block;
    [super startDownload];
    
}

- (void)parserJsonReponse:(NSMutableDictionary *) json withError:(NSError *) error{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
     {
         self.customBlock(json,error);
         
     }];
}
@end
