//
//  UIControllerMain.m
//  Lazos
//
//  Created by Programacion on 9/8/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIControllerMain.h"
#import "CustomCell.h"
#import "LManagerObject.h"
#import "LHeaderCell.h"
#import "LFooterCell.h"
#import "LUtil.h"
#import "LConstants.h"
#import "NoticiasViewController.h"

@interface UIControllerMain()

@property (strong, nonatomic) LMPadrino *padrino;
@property () CGFloat width;
@property () CGFloat height;

@end

@implementation UIControllerMain

/**
 Metodo que llena el arreglo de los textos que tendra el menu
 */
-(NSArray *)arrayMenu{
    if(! _arrayMenu){
        _arrayMenu = [[NSArray alloc]initWithObjects:@"Mis ahijados", @"Buzón", @"Noticias de tu interés", @"Mis aportaciones", @"Mis logros como Padrino", @"Ajustes", nil];
    }
    return _arrayMenu;
}

/**
 Metodo que llena el arreglo con las imagenes correspondientes a cada opcion del menu
 */
-(NSArray *)arrayImage{
    if(! _arrayImage){
        _arrayImage = [[NSArray alloc]initWithObjects:@"ic_image_menu_ahijados.png", @"ic_image_menu_buzon.png", @"ic_image_menu_noticias.png", @"ic_image_menu_aportaciones.png", @"ic_image_menu_logros.png", @"ic_image_menu_ajustes.png", nil];
    }
    return _arrayImage;
}

-(NSArray *)arrayImageSelect{
    if(! _arrayImageSelect){
        _arrayImageSelect = [[NSArray alloc]initWithObjects:@"ic_image_menu_ahijados_pulsado.png", @"ic_image_menu_buzon_pulsado.png", @"ic_image_menu_noticias_pulsado.png", @"ic_image_menu_aportaciones_pulsado.png", @"ic_image_menu_logros_pulsado.png", @"ic_image_menu_ajustes_pulsado.png", nil];
    }
    return _arrayImageSelect;
}

/**
 Metodo que trae de la base de datos el padrino que acaba de iniciar sesion
 */
-(NSArray *)dataBase{
    LManagerObject *store = [LManagerObject sharedStore];
    _dataBase = [store showData:LTableNamePadrino];
    
    return _dataBase;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    //se obtiene el padrino en sesion de la base de datos
    for(int cont=0; cont<[self dataBase].count; cont++){
        self.padrino = [[self dataBase] objectAtIndex:cont];
        NSLog(@"Padrino que acaba de iniciar sesión de la base de datos %@",self.padrino);
    }
    self.width = [UIScreen mainScreen].bounds.size.width;
    self.height = [UIScreen mainScreen].bounds.size.height;
    
}

/**
 Metodo para agregar el numero de veces que apareceran los elementos de la tabla
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 Metodo que devuelve el numero de renglones en la tabla
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayMenu.count;
}

/**
 Metodo que coloca los elementos en la tabla
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //se instancia una celda que se creo para que tenga el formato que es como se necesita
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:LCustomCellMenu];
    if(!cell){
        //se registra el nib de la clase que se colocara en cada celda
        /*[tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"CustomCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];*/
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:LCustomCellMenu owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if(indexPath.row == 2){
        //se agrega una imagen a la celda, la que estara pulsada
        cell.imagenMenu.image = [UIImage imageNamed:[[self arrayImageSelect] objectAtIndex:indexPath.row]];
        //se cambia el color de la letra a el texto
        cell.opcionesMenu.textColor = [UIColor colorWithRed:16/255.0 green:28/255.0 blue:133/255.0 alpha:1.0];
        //se agrega la animacion de que este presionada en la tabla la celda inicial
        [tableView selectRowAtIndexPath:indexPath
                   animated:YES
                   scrollPosition:UITableViewScrollPositionNone];
    }else{
        //se agrega una imagen a la celda
        cell.imagenMenu.image = [UIImage imageNamed:[self.arrayImage objectAtIndex:indexPath.row]];
    }
    //se sgrega texto a la celda
    cell.opcionesMenu.text = [self.arrayMenu objectAtIndex:indexPath.row];
    //se quita el color para que se muestre el fondo de el menu
    cell.backgroundColor = [UIColor clearColor];
    NSLog(@"el ancho %lu", (long)self.width);
    NSLog(@"el alto %lu", (long)self.height);
    if(self.width <= 320 && self.height <= 500){
        [cell.opcionesMenu setFont:[UIFont systemFontOfSize:10]];
    }
    
    return cell;
    
}

