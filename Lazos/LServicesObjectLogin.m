//
//  LServicesObjectLogin.m
//  Lazos
//
//  Created by Programacion on 9/3/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LServicesObjectLogin.h"
#import "LManagerObject.h"
#import "LMPadrino.h"
#import "LConstants.h"
@interface LServicesObjectLogin()
@property NSString *tipo;
@end

@implementation LServicesObjectLogin

- (id)initWithUser:(NSString *) nip clavePadrino:(NSString *) clave tipo:(NSString *)tipo{
    self = [super init];
    if (self)
    {
        NSLog(@"Lo que recibe initWithUser en LServicesObjectLogin nip:::: %@, clave:::: %@",nip,clave);
        NSString *urlLogin = [NSString stringWithFormat:@"%@%@%@%@", @"http://201.175.10.244/app/loginapp.php?nippadrino=", nip, @"&password=", clave];
        self.urlService = [NSURL URLWithString:urlLogin];
        //self.jsonRequest = [self createJsonPostUser: usuario];
        self.typePetition = LServicePetitionGET;
        self.typeService = SSServiceLogin;
        self.tipo = tipo;
    }
    return self;
}

///Recibe parámetros para hacer la petición al web service de apilazos que guarda en la base de datos
- (id)initWithUserApilazos:(NSString *) nip nombre:(NSString *) nombre apellidoPaterno:(NSString *) aPaterno apellidoMaterno:(NSString *) aMaterno token:(NSString *) token tipo:(NSString *)tipo{
    
    ///Se le da el formato de UTF8 a la descripcion para que remplace los espacios, saltos de linea y tabuladores en el texto escrito para poder ser enviados en la url del servicio.
    NSString *newNombre = [nombre stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *newAPaterno = [aPaterno stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *newAMaterno = [aMaterno stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *urlEnviaDatosPadrino = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@", @"http://apilazos.sferea.com/padrinos?nippadrino=", nip, @"&nombre=", newNombre, @"&Apaterno=", newAPaterno, @"&Amaterno=", newAMaterno, @"&token=", token];
    NSLog(@"Url que envia a la base - %@", urlEnviaDatosPadrino);
    
    self.urlService = [NSURL URLWithString:urlEnviaDatosPadrino];
    self.typePetition = LServicePetitionGET;
    self.typeService = SSServiceLogin;
    self.tipo = tipo;
    
    return self;
}


///Petición al web service de especiales de apilazos (necesario para guardar los casos de las cartas en el Buzón de Recibidos y para los Logros: Visita a ahijado y Aportación Adicional)
- (id)initWithEspeciales:(NSString *) nip token:(NSString *)token tipo:(NSString *)tipo{
    NSString *urlEspeciales = [NSString stringWithFormat:@"%@%@%@%@", @"http://apilazos.sferea.com/especiales?nippadrino=", nip, @"&token=", token];
    
    self.urlService = [NSURL URLWithString:urlEspeciales];
    self.typePetition = LServicePetitionGET;
    self.typeService = SSServiceLogin;
    
    return self;
}


- (void)startDownloadWithCompletionBlock:(void (^) (NSDictionary * response, NSError * error))block;
{
    self.customBlock = block;
    [super startDownload];
    
}

/**
 Metodo que realiza el parseo del json y el guardado en la base de datos los datos del padrino
 */
- (void)parserJsonReponse:(NSMutableDictionary *) json withError:(NSError *) error{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
     {
         if (!error && ![json isKindOfClass:[NSString class]])
         {
             if([self.tipo isEqualToString:@"lazos"]){
                 LManagerObject *store = [LManagerObject sharedStore];
                 //se obtiene el padrino de la base
                 NSArray *padrinos = [store showData:LTableNamePadrino];
                 
                 if(![json[LMensajePeticionPadrino] isEqualToString:LRespuestaPeticionPadrino]){
                     if(padrinos.count != 0){
                         LMPadrino *padrinoBase = [padrinos objectAtIndex:0];
                         //se borra el unico padrino para guardar el nuevo que entre, para solo guardar el ultimo que entro a la aplicacion
                         [store deleteData:padrinoBase];
                         
                         [self saveDataPadrino:json store:store];
                     }else{
                         [self saveDataPadrino:json store:store];
                     }
                 }
             }
             
         }
         self.customBlock(json,error);
         
     }];
    
}


/**
 Metodo que lee los datos del json y guarda los valores en la base de datos
 */
-(void)saveDataPadrino:(NSMutableDictionary *)json store:(LManagerObject *)store{
    
    //se castean los datos del json segun los valores de la base de datos
    NSNumber *nip;
    if(![[json[LPadrino] objectForKey:LNipPadrino] isEqual:[NSNull null]]){
        nip = @([[json[LPadrino] objectForKey:LNipPadrino] integerValue]);
    }else{
        nip = 0;
    }
    NSNumber *numero;
    if(![[json[LPadrino] objectForKey:LNoAhijados] isEqual:[NSNull null]]){
        numero = @([[json[LPadrino] objectForKey:LNoAhijados] integerValue]);
    }else{
        numero = 0;
    }
    NSString * date;
    if(![[json[LPadrino] objectForKey:LFechaPadrino] isEqual:[NSNull null]]){
        date = [json[LPadrino] objectForKey:LFechaPadrino];
    }else{
        date = @"";
    }
    NSString *apellidos;
    if(![[json[LPadrino] objectForKey:LApellidoPaternoPadrino] isEqual:[NSNull null]] && ![[json[LPadrino] objectForKey:LApellidoMaternoPadrino] isEqual:[NSNull null]]){
        apellidos = [NSString stringWithFormat:@"%@%@%@", [json[LPadrino] objectForKey:LApellidoPaternoPadrino], @" ", [json[LPadrino] objectForKey:LApellidoMaternoPadrino]];
    }else{
        apellidos = @"";
    }
    //se valida si el rfc estara vacio
    NSString *rfc;
    if(![[json[LPadrinoRFC] objectForKey:LPadrinoRFC] isEqual:[NSNull null]]){
        rfc = [json[LPadrino] objectForKey:LPadrinoRFC];
    }else{
        rfc = @"";
    }
    //se guarda en base de datos el padrino que acaba de acceder a la aplicacion
    [store saveDataGodfather:[json[LPadrino] objectForKey:LTokenPadrino] nip:nip name:[json[LPadrino] objectForKey:LNombrePadrino] apellidos:apellidos gender:[json[LPadrino] objectForKey:LGeneroPadrino] number:numero date:date rfc:rfc];
}

@end