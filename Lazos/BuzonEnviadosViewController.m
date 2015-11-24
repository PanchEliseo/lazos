//
//  BuzonEnviadosViewController.m
//  Lazos
//
//  Created by sferea on 18/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import "BuzonEnviadosViewController.h"
#import "BuzonRegaloTableViewCell.h"
#import "BuzonCartaTableViewCell.h"
#import "LUIViewControllerMensajes.h"
#import "LServiceObjectBuzon.h"
#import "LMPadrino.h"
#import "LUtil.h"
#import "BuzonViewController.h"
#import "LConstants.h"
#import "LServicesObjectAhijado.h"
#import "UIImageView+WebCache.h"
#import "LManagerObject.h"
#import "LMAhijado.h"

@interface BuzonEnviadosViewController ()

@property (strong, nonatomic)BuzonViewController *buzon;
@property (strong, nonatomic)NSDictionary *responseAhijado;
@property (strong, nonatomic)NSMutableArray *array;
@property (strong, nonatomic)LMAhijado *ahijado;
@property (strong, nonatomic)NSArray *ahijadosBase;

@end

@implementation BuzonEnviadosViewController

///Arreglo para pruebas
NSArray *buzonEnviados;

///Identificador de la celda para Regalos
static NSString *CellIdBuzonRegalo = @"BuzonRegaloTableViewCell";
///Identificador de la celda para Cartas
static NSString *CellIdBuzonCarta = @"BuzonCartaTableViewCell";

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //LLena arreglo de saludo para prueba
    buzonEnviados = [[NSArray alloc] init];
    buzonEnviados = [NSArray arrayWithObjects:@"¡Felicidades!", @"¡Feliz Cumpleaños!", @"¡Feliz graduación!", @"¡Feliz Navidad!", @"¡Muchas felicidades!", @"Excelenteeee", nil];
    self.buzon = (BuzonViewController*)self.parentViewController;
    if([self.tipoMenu isEqualToString:@"ahijados"]){
        self.constraintButton.constant = 152;
    }
    
}

- (NSArray *)ahijadosBase{
 
    LManagerObject *store = [LManagerObject sharedStore];
    ///Se obtiene la noticia de la base
    _ahijadosBase = [store showData:LTableNameAhijado];
    return _ahijadosBase;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.table reloadData];
    
}

#pragma mark - UIViewDataSource
///Informa al table view cuantas filas habrá en la sección dependiendo de la cantidad de mensajes de cartas y regalos en el buzón de Enviados
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger cantidadEnviados;
    self.array = [[NSMutableArray alloc] init];
    ///Trae de la base, el "name" de cada enviado para devolver solo aquellos enviados que cumplan con el formato especificado por Lazos en el name
    //NSLog(@"Lo que trae la respuesta de Enviados en numberOfRowsInSection sin condiciones - %@", self.response[LBuzon]);
    
    for(int cont=0; cont<[self.response[LBuzon] count]; cont++){
        NSString *name = [[self.response[LBuzon] objectAtIndex:cont] objectForKey:LName];
        ///Obtiene solo aquellos que junto al NIP tienen la cadena 'APP' o 'WEB'
        if([name componentsSeparatedByString:@"APP"].count == 2 || [name componentsSeparatedByString:@"WEB"].count == 2){
            [self.array addObject:[self.response[LBuzon] objectAtIndex:cont]];
            //NSLog(@"LBuzon: %@ Contador: %d ", [self.response[LBuzon] objectAtIndex:cont], cont);
            
            //NSLog(@"Cadena completa: %@, Cadena 1: %@, Cadena 2: %@, No. cadenas: %d", name, [[name componentsSeparatedByString:@"APP"] objectAtIndex:0], [[name componentsSeparatedByString:@"APP"] objectAtIndex:1], [name componentsSeparatedByString:@"APP"].count);
        }
    }
    
    cantidadEnviados = [self.array count];
    
    ///Regresa el número de items en el arreglo
    return cantidadEnviados;
}

#pragma mark - UIViewDelegate
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
}