/**
 Metodo que le da un tamaño al encabezado de la tabla
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 110;
    }else{
        return 210;
    }
}

/**
 Metodo que agrega un encabezado a la tabla
 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    LHeaderCell *cellHeader = [tableView dequeueReusableCellWithIdentifier:LHeaderCellMenu];
    
    if (cellHeader == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:LHeaderCellMenu owner:self options:nil];
        cellHeader = [nib objectAtIndex:0];
    }
    //se instancia la clase que contiene el metodo que realiza el calculo entre las fechas, para saber que nivel es el padrino
    LUtil *util = [LUtil instance];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:self.padrino.date_entered];
    NSLog(@"que traeeee %@", self.padrino.date_entered);
    NSString *tipoNivel = [util calculateDateLevel:date];
    cellHeader.nivel.text = tipoNivel;
    if([self.padrino.gender isEqualToString:@"female"]){
        cellHeader.padrinos.text = @"Madrina";
    }else{
        cellHeader.padrinos.text = @"Padrino";
    }
    cellHeader.backgroundColor = [UIColor clearColor];
    
    return cellHeader;
}

/**
 Metodo que le da un tamaño al pie de pagina de la tabla
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSLog(@"el ancho %lu", (long)self.width);
    NSLog(@"el alto %lu", (long)self.height);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if(self.width <= 320 && self.height <= 500){
            return 120;
        }else if(self.width >= 375 && self.height >= 650){
            return 240;
        }else{
            return 150;
        }
    }else{
        return 300;
    }
}

/**
 Metodo que agrega un pie de pagina a la tabla
 */
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    LFooterCell *cellFooter = [tableView dequeueReusableCellWithIdentifier:LFooterCellMenu];
    
    if (cellFooter == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:LFooterCellMenu owner:self options:nil];
        cellFooter = [nib objectAtIndex:0];
    }
    if(self.width >= 375 && self.height >= 650){
        cellFooter.espacioIzquierda.constant = 80;
        cellFooter.espacioDerecha.constant = 80;
    }
    NSLog(@"izquierda %f", cellFooter.espacioIzquierda.constant);
    NSLog(@"derecha %f", cellFooter.espacioDerecha.constant);
    if([self.padrino.gender isEqualToString:@"female"]){
        [cellFooter.imageFooter setImage:[UIImage imageNamed:@"ic_image_madrina.png"]];
    }else{
        [cellFooter.imageFooter setImage:[UIImage imageNamed:@"ic_image_padrino.png"]];
    }
    cellFooter.backgroundColor = [UIColor clearColor];
    
    return cellFooter;
}

/**
 Metodo que controla el click sobre los elementos de la tabla del menu de navegacion
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //se obtiene la celda que se esta seleccionando en la tabla
    CustomCell *cell = (CustomCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.imagenMenu.image = [UIImage imageNamed:[[self arrayImageSelect] objectAtIndex:indexPath.row]];
    cell.opcionesMenu.textColor = [UIColor colorWithRed:16/255.0 green:28/255.0 blue:133/255.0 alpha:1.0];
    if(indexPath.row == 0){
        [self performSegueWithIdentifier:LMenuAhijados sender:cell];
    }else if(indexPath.row == 1){
        [self performSegueWithIdentifier:LMenuBuzon sender:cell];
    }else if(indexPath.row == 2){
        //guardar en preferencias el tipo de noticias
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:[NSNumber numberWithBool:YES]
                              forKey:LMenuNoticiasMensaje];
        [self performSegueWithIdentifier:LMenuNoticias sender:cell];
    }else if(indexPath.row == 3){
        [self performSegueWithIdentifier:LMenuAportaciones sender:cell];
    }else if(indexPath.row == 4){
        [self performSegueWithIdentifier:LMenuLogros sender:cell];
    }else if(indexPath.row == 5){
        [self performSegueWithIdentifier:LMenuAjustes sender:cell];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //se obtiene la celda que se esta deseleccionando en la tabla
    CustomCell *cell = (CustomCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.imagenMenu.image = [UIImage imageNamed:[[self arrayImage] objectAtIndex:indexPath.row]];
    cell.opcionesMenu.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
}

/**
 metodo que devuelve el tamaño de las celdas de la tabla
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //esta comparacion es para que se vea mas pequeño el footer en el 4s
    if(self.width <= 320 && self.height <= 500){
        return 40;
    }else{
        return 45;
    }
}

@end