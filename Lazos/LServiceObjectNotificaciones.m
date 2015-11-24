//
//  LServiceObjectNotificaciones.m
//  Lazos
//
//  Created by sferea on 17/11/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import "LServiceObjectNotificaciones.h"
#import <Foundation/Foundation.h>

@implementation LServiceObjectNotificaciones

- (id)initWithDataNotificacion:(NSString *) nip token:(NSString *)token tipo:(NSString *)tipo habilitar:(NSString *)habilitar{
    self = [super init];
    if (self)
    {
        ////
        NSString *urlNotificacion = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@", @"http://apilazos.sferea.com/notificaciones?nippadrino=", nip, @"&token=", token, @"&tipo=", tipo, @"&habilitar=", habilitar];
        NSLog(@"URL que envía para las notificaciones %@", urlNotificacion);
        self.urlService = [NSURL URLWithString:urlNotificacion];
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
          ///Se obtiene la notificacion de la base
          NSArray *notificacion = [store showData:@"LMNotificacion"];
          
          if (notificacion != 0) {
          for(int cont=0; cont<notificacion.count; cont++){
          LMNotificacion *notificacionDB = [notificacion objectAtIndex:cont];
          [store deleteData:notificacionDB];
          }
          [self saveData:json store:store];
          } else {
          [self saveData:json store:store];
          }*/
         self.customBlock(json,error);
         
     }];
    
}

@end
