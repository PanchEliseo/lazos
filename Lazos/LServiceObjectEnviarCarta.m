//
//  LServiceObjectEnviarCarta.m
//  Lazos
//
//  Created by Programacion on 9/29/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LServiceObjectEnviarCarta.h"

@implementation LServiceObjectEnviarCarta

/**
 Metodo que inicializa el servicio, recibe los parametros a ser enviados en la url de se la carta del padrino.
 */
- (id)initWithData:(NSString *) nip token:(NSString *) token nipAhijado:(NSString *) nipAhijado plantilla:(NSString *) tipoPlantilla tipo:(NSString *)tipo descripcion:(NSString *) descripcion ahijadoFilial:(NSString *) ahijadoFilial escuela:(NSString *) escuela genero:(NSString *)genero{
    self = [super init];
    if (self)
    {
        //se le da el formato de UTF8 a la descripcion para que remplace los espacios, saltos de linea y tabuladores en el texto escrito para poder ser enviados en la url del servicio.
        NSString *newDescripcion = [descripcion stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *newFilial = [ahijadoFilial stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *newEscuela = [escuela stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        ///Se envía una primera vez para que se guarde en la base de Lazos
        NSString *urlEnvio = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@", @"http://201.175.10.244/app/Enviarcarta.php?nippadrino=", nip, @"&token=", token, @"&nipahijado=", nipAhijado, @"&plantilla=", tipoPlantilla, @"&tipo=", tipo, @"&descripcion=", newDescripcion, @"&filial=", newFilial, @"&escuela=", newEscuela, @"&genero=", genero];

        self.urlService = [NSURL URLWithString:urlEnvio];
        self.typePetition = LServicePetitionGET;
        
    }
    return self;
}

-(id)initWithDataApilazos:(NSString *)nip token:(NSString *)token{
    self = [super init];
    if(self){
        NSString *urlEnvio = [NSString stringWithFormat:@"%@%@%@%@%@", @"http://apilazos.sferea.com/registros?nippadrino=", nip, @"&token=", token, @"&envioCarta=true"];
        self.urlService = [NSURL URLWithString:urlEnvio];
        self.typePetition = LServicePetitionGET;
    }
    return self;
}

/**
 Metodo que empieza realiza la peticion del servicio
 */
- (void)startDownloadWithCompletionBlock:(void (^) (NSDictionary * response, NSError * error))block;
{
    self.customBlock = block;
    [super startDownload];
    
}

/**
 Metodo 
 */
- (void)parserJsonReponse:(NSMutableDictionary *) json withError:(NSError *) error{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
     {
         self.customBlock(json,error);
         
     }];
    
}

@end