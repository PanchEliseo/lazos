//
//  LUIViewControllerAjustes.m
//  Lazos
//
//  Created by Programacion on 10/16/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerAjustes.h"
#import "SWRevealViewController.h"
#import "LUtil.h"
#import "LMPadrino.h"
#import "LConstants.h"
#import "ViewController.h"
#import "LServiceObjectNotificaciones.h"

@implementation LUIViewControllerAjustes

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    //se cambia de color del navigation bar
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:16/255.0 green:28/255.0 blue:133/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    //se cambia el color del texto del navigation bar
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //se setea un titulo al navigation bar
    [self.navigationItem setTitle:@"Ajustes"];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    //se le quita el texto de la flecha de back
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    
    /*
    //se obtiene la variable de sesión para saber si se activó la notificación o debe aparecer desactivado
    self.sesionN1 = [[NSUserDefaults standardUserDefaults] objectForKey:LSessionN1];
    //si no se ha activado la notificación
    if(!self.sesionN1.boolValue){
        //setear el switch a desactivado
    } else {
        //el switch está activado
    }
    */

    
    //se agrega las acciones para que se le agrege la imagen del menu principal
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    //se le da un tamaño a la vista dependiendo el dispositivo
    self.widthView.constant = self.view.frame.size.width / 1.5;
    //Agrega un borde redondeado al boton de logout
    self.cerrarSesion.layer.cornerRadius = 5;
    [self addDataView];
}

/*!
 *  @brief  Metodo que se encarga de saber el estado de los uiswitch
 *
 *  @param sender identificador del uiswitch
 */
