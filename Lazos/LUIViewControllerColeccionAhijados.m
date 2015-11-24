//
//  LUIViewControllerColeccionAhijados.m
//  Lazos
//
//  Created by Programacion on 9/24/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerColeccionAhijados.h"
#import "LUICustomCellAhijados.h"
#import "LUIViewControllerTabBar.h"
#import "LConstants.h"
#import "UIImageView+WebCache.h"
#import "LUtil.h"
#import "LManagerObject.h"
#import "LServicesObjectAhijado.h"

@interface LUIViewControllerColeccionAhijados()

@property (strong, nonatomic) NSMutableArray *arrayImage;
@property (strong, nonatomic) LUIViewControllerTabBar *controllerContainer;
@property (strong, nonatomic) NSMutableArray *arrayNip;
@property (strong, nonatomic) NSMutableArray *arrayNombres;
@property (strong, nonatomic) LUICustomCellAhijados *cell;

@end

@implementation LUIViewControllerColeccionAhijados

/**
 Metodo que llena el arreglo con las imagenes correspondientes a cada opcion del menu
 */
-(NSArray *)arrayImage{
    if(! _arrayImage){
        _arrayImage = [[NSMutableArray alloc]initWithObjects:@"page1.png", @"page2.png", @"page3.png", @"page4.png", nil];
    }
    return _arrayImage;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    //se setea un titulo al navigation bar
    [self.parentViewController.navigationItem setTitle:@"Mis ahijados"];
    //se cambia de color del navigation bar
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:16/255.0 green:28/255.0 blue:133/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    //se cambia el color del texto del navigation bar
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    self.arrayImage = [[NSMutableArray alloc] init];
    self.arrayNip = [[NSMutableArray alloc] init];
    self.arrayNombres = [[NSMutableArray alloc] init];
    NSLog(@"****** %lu", (unsigned long)[self.ahijado[LAhijadoJson] count]);
    for(int cont=0; cont<[self.ahijado[LAhijadoJson] count]; cont++){
        NSString *urlImagen = [[self.ahijado[LAhijadoJson] objectAtIndex:cont] objectForKey:LFotoAhijado];
        NSString *url = [NSString stringWithFormat:@"%@%@", LServicio, urlImagen];
        NSString *nip = [[self.ahijado[LAhijadoJson] objectAtIndex:cont] objectForKey:LNipAhijado];
        NSString *nombres = [[self.ahijado[LAhijadoJson] objectAtIndex:cont] objectForKey:LNombreAhijado];
        [self.arrayImage addObject:url];
        [self.arrayNip addObject:nip];
        [self.arrayNombres addObject:nombres];
    }
    /*self.ahijadosSeparados = [[NSMutableArray alloc] init];
    for(int cont=0; cont<[self.ahijado[LAhijadoJson] count]; cont++){
        NSString *cicloEscolar = [[self.ahijado[LAhijadoJson] objectAtIndex:cont] objectForKey:LCicloEscolar];
        //se obtiene la fecha actual
        NSDate *today = [NSDate date];
        NSArray *arraySeparate = [cicloEscolar componentsSeparatedByString:@"-"];
        NSString *cicloEscolarActual;
        //se obtiene el año de la fecha actual
        //Formato de fecha de nacimiento
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [dateformatter setDateFormat:@"yyyy"];
        NSString *anoActual = [dateformatter stringFromDate:today];
        if([arraySeparate count] > 1){
            for(int contador=0; contador<[arraySeparate count]; contador++){
                cicloEscolarActual = [arraySeparate objectAtIndex:1];
                if([anoActual isEqualToString:[arraySeparate objectAtIndex:contador]]){
                    [self.ahijadosSeparados addObject:[self.ahijado[LAhijadoJson] objectAtIndex:cont]];
                }
            }
        }
     }
    self.arrayImage = [[NSMutableArray alloc] init];
    self.arrayNip = [[NSMutableArray alloc] init];
    self.arrayNombres = [[NSMutableArray alloc] init];
    NSLog(@"****** %lu", (unsigned long)[self.ahijadosSeparados count]);
    for(int cont=0; cont<self.ahijadosSeparados.count; cont++){
        NSString *urlImagen = [[self.ahijadosSeparados objectAtIndex:cont] objectForKey:LFotoAhijado];
        NSString *url = [NSString stringWithFormat:@"%@%@", LServicio, urlImagen];
        NSString *nip = [[self.ahijadosSeparados objectAtIndex:cont] objectForKey:LNipAhijado];
        NSString *nombres = [[self.ahijadosSeparados objectAtIndex:cont] objectForKey:LNombreAhijado];
        [self.arrayImage addObject:url];
        [self.arrayNip addObject:nip];
        [self.arrayNombres addObject:nombres];
    }*/
     NSLog(@"que traeeee 1 %lu", (unsigned long)self.arrayImage.count);
    
}

