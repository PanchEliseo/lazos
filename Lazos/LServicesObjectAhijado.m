//
//  LServicesObjectAhijado.m
//  Lazos
//
//  Created by sferea on 25/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LServicesObjectAhijado.h"
#import "LManagerObject.h"
#import "LMAhijado.h"
#import "LConstants.h"
#import "LUtil.h"

@interface LServicesObjectAhijado()
@property (strong, nonatomic)NSString *tipo;
@property (strong, nonatomic)NSDictionary *response;
@end

@implementation LServicesObjectAhijado

//primera peticion para obtener la informacion del ahijado
- (id)initWithUser:(NSString *) nip token:(NSString *) token{
    self = [super init];
    if (self)
    {
        ///Llamada de ahijados al web service de Lazos
        NSString *urlAhijado = [NSString stringWithFormat:@"%@%@%@%@", @"http://201.175.10.244/app/misAhijados.php?nippadrino=", nip, @"&token=", token];
        NSLog(@"que pasa en urlAhijado %@%@%@", nip, @" ", token);
        self.urlService = [NSURL URLWithString:urlAhijado];
        self.typePetition = LServicePetitionGET;
        self.typeService = SSServiceLogin;
        
    }
    return self;
}

//segunda peticion del ahijado, para obtener la informacion restante
- (id)initWithAhijado:(NSString *) nip token:(NSString *) token nipAhijado:(NSString *)nipAhijado tipo:(NSString *)tipo response:(NSDictionary *)response{
    self = [super init];
    if (self)
    {
        ///Llamada de ahijados al web service de Lazos
        NSString *urlAhijado = [NSString stringWithFormat:@"%@%@%@%@%@%@", @"http://201.175.10.244/app/Ahijadoscalif.php?nippadrino=", nip, @"&token=", token, @"&nipnino=", nipAhijado];
        NSLog(@"que pasa en urlAhijado %@%@%@", nip, @" ", token);
        self.urlService = [NSURL URLWithString:urlAhijado];
        self.typePetition = LServicePetitionGET;
        self.typeService = SSServiceLogin;
        self.tipo = tipo;
        self.response = response;
    }
    return self;
}

///Petición al web service de ahijados de apilazos
- (id)initWithUserApilazos:(NSString *) nip token:(NSString *)token tipo:(NSString *)tipo{
    NSString *urlEnviaDatosAhijados = [NSString stringWithFormat:@"%@%@%@%@", @"http://apilazos.sferea.com/ahijados?nippadrino=", nip, @"&token=", token];
    
    self.urlService = [NSURL URLWithString:urlEnviaDatosAhijados];
    self.typePetition = LServicePetitionGET;
    self.typeService = SSServiceLogin;
    
    return self;
}

///Petición de recibidos al web service de apilazos para que guarden los casos (identificador) que devuelve la respuesta de recibidos
- (id)guardaCasos:(NSString *) nip token:(NSString *)token {
    NSString *urlCasos = [NSString stringWithFormat:@"%@%@%@%@%@", @"http://apilazos.sferea.com/recibidos?nippadrino=", nip, @"&token=", token, @"&guardarCasos=true"];
 
    self.urlService = [NSURL URLWithString:urlCasos];
    self.typePetition = LServicePetitionGET;
 
    return self;
 }

- (void)startDownloadWithCompletionBlock:(void (^) (NSDictionary * response, NSError * error))block;
{
    self.customBlock = block;
    [super startDownload];
    
}

- (void)parserJsonReponse:(NSMutableDictionary *) json withError:(NSError *) error{
    
    //  [[NSOperationQueue mainQueue] addOperationWithBlock:^{self.customBlock(json, error);}];
    //    LManagerObject *store = [LManagerObject sharedStore];
    //    NSLog(@"que trae aqui para hacer el parseo del json %@", json[@"Padrino"]);
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
     {
         if([self.tipo isEqualToString:@"buzonGeneral"]){
             if (!error && ![json isKindOfClass:[NSString class]])
             {
                 LUtil *util = [LUtil instance];
                 LManagerObject *store = [LManagerObject sharedStore];
                 ///Se obtiene la noticia de la base
                 NSArray *ahijados = [store showData:LTableNameAhijado];
                 NSLog(@"Cuantas traeee %lu", (unsigned long)[ahijados count]);
                 if (ahijados.count != 0) {
                     for(int cont=0; cont<ahijados.count; cont++){
                         LMAhijado *ahijado = [ahijados objectAtIndex:cont];
                         [store deleteData:ahijado];
                     }
                     for(int cont=0; cont<[self.response[LAhijadoJson] count]; cont++){
                         [util saveData:self.response methodDave:store contador:cont response:json];
                     }
                 } else {
                     for(int cont=0; cont<[self.response[LAhijadoJson] count]; cont++){
                         [util saveData:self.response methodDave:store contador:cont response:json];
                     }
                 }
             }
         }
         self.customBlock(json,error);
     }];
    
}

@end