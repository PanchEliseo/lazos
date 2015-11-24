//
//  LServiceObjectBuzon.m
//  Lazos
//
//  Created by Programacion on 9/30/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LServiceObjectBuzon.h"
#import "LConstants.h"
#import "LMBuzon.h"
#import "LManagerObject.h"

@interface LServiceObjectBuzon(){
    NSString * tipoDescarga;
}

@end

@implementation LServiceObjectBuzon

- (id)initWithData:(NSString *) nip token:(NSString *) token tipo:(NSString *)tipo{
    self = [super init];
    if (self)
    {
        ///Buzon de enviados
        NSString *urlBuzonEnviados = [NSString stringWithFormat:@"%@%@%@%@", @"http://201.175.10.244/app/regaloscartas.php?nippadrino=", nip, @"&token=", token];
        self.urlService = [NSURL URLWithString:urlBuzonEnviados];
        //self.jsonRequest = [self createJsonPostUser: usuario];
        self.typePetition = LServicePetitionGET;
        self.typeService = SSServiceLogin;
        tipoDescarga = tipo;
        
    }
    return self;
}

- (id)initRecibidos:(NSString *) nip token:(NSString *) token{
    
    self = [super init];
    if(self){
        NSString *urlBuzonRecibidos = [NSString stringWithFormat:@"%@%@%@%@", @"http://apilazos.sferea.com/recibidos?nippadrino=", nip, @"&token=", token];
        self.urlService = [NSURL URLWithString:urlBuzonRecibidos];
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
         if([tipoDescarga isEqualToString:@"enviados"]){
             LManagerObject *store = [LManagerObject sharedStore];
             ///Se obtiene el buzón de la base
             NSArray *buzon = [store showData:@"LMBuzon"];
             
             if (buzon.count != 0) {
                 for(int cont=0; cont<buzon.count; cont++){
                     LMBuzon *buzonDB = [buzon objectAtIndex:cont];
                     [store deleteData:buzonDB];
                 }
                 [self saveData:json store:store];
             } else {
                 [self saveData:json store:store];
             }
         }
         self.customBlock(json,error);
         
     }];
    
}

///Guarda el Buzón de enviados
-(void)saveData:(NSMutableDictionary *)json store:(LManagerObject *)store{
    for(int cont=0; cont<[json[LBuzon] count]; cont++){
        NSString *buzon = [[json[LBuzon] objectAtIndex:cont] objectForKey:LName];
        ///JG - Falta validar los espacios
        if([buzon componentsSeparatedByString:@"-"].count == 3){
            ///Al obtenido arriba quitarle "WEB" o "APP"
            ///Deben pasar aquellos que si tengan la plantilla, obtener el número
            NSString *idBuzon = [[json[LBuzon] objectAtIndex:cont] objectForKey:LIdBuzon];
            NSString *fecha = [[json[LBuzon] objectAtIndex:cont] objectForKey:LFechaBuzon];
            NSString *descripcion = [[json[LBuzon] objectAtIndex:cont] objectForKey:LDescripcion];
            NSString *filial = [[json[LBuzon] objectAtIndex:cont] objectForKey:LFilialBuzon];
            NSString *nombre = [[json[LBuzon] objectAtIndex:cont] objectForKey:LName];
            NSString *nip_padrino = [[json[LBuzon] objectAtIndex:cont] objectForKey:LNipPadrinoBuzon];
            NSString *estatus = [[json[LBuzon] objectAtIndex:cont] objectForKey:LStatusBuzon];
            NSString *tipo = [[json[LBuzon] objectAtIndex:cont] objectForKey:LTipoCartas];
            
            [store saveDataBuzon:idBuzon fecha:fecha descripcion:descripcion filial:filial nombre:nombre nip_padrino:nip_padrino estatus:estatus tipo:tipo];
            
        }
    }
    NSArray *ahijados = [store showData:@"LMBuzon"];
    NSLog(@"la cantidad %ld", (long)[ahijados count]);
}

@end