-(IBAction)toggleAction:(UISwitch*)sender{
    LUtil *util = [LUtil instance];
    LMPadrino *padrino = [util oftenPadrino];
    NSLog(@"******** %@", padrino.date_entered);
    
    NSString * nip = [NSString stringWithFormat:@"%@", padrino.nip_godfather];
    NSString * token = [NSString stringWithFormat:@"%@", padrino.token];
    
    switch (sender.tag) {
        case 1:
            if(self.estatusCartasRegalos.isOn){
                NSLog(@"esta on - estatus");
                
                ///Se instancia la clase para pasar los parámetros al método que realiza la petición a apilazos y notificarle si las notificaciones están activadas o desactivadas
                LServiceObjectNotificaciones *serviceNotificacion = [[LServiceObjectNotificaciones alloc] initWithDataNotificacion:nip token:token tipo:@"1" habilitar:@"true"];
                
                [serviceNotificacion startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error){
                    {
                        if(response && ![response isEqual:[NSNull null]]){
                            NSLog(@"LUIViewControllerAjustes - Tipo:1 - Respuesta de apilazos puede ser actualiza o guardado:::: %@", response);
                        }
                        else{
                            NSLog(@"No hay respuesta de apilazos %@", response);
                        }
                        
                    }
                }];
            }else{
                NSLog(@"esta off - estatus");
                
                ///Se instancia la clase para pasar los parámetros al método que realiza la petición a apilazos y notificarle si las notificaciones están activadas o desactivadas
                LServiceObjectNotificaciones *serviceNotificacion = [[LServiceObjectNotificaciones alloc] initWithDataNotificacion:nip token:token tipo:@"1" habilitar:@"false"];
                
                [serviceNotificacion startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error){
                    {
                        if(response && ![response isEqual:[NSNull null]]){
                            NSLog(@"LUIViewControllerAjustes - Tipo:1 -  Respuesta de apilazos puede ser actualiza o guardado:::: %@", response);
                        }
                        else{
                            NSLog(@"No hay respuesta de apilazos %@", response);
                        }
                        
                    }
                }];
            }
            break;
        case 2:
            if(self.actualizacion.isOn){
                NSLog(@"esta on - actualizacion");
                
                ///Se instancia la clase para pasar los parámetros al método que realiza la petición a apilazos y notificarle si las notificaciones están activadas o desactivadas
                LServiceObjectNotificaciones *serviceNotificacion = [[LServiceObjectNotificaciones alloc] initWithDataNotificacion:nip token:token tipo:@"2" habilitar:@"true"];
                
                [serviceNotificacion startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error){
                    {
                        if(response && ![response isEqual:[NSNull null]]){
                            NSLog(@"LUIViewControllerAjustes - Tipo:2 - Respuesta de apilazos puede ser actualiza o guardado:::: %@", response);
                        }
                        else{
                            NSLog(@"No hay respuesta de apilazos %@", response);
                        }
                    }
                }];
                
            }else{
                NSLog(@"esta off - actualizacion");
                
                ///Se instancia la clase para pasar los parámetros al método que realiza la petición a apilazos y notificarle si las notificaciones están activadas o desactivadas
                LServiceObjectNotificaciones *serviceNotificacion = [[LServiceObjectNotificaciones alloc] initWithDataNotificacion:nip token:token tipo:@"2" habilitar:@"false"];
                
                [serviceNotificacion startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error){
                    {
                        if(response && ![response isEqual:[NSNull null]]){
                            NSLog(@"LUIViewControllerAjustes - Tipo:2 - Respuesta de apilazos puede ser actualiza o guardado:::: %@", response);
                        }
                        else{
                            NSLog(@"No hay respuesta de apilazos %@", response);
                        }
                        
                    }
                }];
            }
            break;
        case 3:
            if(self.pagos.isOn){
                NSLog(@"esta on - pagos");
                
                ///Se instancia la clase para pasar los parámetros al método que realiza la petición a apilazos y notificarle si las notificaciones están activadas o desactivadas
                LServiceObjectNotificaciones *serviceNotificacion = [[LServiceObjectNotificaciones alloc] initWithDataNotificacion:nip token:token tipo:@"3" habilitar:@"true"];
                
                [serviceNotificacion startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error){
                    {
                        if(response && ![response isEqual:[NSNull null]]){
                            NSLog(@"LUIViewControllerAjustes - Tipo:3 - Respuesta de apilazos puede ser actualiza o guardado:::: %@", response);
                        }
                        else{
                            NSLog(@"No hay respuesta de apilazos %@", response);
                        }
                    }
                }];
            }else{
                NSLog(@"esta off - pagos");
                
                ///Se instancia la clase para pasar los parámetros al método que realiza la petición a apilazos y notificarle si las notificaciones están activadas o desactivadas
                LServiceObjectNotificaciones *serviceNotificacion = [[LServiceObjectNotificaciones alloc] initWithDataNotificacion:nip token:token tipo:@"3" habilitar:@"false"];
                
                [serviceNotificacion startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error){
                    {
                        if(response && ![response isEqual:[NSNull null]]){
                            NSLog(@"LUIViewControllerAjustes -  Tipo:3 -Respuesta de apilazos puede ser actualiza o guardado:::: %@", response);
                        }
                        else{
                            NSLog(@"No hay respuesta de apilazos %@", response);
                        }
                    }
                }];
            }
            break;
        default:
            break;
    }
}

-(void)addDataView{
    
    LUtil *util = [LUtil instance];
    LMPadrino *padrino = [util oftenPadrino];
    NSLog(@"******** %@", padrino.date_entered);
    if([padrino.gender isEqualToString:@"female"]){
        self.tipoPadrino.text = [@"madrina" uppercaseString];
    }else{
        self.tipoPadrino.text = [@"padrino" uppercaseString];
    }
    self.nombre.text = [padrino.name uppercaseString];
    self.apellidos.text = [padrino.apellidos uppercaseString];
    NSString *nip = [NSString stringWithFormat:@"%@%@", @"NIP ", padrino.nip_godfather];
    self.nip.text = nip;
    
}

- (IBAction)logout:(id)sender{
    NSLog(@"hacer todo el logout");
    //se cambia a no la variable de las preferencias para que coloque el login
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:NO]
                     forKey:LSession];
    [userDefaults setObject:[NSNumber numberWithBool:NO]
                     forKey:LMenuNoticiasMensaje];
    
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Principal"];
    [self.parentViewController.parentViewController.parentViewController addChildViewController:controller];
    [self.parentViewController.parentViewController.parentViewController.view addSubview:controller.view];
}

@end