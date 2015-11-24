//
//  STManagerObject.m
//  Lazos
//
//  Created by Programacion on 9/4/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LManagerObject.h"
#import "AppDelegate.h"
#import "LMPadrino.h"
#import "LMNoticia.h"
#import "LMAhijado.h"
#import "LMBuzon.h"
#import "LMBuzonRecibidos.h"

@interface LManagerObject()

@property (nonatomic, strong) NSManagedObjectModel *model;
@property (nonatomic, strong) NSManagedObjectContext *context;

@end


@implementation LManagerObject

- (id)init {
    if (self = [super init]) {
        /*[self initManagedObjectModel];
         [self initManagedObjectContext];*/
        self.context = [self managedObjectContext];
    }
    return self;
}

#pragma -mark SendException
- (void) sendException
{
    @throw [NSException exceptionWithName:@"Operation in other thread" reason:@"Operations with STManagedObject must be in main thread" userInfo:nil];
}

// 2
#pragma mark - static methods
+ (LManagerObject *)sharedStore {
    static LManagerObject *store;
    if (store == nil) {
        store = [[LManagerObject alloc] init];
    }
    return store;
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

#pragma - mark Delete entity
- (void) deleteEntity:(NSManagedObject *) object
{
    [self.managedObjectContext deleteObject:object];
}

#pragma -mark Save local context
- (void)saveLocalContext
{
    NSError *error = nil;
    [self.managedObjectContext save:&error];
}

// 9
- (void)save:(NSError *)error {
    [self.context save:&error];
}

- (LMPadrino *)createFormula:(NSString *) name {
    return [NSEntityDescription insertNewObjectForEntityForName:name
                                         inManagedObjectContext:self.context];
}

-(void)saveDataGodfather:(NSString *)token nip:(NSNumber *)nip_godfather name:(NSString *)name apellidos:(NSString *)apellidos gender:(NSString *)gender number:(NSNumber *)no_godchildren date:(NSString *)date_entered rfc:(NSString *)RFC
{
    
    LManagerObject *store = [LManagerObject sharedStore];
    LMPadrino *padrino = [store createFormula:@"LMPadrino"];
    padrino.token = token;
    padrino.nip_godfather = nip_godfather;
    padrino.name = name;
    padrino.gender = gender;
    padrino.no_godchildren = no_godchildren;
    padrino.date_entered = date_entered;
    padrino.apellidos = apellidos;
    padrino.rfc = RFC;
    
    NSError *error;
    [store save:error];
    if (error) {
        [NSException raise:@"Couldn't Save to Persistence Store"
                    format:@"Error: %@", error.localizedDescription];
    }else{
        NSLog(@"guardado correctamente %@", nip_godfather);
    }
}

// 7
- (void)deleteData:(NSManagedObject *)manage {
    [self.context deleteObject:manage];
    NSError * error = nil;
    if (![self.context save:&error])
    {
        NSLog(@"Error ! %@", error);
    }else{
        NSLog(@"todo bien %@", self.context);
    }
}

-(NSArray*)showData:(NSString*)name{
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:name inManagedObjectContext:self.context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    
    NSError *error = nil;
    NSArray *array = [self.context executeFetchRequest:request error:&error];
    if (array == nil)
    {
        // Controlamos los posibles errores
    }
    return array;
}

///Noticias Main
- (LMNoticia *)createFormulaN:(NSString *) name {
    return [NSEntityDescription insertNewObjectForEntityForName:name
                                         inManagedObjectContext:self.context];
}

-(void)saveDataNews:(NSNumber *)idNoticia titulo:(NSString *)titulo noticia_descripcion:(NSString *)noticia_descripcion fecha_noticia:(NSDate *)fecha hora_noticia:(NSString *)hora url_imagen:(NSString *)url_imagen url_video:(NSString *)url_video tipo_noticia:(NSString *)tipo muestra:(NSString *)mostrar {
    LManagerObject *store = [LManagerObject sharedStore];
    LMNoticia *noticia = [store createFormulaN:@"LMNoticia"];
    noticia.id_noticia = idNoticia;
    noticia.titulo = titulo;
    noticia.noticia_descripcion = noticia_descripcion;
    noticia.fecha = fecha;
    noticia.hora = hora;
    noticia.url_imagen = url_imagen;
    noticia.url_video = url_video;
    noticia.tipo_noticia = tipo;
    noticia.mostrar = mostrar;
                          
    NSError *error;
    [store save:error];
    if (error) {
        [NSException raise:@"Couldn't Save to Persistence Store"
            format:@"Error: %@", error.localizedDescription];
    }else{
        NSLog(@"Noticia guardada correctamente %@", idNoticia);
    }
}

///Ahijado Información
- (LMAhijado *)createFormulaA:(NSString *) name {
    return [NSEntityDescription insertNewObjectForEntityForName:name
                                         inManagedObjectContext:self.context];
}

-(void)saveDataAhijadoInformacion:(NSString *)apellido_materno_ahijado apellidoPaternoAhijado:(NSString *)apellido_paterno_ahijado calificacionCiencias:(NSNumber *)calificacion_ciencias calificacionEspanol:(NSNumber *)calificacion_espanol calificacionMatematicas:(NSNumber *)calificacion_matematicas cicloEscolar:(NSString *)ciclo_escolar fechaNacimientoAhijado:(NSDate *)fecha_nacimiento_ahijado filial:(NSString *)filial fotoAhijado:(NSString *)foto_ahijado grado:(NSNumber *)grado grupo:(NSString *)grupo gustos:(NSString *)gustos nipAhijado:(NSString *)nip_ahijado nombreAhijado:(NSString *)nombre_ahijado nombreEscuela:(NSString *)nombre_escuela nivel:(NSString *)nivel tallaCalzado:(NSNumber *)talla_calzado tallaRopa:(NSNumber *)talla_ropa nip_escuela:(NSString *)nip_escuela{
    
    LManagerObject *store = [LManagerObject sharedStore];
    LMAhijado *ahijado = [store createFormulaA:@"LMAhijado"];
    ahijado.apellido_materno_ahijado = apellido_materno_ahijado;
    ahijado.apellido_paterno_ahijado = apellido_paterno_ahijado;
    ahijado.calificacion_ciencias = calificacion_ciencias;
    ahijado.calificacion_espanol = calificacion_espanol;
    ahijado.calificacion_matematicas = calificacion_matematicas;
    ahijado.ciclo_escolar = ciclo_escolar;
    ahijado.fecha_nacimiento_ahijado = fecha_nacimiento_ahijado;
    ahijado.filial = filial;
    ahijado.foto_ahijado = foto_ahijado;
    ahijado.grado = grado;
    ahijado.grupo = grupo;
    ahijado.gustos = gustos;
    ahijado.nip_ahijado = nip_ahijado;
    ahijado.nombre_ahijado = nombre_ahijado;
    ahijado.nombre_escuela = nombre_escuela;
    ahijado.nivel = nivel;
    ahijado.talla_ropa = talla_calzado;
    ahijado.talla_calzado = talla_ropa;
    ahijado.ni_escuela = nip_escuela;
    
    NSError *error;
    [store save:error];
    if (error) {
        [NSException raise:@"Couldn't Save to Persistence Store"
                    format:@"Error: %@", error.localizedDescription];
    }else{
        NSLog(@"Información de Ahijado guardado correctamente %@%@", nip_ahijado, nombre_ahijado);
    }

}

- (NSMutableArray *) fetchResultsForEntityName:(NSString *) entityName withPredicate: (NSPredicate *) predicate
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    if (predicate)
    {
        [fetchRequest setPredicate:predicate];
    }
    
    // Execute the fetch -- create a mutable copy of the result.
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    return mutableFetchResults;
}

