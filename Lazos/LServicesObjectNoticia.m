//
//  LServicesObjectNoticia.m
//  Lazos
//
//  Created by sferea on 09/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LServicesObjectNoticia.h"
#import "LManagerObject.h"
#import "LMNoticia.h"
#import "LConstants.h"

@implementation LServicesObjectNoticia

- (id)initWithNoticia:(NSString *) nip tokenPadrino:(NSString *) token{
    self = [super init];
    if (self)
    {
        NSString *urlNoticias = [NSString stringWithFormat:@"%@%@%@%@", @"http://apilazos.sferea.com/noticias?nippadrino=", nip, @"&token=", token];
        self.urlService = [NSURL URLWithString:urlNoticias];
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
         if (!error && ![json isKindOfClass:[NSString class]])
         {
             LManagerObject *store = [LManagerObject sharedStore];
             ///Se obtiene la noticia de la base
             NSArray *noticias = [store showData:LTableNameNoticia];
             
             if (noticias.count != 0) {
                for(int cont=0; cont<noticias.count; cont++){
                    LMNoticia *noticia = [noticias objectAtIndex:cont];
                    [store deleteData:noticia];
                }
                [self saveData:json methodDave:store];
             } else {
                 [self saveData:json methodDave:store];
             }

         }
         self.customBlock(json,error);
         
     }];
    
}

-(void)saveData:(NSMutableDictionary *) json methodDave:(LManagerObject*) store{
    for(int cont=0; cont<[json[LNoticia] count]; cont++){
        NSLog(@"que pasa %@", [[json[LNoticia] objectAtIndex:cont] objectForKey:LTitulo]);
        
        NSString *titulo = [NSString stringWithFormat:@"%@",[[json[LNoticia] objectAtIndex:cont] objectForKey:LTitulo]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSDate * fecha_noticia = [dateFormatter dateFromString:[[json[LNoticia] objectAtIndex:cont] objectForKey:LFechaNoticia]];
        NSString *muestra = [NSString stringWithFormat:@"%@",[[json[LNoticia] objectAtIndex:cont] objectForKey:LMostrar]];
        NSString *noticia_descripcion = [NSString stringWithFormat:@"%@",[[json[LNoticia] objectAtIndex:cont] objectForKey:LNoticia_Descripcion]];
        NSString *tipo_noticia = [NSString stringWithFormat:@"%@",[[json[LNoticia] objectAtIndex:cont] objectForKey:LTipo_Noticia]];
        NSString *urlImage = [NSString stringWithFormat:@"%@", [[json[LNoticia] objectAtIndex:cont] objectForKey:LUrl_Imagen]];
        NSString *urlVideo = [NSString stringWithFormat:@"%@", [[json[LNoticia] objectAtIndex:cont] objectForKey:LUrl_Video]];
        
        NSNumber *idNoticia = @([[[json[LNoticia] objectAtIndex:cont] objectForKey:LId_Noticia] integerValue]);
        ///Se guarda en base de datos la noticia - Error "No visible interface...Declares the selector"
        [store saveDataNews:idNoticia titulo:titulo noticia_descripcion:noticia_descripcion fecha_noticia:fecha_noticia hora_noticia:[[json[LNoticia] objectAtIndex:cont] objectForKey:LHora] url_imagen:urlImage url_video:urlVideo tipo_noticia:tipo_noticia muestra:muestra];
        
        /*LManagerObject *store = [LManagerObject sharedStore];
        NSArray *noticias = [store showData:@"LMNoticia"];
        for(int cont=0; cont<noticias.count; cont++){
            LMNoticia *noticia = [noticias objectAtIndex:cont];
            NSLog(@"que traeee %@", noticia.id_noticia);
        }*/
    }
}

@end
