//
//  LUIViewControllerGaleria.m
//  Lazos
//
//  Created by Programacion on 9/24/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerGaleria.h"
#import "LUICustomCellAhijados.h"
#import "LServiceObjectGaleria.h"
#import "LConstants.h"
#import "UIImageView+WebCache.h"
#import "LUIViewControllerDetalleGaleria.h"
//#import "Lazos-Swift.h"
#import "DDIndicator.h"
#import "LMPadrino.h"
#import "LUtil.h"

@interface LUIViewControllerGaleria()

@property (strong, nonatomic) NSMutableArray *arrayImage;
@property (strong, nonatomic) NSString *urlImagen;

@end

@implementation LUIViewControllerGaleria


/**
 Metodo que llena el arreglo con las imagenes correspondientes a cada opcion del menu
 */
-(NSArray *)arrayImage
{
    if(! _arrayImage)
    {
        
        //se crea un spinner para que haga el loader de que esta esperando a que responda el web service de padrino
        //[SwiftSpinner show:@"Descargando fotos..." animated:YES];
        DDIndicator *loader = [[DDIndicator alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 20, self.view.frame.size.height / 2 -20, 40, 40)];
        self.view.backgroundColor = [UIColor blackColor];
        self.view.alpha = 0.5;
        [self.view addSubview:loader];
        [loader startAnimating];
        _arrayImage = [[NSMutableArray alloc] init];
        
        ///Obtiene el padrino de la base de datos
        LUtil *functions = [LUtil instance];
        LMPadrino *padrino = [functions oftenPadrino];
        NSString * nip = [NSString stringWithFormat:@"%@", padrino.nip_godfather];
        
        ///Obtiene el nip del ahijado actual o seleccionado
        NSString *nipSesionAhijado = [[NSUserDefaults standardUserDefaults] objectForKey:@"LNipAhijado"];
        NSLog(@"LUIViewControllerGaleria - variable de sesion - nip de ahijado %@", nipSesionAhijado);
        NSString *newNipSesionAhijado = [NSString stringWithFormat:@"%@", nipSesionAhijado];
        
        //Tras traer los ahijados el web service se pasa a la url el nip y token para traer la galería
        LServiceObjectGaleria *service = [[LServiceObjectGaleria alloc] initWithGaleria:nip tokenPadrino:padrino.token];
        [service startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error)
         {
             //NSLog(@"ServicesObject en Delegate GALERIA %@", response);
             if(response && ![response isEqual:[NSNull null]])
             {
                 //[SwiftSpinner hide:nil];
                 self.view.backgroundColor = [UIColor clearColor];
                 self.view.alpha = 1.0;
                 [loader stopAnimating];
                 
                 //Si hay respuesta no vacía entonces recorre cada Galería y si el nip del ahijado es igual al nip del ahijado de la sesión
                 NSLog(@"GaleriaAhijado ------- %@", response[LGaleriaAhijado]);
                 if(response[LGaleriaAhijado]){
                     NSLog(@"Cantidad en galeria ahhijado %d", [response[LGaleriaAhijado] count]);
                     
                     for(int cont=0; cont<[response[LGaleriaAhijado] count]; cont++)
                     {
                         NSString *nipRespuestaAhijado = (NSString *)[[response[LGaleriaAhijado] objectAtIndex:cont] objectForKey:LGaleriaNipAhijado];
                         NSString *newnipRespuestaAhijado = [NSString stringWithFormat:@"%@", nipRespuestaAhijado];
                         
                         NSLog(@"Nip de la respuesta:%@ Nip actual o seleccionado:%@",nipRespuestaAhijado,nipSesionAhijado);
                         if ([newnipRespuestaAhijado isEqualToString:newNipSesionAhijado]) //nipSesionAhijado
                         //if ([[[response[LGaleriaAhijado] objectAtIndex:cont] objectForKey:LGaleriaNipAhijado] isEqual:[[NSUserDefaults standardUserDefaults] objectForKey:@"LNipAhijado"]]) //nipSesionAhijado
                         {
                             NSLog(@"Se debe mostrar la foto:: %@ con nip de ahijado:: %@", [[response[LGaleriaAhijado] objectAtIndex:cont] objectForKey:LGaleriaFotosAhijado], [[response[LGaleriaAhijado] objectAtIndex:cont] objectForKey:LGaleriaNipAhijado]);
                             [_arrayImage addObject:[[response[LGaleriaAhijado] objectAtIndex:cont] objectForKey:LGaleriaFotosAhijado]];
                         }
                         else{
                             NSLog(@"El nip ahijado:: %@ no coincide contra el nipSesionAhijado:: %@", [[response[LGaleriaAhijado] objectAtIndex:cont] objectForKey:LGaleriaNipAhijado], [[NSUserDefaults standardUserDefaults] objectForKey:@"LNipAhijado"]);
                         }
                     }
                  }
                     //se recargan los datos para que muestre las imagenes despues de la validación de la petición
                     [self.collectionGaleria reloadData];
               }else
                 {
                     //[SwiftSpinner hide:nil];
                     self.view.backgroundColor = [UIColor clearColor];
                     self.view.alpha = 1.0;
                     [loader stopAnimating];
                     //se muestra un alert
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"Ocurrio un error con la conexión, favor de intentar de nuevo" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                     [alert show];
                 }
                 //se recargan los datos para que muestre las imagenes despues de la peticion
                 [self.collectionGaleria reloadData];
                 //             [SwiftSpinner hide:nil];
             
         }];
    }
    return _arrayImage;
}


-(void)viewDidLoad{
    
    [super viewDidLoad];
    [self.parentViewController.navigationItem setTitle:@"Galería"];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    //se le pone el nombre al navigation al momento que aparece
    [self.parentViewController.navigationItem setTitle:@"Galería"];
    [self.collectionGaleria reloadData];
}

/**
 Metodo que devuelve cuantas celdas habra en el collection
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSInteger galeria = [self arrayImage].count;
    
    return galeria;
    
}

/**
 Metodo que inserta la imagen de los ahijados en el collection
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"LUICustomCell";
    
    LUICustomCellAhijados *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    ///Se obtiene la imagen de la direccion url de la noticia mediante las clases que utilizan blocks
    NSURL *url = [NSURL URLWithString:[[self arrayImage] objectAtIndex:indexPath.row]];
    [cell.imagenAhijados sd_setImageWithURL:url placeholderImage:[UIImage alloc]];
    
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
    NSLog(@"Se selecciono %lu", (long)indexPath.row);
    self.urlImagen = [self.arrayImage objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"detalleGaleria" sender:self];
}

/**
 Metodo para enviar datos a la siguiente pantalla que hara los calculos.
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    LUIViewControllerDetalleGaleria *detalle = [segue destinationViewController];
    detalle.urlImagen = self.urlImagen;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.arrayImage count] > 2){
        //se busca un tamaño dividiendo el alto del collection se le restan los 20 de los espacios en las filas y celdas
        CGFloat heightCell = collectionView.frame.size.height / 3.5;
        //se retornan los tamaños
        return CGSizeMake(heightCell, heightCell);
    }else{
        //se busca un tamaño dividiendo el alto del collection, este no se le restan los espcios, ya que asi se ven bien con dos
        CGFloat heightCell = collectionView.frame.size.height / 2.5;
        //se retornan los tamaños
        return CGSizeMake(heightCell, heightCell);
    }
    
}

@end