-(LMAhijado*)shareNip:(NSNumber*)nip{
    
    NSMutableArray * array = [self fetchResultsForEntityName:@"LMAhijado" withPredicate:[NSPredicate predicateWithFormat:@"nip_ahijado=%@", nip]];
    
    if (array.count)
    {
        LMAhijado *ahijado = [array objectAtIndex:0];
        NSLog(@"lo de la consulta -------------> %@", ahijado.nombre_ahijado);
        return [array objectAtIndex:0];
    }else{
        return nil;
    }
    
    return (LMAhijado *)[self createFormulaA:@"LMAhijado"];
}

///crear la entidiad de LMBuzon
- (LMBuzon *)createBuzon:(NSString *) name {
    return [NSEntityDescription insertNewObjectForEntityForName:name
                                         inManagedObjectContext:self.context];
}

-(void)saveDataBuzon:(NSString *)id_buzon fecha:(NSString *)fecha_buzon descripcion:(NSString *)descripcion filial:(NSString *)filial nombre:(NSString *)nombre nip_padrino:(NSString *)nip_padrino estatus:(NSString *)estatus tipo:(NSString *)tipo{
    
    LManagerObject *store = [LManagerObject sharedStore];
    LMBuzon *buzon = [store createBuzon:@"LMBuzon"];
    buzon.id_buzon = id_buzon;
    buzon.fecha_buzon = fecha_buzon;
    buzon.descripcion = descripcion;
    buzon.filial = filial;
    buzon.nombre = nombre;
    buzon.nip_padrino = nip_padrino;
    buzon.estatus = estatus;
    buzon.tipo = tipo;
    
    NSError *error;
    [store save:error];
    if (error) {
        [NSException raise:@"Couldn't Save to Persistence Store"
                    format:@"Error: %@", error.localizedDescription];
    }else{
        NSLog(@"Información de Ahijado guardado correctamente %@", buzon.id_buzon);
    }
    
}

