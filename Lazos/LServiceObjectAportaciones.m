//
//  LServiceObjectAportaciones.m
//  Lazos
//
//  Created by Programacion on 10/7/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LServiceObjectAportaciones.h"

@implementation LServiceObjectAportaciones

- (id)initWithData:(NSString *) nip token:(NSString *) token{
    self = [super init];
    if (self)
    {
        NSString *urlAportaciones = [NSString stringWithFormat:@"%@%@%@%@", @"http://201.175.10.244/app/estadoCuenta.php?nippadrino=", nip, @"&token=", token];
        self.urlService = [NSURL URLWithString:urlAportaciones];
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
    
    //    [[NSOperationQueue mainQueue] addOperationWithBlock:^{self.customBlock(json, error);}];
    //    LManagerObject *store = [LManagerObject sharedStore];
    //    NSLog(@"que trae aqui para hacer el parseo del json %@", json[@"Padrino"]);
    
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
     {
         /*LManagerObject *store = [LManagerObject sharedStore];
         ///Se obtiene la noticia de la base
         NSArray *buzon = [store showData:@"LMBuzon"];
         
         if (buzon.count != 0) {
             for(int cont=0; cont<buzon.count; cont++){
                 LMBuzon *buzonDB = [buzon objectAtIndex:cont];
                 [store deleteData:buzonDB];
             }
             [self saveData:json store:store];
         } else {
             [self saveData:json store:store];
         }*/
         self.customBlock(json,error);
         
     }];
    
}

@end