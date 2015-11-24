//
//  LServiceObjectRegistrarRegalo.m
//  Lazos
//
//  Created by sferea on 09/10/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import "LServiceObjectRegistrarRegalo.h"

@implementation LServiceObjectRegistrarRegalo

/**
 Método que inicializa el servicio, recibe los parametros a ser enviados en la url del registro del regalo del padrino.
 */

- (id)initWithDataGift:(NSString *)nipPadrino token:(NSString *)token nipAhijado:(NSString *)nipAhijado tipo:(NSString *)tipo descripcion:(NSString *)descripcion ahijadoFilial:(NSString *)ahijadoFilial escuela:(NSString *)escuela generoPadrino:(NSString *)generoPadrino{
    self = [super init];
    if (self)
    {
        ///Se le da el formato de UTF8 a la descripcion para que remplace los espacios, saltos de linea y tabuladores en el texto escrito para poder ser enviados en la url del servicio.
        NSString *newDescripcion = [descripcion stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *newFilial = [ahijadoFilial stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *newEscuela = [escuela stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *urlEnvio = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@", @"http://201.175.10.244/app/Enviarregalo.php?nippadrino=", nipPadrino, @"&token=", token, @"&nipahijado=", nipAhijado, @"&tipo=", tipo, @"&descripcion=", newDescripcion, @"&filial=", newFilial, @"&escuela=", newEscuela, @"&genero=", generoPadrino];
        self.urlService = [NSURL URLWithString:urlEnvio];
        self.typePetition = LServicePetitionGET;
        
    }
    return self;
}

- (id)initWithDataApilazos:(NSString *)nip token:(NSString *)token{
    
    self = [super init];
    if(self){
        NSString *urlEnvio = [NSString stringWithFormat:@"%@%@%@%@%@", @"http://apilazos.sferea.com/registros?nippadrino=", nip, @"&token=", token, @"&envioRegalo=true"];
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
