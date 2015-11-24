//
//  LServiceObjectGaleria.m
//  Lazos
//
//  Created by Programacion on 9/25/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LServiceObjectGaleria.h"

@implementation LServiceObjectGaleria

- (id)initWithGaleria:(NSString *)nip tokenPadrino:(NSString *)token{
    self = [super init];
    if (self)
    {
        NSLog(@"que pasa en urlGaleria de LServiceObjectGaleria::: nip: %@ token del padrino: %@", nip, token);
        NSString *urlGaleria = [NSString stringWithFormat:@"%@%@%@%@", @"http://apilazos.sferea.com/galeria?nippadrino=", nip, @"&token=", token];
        self.urlService = [NSURL URLWithString:urlGaleria];
        //self.jsonRequest = [self createJsonPostUser: usuario];
        self.typePetition = LServicePetitionGET;
        self.typeService = SSServiceLogin;
        
    }
    return self;
}

- (id)initWithGaleriaApilazos:(NSString *)nip tokenPadrino:(NSString *)token{
    self = [super init];
    if(self)
    {
        NSLog(@"que pasa en urlEnvio de LServiceObjectGaleria::: nip: %@ token del padrino: %@", nip, token);
        NSString *urlEnvio = [NSString stringWithFormat:@"%@%@%@%@%@", @"http://apilazos.sferea.com/registros?nippadrino=", nip, @"&token=", token, @"&compartir=true"];
        self.urlService = [NSURL URLWithString:urlEnvio];
        //self.jsonRequest = [self createJsonPostUser: usuario];
        self.typePetition = LServicePetitionGET;
    }
    return self;
}

- (void)startDownloadWithCompletionBlock:(void (^) (NSDictionary * response, NSError * error))block;
{
    self.customBlock = block;
    [super startDownload];
    
}

- (void)parserJsonReponse:(NSMutableDictionary *) json withError:(NSError *) error{
    
    //    [[NSOperationQueue mainQueue] addOperationWithBlock:^{self.customBlock(json, error);}];
    //    LManagerObject *store = [LManagerObject sharedStore];
    //    NSLog(@"que trae aqui para hacer el parseo del json %@", json[@"Padrino"]);
    
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
     {
         self.customBlock(json,error);
         
     }];
    
}

@end