///Se llama a éste método cuando la tabla es mostrada
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if([[[self.array objectAtIndex:indexPath.row] objectForKey:LTipoCartas] isEqualToString:@"Cartas"]){
        ///Reutiliza la celda si existe
        BuzonCartaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdBuzonCarta];
        
        ///Crea la celda si no existe
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdBuzonCarta owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        NSLog(@"la cantidad de enviados de tipo cartas %lu", (unsigned long)[self.array count]);
        //se obtiene la descripcion del servicio, y se separa en dos frases, la primera esta compuesta por tres palabras que hacen el titulo las demas seran la descripcion, esto porque asi lo pidio Lazos
        NSString *string = [[self.array objectAtIndex:indexPath.row] objectForKey:LDescripcion];
        NSString *titulo = @"";
        NSString *descripcion = @"";
        NSArray *array = [string componentsSeparatedByString:@" "];
        for(int cont=0; cont<array.count; cont++){
            if(cont <= 2){
                titulo = [titulo stringByAppendingString:[array objectAtIndex:cont]];
                titulo = [titulo stringByAppendingString:@" "];
            }else{
                descripcion = [descripcion stringByAppendingString:[array objectAtIndex:cont]];
                descripcion = [descripcion stringByAppendingString:@" "];
            }
        }
        
        //se le da el formato a dete a la fecha del web service para poder cambiarle el formato
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
        //HH para el formato de 24 horas
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate * fecha_noticia = [dateFormatter dateFromString:[[self.array objectAtIndex:indexPath.row] objectForKey:LFechaBuzon]];
        //se le da el formato requerido a la fecha
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
        [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [formatter setDateFormat:@"dd/MMMM/YYYY"];
        NSString *resultDate = [formatter stringFromDate:fecha_noticia];
        ///Asigna la información a cada Enviado
        cell.tituloCarta.text = titulo;
        cell.descripcionCarta.text = descripcion;
        cell.fechaCarta.text = resultDate;
        
        /*NSString *nameCadena = [[self.array objectAtIndex:indexPath.row] objectForKey:LName];
        //esto se va a quitar hasta que este la version final
        //se busca en la cadena los que estan separados por el caracter para obtener en la segunda posicion el nip del ahijado y el numero de plantilla
        NSArray *arraySeparate = [nameCadena componentsSeparatedByString:@"-"];
        NSMutableArray *arrayTwo = [[NSMutableArray alloc] init];
        for(int cont=0; cont<[arraySeparate count]; cont++){
            NSLog(@"que locoooooo %d *** %@", cont, [arraySeparate objectAtIndex:cont]);
            if(cont == 2){
                //se guarda en un nuevo arreglo el nip de padrino y la plantilla, para despues separarlos y utilizar cada dato
                [arrayTwo addObject:[arraySeparate objectAtIndex:cont]];
            }
        }
        //se obtienen y se guarda el nip del ahijado para obter sus datos correspondiente
        NSString *nipAhijado;
        NSArray *cut;
        if([[arrayTwo objectAtIndex:0] componentsSeparatedByString:@"APP"].count > 1){
            cut = [[arrayTwo objectAtIndex:0] componentsSeparatedByString:@"APP"];
        }else if([[arrayTwo objectAtIndex:0] componentsSeparatedByString:@"WEB"].count > 1){
            cut = [[arrayTwo objectAtIndex:0] componentsSeparatedByString:@"WEB"];
        }
        for(int cont=0; cont<[cut count]; cont++){
            NSLog(@"****** %@", [cut objectAtIndex:cont]);
            if(cont == 0){
                nipAhijado = [cut objectAtIndex:cont];
            }
        }
        NSNumberFormatter *form = [[NSNumberFormatter alloc] init];*/
        NSNumber *nipNumero = [self oftenNip:indexPath];
        LManagerObject *ahijadoDetalle = [LManagerObject sharedStore];
        self.ahijado = [ahijadoDetalle shareNip:nipNumero];
        
        NSString *fotoAhijado;
        for(int cont=0; cont<[self.responseAhijados[LAhijadoJson] count]; cont++){
            if([self.ahijado.nip_ahijado isEqualToString:[[self.responseAhijados[LAhijadoJson] objectAtIndex:cont] objectForKey:LNipAhijado]]){
                fotoAhijado = [[self.responseAhijados[LAhijadoJson] objectAtIndex:cont] objectForKey:LFotoAhijado];
            }
        }
        NSLog(@"ahijado %@", fotoAhijado);
        //se asigna la imagen
        if(fotoAhijado){
            NSString *urlImagenAhijado = [@"http://201.175.10.244/" stringByAppendingString:fotoAhijado];
            NSURL *url = [NSURL URLWithString:urlImagenAhijado];
            [cell.imagenAhijadoCarta sd_setImageWithURL:url placeholderImage:[UIImage alloc]];
        }
        
        return cell;
    }else if([[[self.array objectAtIndex:indexPath.row] objectForKey:LTipoCartas] isEqualToString:@"Regalos"]){
        ///Reutiliza la celda si existe
        BuzonRegaloTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdBuzonRegalo];
        
        ///Crea la celda si no existe
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdBuzonRegalo owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        //se obtiene la descripcion del servicio, y se separa en dos frases, la primera esta compuesta por tres palabras que hacen el titulo las demas seran la descripcion, esto porque asi lo pidio Lazos
        NSString *string = [[self.array objectAtIndex:indexPath.row] objectForKey:LDescripcion];
        NSString *titulo = @"";
        NSString *descripcion = @"";
        NSArray *array = [string componentsSeparatedByString:@" "];
        for(int cont=0; cont<array.count; cont++){
            if(cont <= 2){
                titulo = [titulo stringByAppendingString:[array objectAtIndex:cont]];
                titulo = [titulo stringByAppendingString:@" "];
            }else{
                descripcion = [descripcion stringByAppendingString:[array objectAtIndex:cont]];
                descripcion = [descripcion stringByAppendingString:@" "];
            }
        }
        //se le da el formato a dete a la fecha del web service para poder cambiarle el formato
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
        //HH para el formato de 24 horas
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate * fecha_noticia = [dateFormatter dateFromString:[[self.array objectAtIndex:indexPath.row] objectForKey:LFechaBuzon]];
        //se le da el formato requerido a la fecha
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
        [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [formatter setDateFormat:@"dd/MMMM/YYYY"];
        NSString *resultDate = [formatter stringFromDate:fecha_noticia];
        ///Asigna la información a cada Enviado
        cell.bRegaloSaludo.text = titulo;
        cell.bRegaloMensaje.text = descripcion;
        cell.bRegaloFecha.text = resultDate;
        
        /*NSString *nameCadena = [[self.array objectAtIndex:indexPath.row] objectForKey:LName];
        //se busca en la cadena los que estan separados por el caracter para obtener en la segunda posicion el nip del ahijado y el numero de plantilla
        NSArray *arraySeparate = [nameCadena componentsSeparatedByString:@"-"];
        NSMutableArray *arrayTwo = [[NSMutableArray alloc] init];
        for(int cont=0; cont<[arraySeparate count]; cont++){
            //NSLog(@"que locoooooo %d *** %@", cont, [arraySeparate objectAtIndex:cont]);
            if(cont == 2){
                //se guarda en un nuevo arreglo el nip de padrino y la plantilla, para despues separarlos y utilizar cada dato
                [arrayTwo addObject:[arraySeparate objectAtIndex:cont]];
            }
        }
        //se obtienen y se guarda el nip del ahijado para obter sus datos correspondientes
        NSString *nipAhijado;
        NSArray *cut;
        if([[arrayTwo objectAtIndex:0] componentsSeparatedByString:@"APP"].count > 1){
            cut = [[arrayTwo objectAtIndex:0] componentsSeparatedByString:@"APP"];
        }else if([[arrayTwo objectAtIndex:0] componentsSeparatedByString:@"WEB"].count > 1){
            cut = [[arrayTwo objectAtIndex:0] componentsSeparatedByString:@"WEB"];
        }
        for(int cont=0; cont<[cut count]; cont++){
            NSLog(@"****** %@", [cut objectAtIndex:cont]);
            if(cont == 0){
                nipAhijado = [cut objectAtIndex:cont];
            }
        }
        NSLog(@"el nip de los ahijados %@", nipAhijado);
        NSNumberFormatter *form = [[NSNumberFormatter alloc] init];*/
        NSNumber *nipNumero = [self oftenNip:indexPath];
        LManagerObject *ahijadoDetalle = [LManagerObject sharedStore];
        self.ahijado = [ahijadoDetalle shareNip:nipNumero];
        NSLog(@"el ahijado %@", self.ahijado.nip_ahijado);
        
        NSString *fotoAhijado;
        for(int cont=0; cont<[self.responseAhijados[LAhijadoJson] count]; cont++){
            if([self.ahijado.nip_ahijado isEqualToString:[[self.responseAhijados[LAhijadoJson] objectAtIndex:cont] objectForKey:LNipAhijado]]){
                fotoAhijado = [[self.responseAhijados[LAhijadoJson] objectAtIndex:cont] objectForKey:LFotoAhijado];
            }
        }
        NSLog(@"ahijado %@", fotoAhijado);
        //se asigna la imagen
        if(fotoAhijado){
            NSString *urlImagenAhijado = [@"http://201.175.10.244/" stringByAppendingString:fotoAhijado];
            NSURL *url = [NSURL URLWithString:urlImagenAhijado];
            [cell.bRegaloFoto sd_setImageWithURL:url placeholderImage:[UIImage alloc]];
        }
        
        return cell;
    }else{
        return nil;
    }
}