-(LMBuzon*)shareIdBuzon:(NSString*)idBuzon{
    
    NSMutableArray * array = [self fetchResultsForEntityName:@"LMBuzon" withPredicate:[NSPredicate predicateWithFormat:@"id_buzon=%@", idBuzon]];
    
    if (array.count)
    {
        LMBuzon *buzon = [array objectAtIndex:0];
        NSLog(@"lo de la consulta -------------> %@", buzon.id_buzon);
        return [array objectAtIndex:0];
    }
    
    return (LMBuzon *)[self createBuzon:@"LMBuzon"];
}

///crear la entidiad de LMBuzon
- (LMBuzonRecibidos *)createBuzonRecibidos:(NSString *) name {
    return [NSEntityDescription insertNewObjectForEntityForName:name
                                         inManagedObjectContext:self.context];
}

- (void)saveDataRecibidos:(NSString *)apellido caso:(NSNumber *)caso categoria:(NSString *)categoria fecha:(NSString *)fecha foto:(NSString *)foto hora:(NSString *)hora id_buzon:(NSNumber *)id_buzon id_ahijado:(NSNumber *)id_ahijado id_padrino:(NSNumber *)id_padrino nip_ahijado:(NSNumber *)nip_ahijado nip_padrino:(NSNumber *)nip_padrino nombre:(NSString *)nombre texto:(NSString *)texto tipo:(NSString *)tipo titulo:(NSString *)titulo url_imagen_opcional:(NSString *)url_imagen_opcional url_imagen_respuesta:(NSString *)url_imagen_respuesta{
    
    LManagerObject *store = [LManagerObject sharedStore];
    LMBuzonRecibidos *buzon = [store createBuzonRecibidos:@"LMBuzonRecibidos"];
    buzon.apellido_ahijado = apellido;
    buzon.caso = caso;
    buzon.categoria = categoria;
    buzon.fecha = fecha;
    buzon.foto_ahijado = foto;
    buzon.hora = hora;
    buzon.id_buzon = id_buzon;
    buzon.id_ahijado = id_ahijado;
    buzon.id_padrino = id_padrino;
    buzon.nip_ahijado = nip_ahijado;
    buzon.nip_padrino = nip_padrino;
    buzon.nombre_ahijado = nombre;
    buzon.texto = texto;
    buzon.tipo = tipo;
    buzon.titulo = titulo;
    buzon.url_imagen_opcional = url_imagen_opcional;
    buzon.url_imagen_respuesta = url_imagen_respuesta;
    
    NSError *error;
    [store save:error];
    if (error) {
        [NSException raise:@"Couldn't Save to Persistence Store"
                    format:@"Error: %@", error.localizedDescription];
    }else{
        NSLog(@"Información de Ahijado guardado correctamente %@", buzon.id_buzon);
    }
    
}

@end