/**
 Metodo que devuelve cuantas celdas habra en el collection
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.arrayImage.count;
    
}

/**
 Metodo que inserta la imagen de los ahijados en el collection
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"LUICustomCellAhijados";
    
    LUICustomCellAhijados *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    self.cell = cell;
    NSURL *url = [NSURL URLWithString:[self.arrayImage objectAtIndex:indexPath.row]];
    [cell.imagenAhijados sd_setImageWithURL:url placeholderImage:[UIImage alloc]];
    cell.nombreAhijado.text = [self.arrayNombres objectAtIndex:indexPath.row];
    
    return cell;
    
}

/**
 Metodo que devuelve el numero de veces que aparecera la celda en el colecction
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/**
 Metodo que se dispara al accionar un click sobre las celdas del collection
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LUtil *functions = [LUtil instance];
    LManagerObject *manager = [LManagerObject sharedStore];
    
    LMPadrino *padrino = [functions oftenPadrino];
    NSString * nip = [NSString stringWithFormat:@"%@", padrino.nip_godfather];
    LServicesObjectAhijado *serviceAhijados1 = [[LServicesObjectAhijado alloc] initWithAhijado:nip token:padrino.token nipAhijado:[[self.ahijado[LAhijadoJson] objectAtIndex:indexPath.row] objectForKey:LNipAhijado] tipo:@"ahijados" response:self.ahijado];
    [serviceAhijados1 startDownloadWithCompletionBlock:^(NSDictionary *responseAhijados, NSError *error) {
        NSLog(@"el resultado de mi segunda peticion %@", responseAhijados);
        //se instancia el manejador de la base de datos
        LManagerObject *store = [LManagerObject sharedStore];
        ///Se obtiene los ahijados de la base de datos
        NSArray *ahijados = [store showData:LTableNameAhijado];
        if (ahijados.count != 0) {
            //si ya existen ahijados se eliminan de la base de datos
            for(int cont=0; cont<ahijados.count; cont++){
                LMAhijado *ahijado = [ahijados objectAtIndex:cont];
                [store deleteData:ahijado];
            }
            //se guarda solo el ahijado pulsado
            [functions saveData:self.ahijado methodDave:manager contador:indexPath.row response:responseAhijados];
        } else {
            //se guarda solo el ahijado pulsado
            [functions saveData:self.ahijado methodDave:manager contador:indexPath.row response:responseAhijados];
        }
        NSLog(@"--------------- %@", [self.ahijado[LAhijadoJson] objectAtIndex:indexPath.row]);
        NSLog(@"Se selecciono el ahijado con NIP: %@", [self.arrayNip objectAtIndex:indexPath.row]);
        [[NSUserDefaults standardUserDefaults] setObject:[self.arrayNip objectAtIndex:indexPath.row] forKey:@"LNipAhijado"];
        [self.parentViewController performSegueWithIdentifier:@"menuAhijados" sender:self.parentViewController];
    }];
    
    //JGJGJG Enviara el nip del ahijado seleccionado a guardaCasos 
}

/**
 *@brief metodo que lleva el control del scroll en los collections
 *@param scrollView se utiliza para las actividades del metodo
 */
/*-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint scrollVelocity = [self.collectionView.panGestureRecognizer
                              velocityInView:self.collectionView.superview];
    //se creauna variable con la posicion de y
    CGFloat y = scrollView.contentOffset.y;
    CGFloat heightCell = self.collectionView.frame.size.height / 3;
    //y = y + heightCell;
    double index = 0.0;
    y = y + heightCell;
    
    //se obtiene si se esta bajando o subiendo el scroll del collection
    if(scrollVelocity.y > 0.0f)
    {
        NSLog(@"scroll down");
        index = floor(y / heightCell );
        
        
        
    }else if(scrollVelocity.y < 0.0f){
        NSLog(@"scroll up");
        index = ceil(y / heightCell);
        
    }
}*/

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.arrayImage count] > 2){
        //se busca un tamaño dividiendo el alto del collection se le restan los 20 de los espacios en las filas y celdas
        CGFloat heightCell = collectionView.frame.size.height / 4.1;
        //se retornan los tamaños
        return CGSizeMake(heightCell, heightCell);
    }else{
        //se busca un tamaño dividiendo el alto del collection, este no se le restan los espcios, ya que asi se ven bien con dos
        CGFloat heightCell = collectionView.frame.size.height / 2.6;
        //se retornan los tamaños
        return CGSizeMake(heightCell, heightCell);
    }
 
}

@end