///Establece la altura de las filas del Table View de Enviados
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.view.frame.size.height / 5;
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 100;
    }else{
        return 200;
    }*/
}

/**
 Metodo que controla el click sobre los elementos de la tabla de las noticias
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.parentViewController.parentViewController isKindOfClass:[UINavigationController class]]){
        //se hace la ejecucion del seague que llevara a la siguiente pantalla, este se obtiene del viewController padre porque es el que contiene el navigationController y el que puede ejecutar el seague
        NSLog(@"***** %@", [[self.array objectAtIndex:indexPath.row] objectForKey:LIdBuzon]);
        [self.parentViewController performSegueWithIdentifier:@"mensajes" sender:self.parentViewController];
        NSString *tipoSegue = [[self.array objectAtIndex:indexPath.row] objectForKey:LIdBuzon];
        [[NSUserDefaults standardUserDefaults] setObject:tipoSegue forKey:@"idBuzon"];
        //Variable de preferencias
        NSNumber *nipNumero = [self oftenNip:indexPath];
        LManagerObject *ahijadoDetalle = [LManagerObject sharedStore];
        self.ahijado = [ahijadoDetalle shareNip:nipNumero];
        [[NSUserDefaults standardUserDefaults] setObject:self.ahijado.nip_ahijado forKey:@"LNipAhijado"];
    }else{
        [self.parentViewController performSegueWithIdentifier:@"mensajesSubMenu" sender:self.parentViewController];
        NSString *tipoSegue = [[self.array objectAtIndex:indexPath.row] objectForKey:LIdBuzon];
        [[NSUserDefaults standardUserDefaults] setObject:tipoSegue forKey:@"idBuzon"];
        //Variable de preferencias
        NSNumber *nipNumero = [self oftenNip:indexPath];
        LManagerObject *ahijadoDetalle = [LManagerObject sharedStore];
        self.ahijado = [ahijadoDetalle shareNip:nipNumero];
        [[NSUserDefaults standardUserDefaults] setObject:self.ahijado.nip_ahijado forKey:@"LNipAhijado"];
    }
}

- (NSNumber *)oftenNip:(NSIndexPath *)indexPath{
 
    NSString *nameCadena = [[self.array objectAtIndex:indexPath.row] objectForKey:LName];
    //esto se va a quitar hasta que este la version final
    //se busca en la cadena los que estan separados por el caracter para obtener en la segunda posicion el nip del ahijado y el numero de plantilla
    NSArray *arraySeparate = [nameCadena componentsSeparatedByString:@"-"];
    NSMutableArray *arrayTwo = [[NSMutableArray alloc] init];
    for(int cont=0; cont<[arraySeparate count]; cont++){
        NSLog(@"que locoooooo %d *** %@", cont, [arraySeparate objectAtIndex:cont]);
        if(cont == 2){
            //se guarda en un nuevo arreglo el nip de padrino y la plantilla, para despues separarlos y utilizar cada dato
            [arrayTwo addObject:[arraySeparate objectAtIndex:cont]];
        }
    }
    //se obtienen y se guarda el nip del ahijado para obter sus datos correspondiente
    NSString *nipAhijado;
    NSArray *cut;
    if([[arrayTwo objectAtIndex:0] componentsSeparatedByString:@"APP"].count > 1){
        cut = [[arrayTwo objectAtIndex:0] componentsSeparatedByString:@"APP"];
    }else if([[arrayTwo objectAtIndex:0] componentsSeparatedByString:@"WEB"].count > 1){
        cut = [[arrayTwo objectAtIndex:0] componentsSeparatedByString:@"WEB"];
    }
    for(int cont=0; cont<[cut count]; cont++){
        NSLog(@"****** %@", [cut objectAtIndex:cont]);
        if(cont == 0){
            nipAhijado = [cut objectAtIndex:cont];
        }
    }
    NSNumberFormatter *form = [[NSNumberFormatter alloc] init];
    NSNumber *nipNumero = [form numberFromString:nipAhijado];
    return nipNumero;
    
}

@end
