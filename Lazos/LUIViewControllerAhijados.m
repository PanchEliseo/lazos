//
//  LUIViewControllerAhijados.m
//  Lazos
//
//  Created by Programacion on 9/23/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerAhijados.h"
#import "SWRevealViewController.h"
#import "LUIViewControllerTabBar.h"
#import "LUIViewControllerColeccionAhijados.h"
#import "LServicesObjectAhijado.h"
#import "LMPadrino.h"
#import "LConstants.h"
#import "LMAhijado.h"
#import "LUtil.h"
//#import "Lazos-Swift.h"
#import "LReachability.h"
#import "DDIndicator.h"
#import "LManagerObject.h"
#import "LUIViewControllerGaleria.h"

@implementation LUIViewControllerAhijados

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
    
    LUtil *functions = [LUtil instance];
    LMPadrino *padrino = [functions oftenPadrino];
    
    NSString * nip = [NSString stringWithFormat:@"%@", padrino.nip_godfather];
    
    //[SwiftSpinner show:@"Descargando ahijados..." animated:YES];
    DDIndicator *loader = [[DDIndicator alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 20, self.view.frame.size.height / 2 -20, 40, 40)];
    self.view.backgroundColor = [UIColor blackColor];
    self.view.alpha = 0.5;
    [self.view addSubview:loader];
    [loader startAnimating];
    
    //se verifica si hay conexion a internet
    LReachability *reachable = [LReachability reachabilityForInternetConnection];
    if(reachable.isReachable){
        //se hace la peticion al web service del ahijado de Lazos
        NSLog(@"que pasará en serviceLogin de LUIViewControllerAhijados::: nip: %@ token del padrino: %@", nip, padrino.token);
        LServicesObjectAhijado *serviceAhijados = [[LServicesObjectAhijado alloc] initWithUser:nip token:padrino.token];
                [serviceAhijados startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error){
            //NSLog(@"Descarga completa ahijado info----------> %@", response);
                    
            if(response && ![response isEqual:[NSNull null]]){
                if([response[LAhijadoJson] count] > 0){
                    
                    LManagerObject *object = [LManagerObject sharedStore];
                    if([response[LAhijadoJson] count] > 1){
                        
                        //se obtiene cuantos ahijados manda el web service y se pinta la vista de mas de un ahijado
                        self.controllerColeccion = [self.storyboard instantiateViewControllerWithIdentifier:@"masDeUnAhijado"];
                        
                        NSLog(@"********************** %@", response);
                        self.controllerColeccion.ahijado = response;
                        [self addChildViewController:self.controllerColeccion];
                        [self.view addSubview:self.controllerColeccion.view];
                        [self.controllerColeccion didMoveToParentViewController:self];
                    }else{
                        LServicesObjectAhijado *serviceAhijados1 = [[LServicesObjectAhijado alloc] initWithAhijado:nip token:padrino.token nipAhijado:[[response[LAhijadoJson] objectAtIndex:0] objectForKey:LNipAhijado] tipo:@"ahijados" response:response];
                        [serviceAhijados1 startDownloadWithCompletionBlock:^(NSDictionary *responseAhijados, NSError *error) {
                            NSLog(@"el resultado de mi segunda peticion %@", responseAhijados[@"Calificaciones"]);
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
                                //se guarda el ahijado del servicio web
                                [functions saveData:response methodDave:object contador:0 response:responseAhijados];
                            } else {
                                //se guarda el ahijado del servicio web
                                [functions saveData:response methodDave:object contador:0 response:responseAhijados];
                            }
                            //se obtiene el nip para enviarlo a la peticion del detalle de ahijado
                            NSString *nip = [[response[LAhijadoJson] objectAtIndex:0] objectForKey:LNipAhijado];
                            //Variable de preferencias
                            [[NSUserDefaults standardUserDefaults] setObject:nip forKey:@"LNipAhijado"];
                            //Instanciamos el método al que se le envía el nip del ahijado en la Galería
                            //  LUIViewControllerGaleria *enviaNip = [[LUIViewControllerGaleria alloc] ];
                            //si es un solo ahijado ir al tab bar
                            [self performSegueWithIdentifier:@"menuAhijados" sender:self];
                        }];
                    }
                    
                    //[SwiftSpinner hide:nil];
                    //se regresa la vista como estaba originalmente y se detiene la animacion
                    self.view.backgroundColor = [UIColor clearColor];
                    self.view.alpha = 1.0;
                    [loader stopAnimating];
                }else{
                    //[SwiftSpinner hide:nil];
                    //se regresa la vista como estaba originalmente y se detiene la animacion
                    self.view.backgroundColor = [UIColor clearColor];
                    self.view.alpha = 1.0;
                    [loader stopAnimating];
                    //se muestra un alert
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"No tienes ahijados en el sistema" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            }else{
                //[SwiftSpinner hide:nil];
                //se regresa la vista como estaba originalmente y se detiene la animacion
                self.view.backgroundColor = [UIColor clearColor];
                self.view.alpha = 1.0;
                [loader stopAnimating];
                //se muestra un alert
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"Ocurrio un error al tratar de conectarse, por favor, intente de nuevo" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
        }];
    }else{
        //[SwiftSpinner hide:nil];
        //se regresa la vista como estaba originalmente y se detiene la animacion
        self.view.backgroundColor = [UIColor clearColor];
        self.view.alpha = 1.0;
        [loader stopAnimating];
        //se muestra un alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Verifica tu conexión a internet" message:@"" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
        [alert show];
    }
    
    SWRevealViewController *revealViewController = self.revealViewController;
    //se pregunta si se instancio la clase del menu para hacer que vuelva al menu si se presiona el boton de menu
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
        
}

@end