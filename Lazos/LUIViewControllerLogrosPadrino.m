//
//  LUIViewControllerLogrosPadrino.m
//  Lazos
//
//  Created by Programacion on 10/12/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerLogrosPadrino.h"
#import "SWRevealViewController.h"
#import "LMPadrino.h"
#import "LManagerObject.h"
#import "LUtil.h"
#import "DateUtils.h"
#import "UIControllerMain.h"
#import "LServiceObjectLogros.h"
#import "LConstants.h"

@interface LUIViewControllerLogrosPadrino ()
@property(strong, nonatomic) LMPadrino *padrino;
@property (strong, nonatomic) NSMutableArray *array;
@end

@implementation LUIViewControllerLogrosPadrino

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    //se cambia de color del navigation bar
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:16/255.0 green:28/255.0 blue:133/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    //se cambia el color del texto del navigation bar
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //se setea un titulo al navigation bar
    [self.navigationItem setTitle:@"Mis logros como Padrino"];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    //se le quita el texto de la flecha de back
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    
    //se agrega las acciones para que se le agrege la imagen del menu principal
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self addData];
    [self activaLogros];
}


-(void)addData {
    
    ///Obtiene el padrino de la base de datos
    LUtil *functions = [LUtil instance];
    LMPadrino *padrino = [functions oftenPadrino];
    
    NSLog(@"Nombre del padrino de la Base de datos en LUIViewControllerLogrosPadrino- nombre %@", padrino.name);
    NSLog(@"el padrino de la Base de datos en LUIViewControllerLogrosPadrino- %@", padrino);
    
    ///Se agrega el nombre y apellidos del padrino
    //uppercaseString
    NSString *padrinoName = [padrino.name uppercaseString];
    NSString *padrinoApellidos = [padrino.apellidos uppercaseString];
    
    self.padrinoNombreCompleto.text = [NSString stringWithFormat:@"%@%@%@", padrinoName, @" ", padrinoApellidos];
    ///Da formato de negritas al nombre de pila del ahijado
    NSRange range1 = [self.padrinoNombreCompleto.text rangeOfString:padrinoName];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self.padrinoNombreCompleto.text];
    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]}
                            range:range1];
    self.padrinoNombreCompleto.attributedText = attributedText;
    
    ///Imprime Madrina o Padrino
    if([padrino.gender isEqualToString:@"female"]){
        self.padrinoGenero.text = @"Madrina";
    }else{
        self.padrinoGenero.text = @"Padrino";
    }
    
    ///Obtiene la fecha de ingreso del Padrino
    NSLog(@"Imprime padrino.date_entered de la base: %@", padrino.date_entered);
    ///Convierte la fecha de ingreso de string a date con el formato indicado para enviarsélo a CalculateDateLevel
    NSDate *fechaIngreso = [DateUtils getDateFromString:padrino.date_entered WithFormat: @"YYYY-MM-dd HH:mm:ss"];
    NSLog(@"Imprime fechaIngreso, conversión de la fecha de la base con formato a date: %@", padrino.date_entered);
    
    ///Convierte la fecha del string a date enviandole el formato a imprimir en fecha desde que colabora
    NSString *fechaIngresoPadrino = [DateUtils getFullStringFromDate:fechaIngreso WithFormat:@"dd/MMMM/YYYY"];
    
    ///Imprime nivel del padrino
    if(padrino.date_entered){
        ///Se instancia la clase que contiene el metodo que realiza el calculo entre las fechas, para saber que nivel es el padrino
        LUtil *util = [LUtil instance];
        NSString *tipoNivel = [util calculateDateLevel:fechaIngreso];
        self.padrinoNivel.text = tipoNivel;
    } else{
        self.padrinoNivel.text = @"";
    }
    
    //Imprime la fecha de ingreso del padrino en fecha desde que colabora, en el siguiente formato: 10/Mayo/2015
    if(padrino.date_entered){
        self.padrinoFechaIngreso.text = fechaIngresoPadrino;
    } else{
        self.padrinoFechaIngreso.text = @"";
        NSLog(@"Imprime label %@",self.padrinoFechaIngreso.text);
    }
}

-(void)activaLogros {
    
    ///Obtiene el padrino de la base de datos
    LUtil *functions = [LUtil instance];
    LMPadrino *padrino = [functions oftenPadrino];
    
    //NSString * nip = @"12345";
    NSString * nip = [NSString stringWithFormat:@"%@", padrino.nip_godfather];
    //    NSString * nip = [NSString stringWithFormat:@"%@", padrino.nip_godfather];
    NSLog(@"Imprime nip  en Logros para la petición %@", nip);
    
    //NSString * token = @"sd65fg49wer3f2d1s98er1hg4";
    NSString * token = padrino.token;
    
    //se hace la peticion al servicio correspondiente
    LServiceObjectLogros *serviceLogrosP = [[LServiceObjectLogros alloc] initWithLogros:nip tokenPadrino:token];
    //LServiceObjectLogros *serviceLogrosP = [[LServiceObjectLogros alloc] initWithLogros:nip tokenPadrino:padrino.token];
    [serviceLogrosP startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error) {
        
        ///Respuesta de la petición
        NSLog(@"la respuesta de logros ----> %@", response);
        
        if([response[LLogro] count] >= 1){
            [self addLogros:response];
        }
        
    }];
}

-(void)addLogros:(NSDictionary *)response{
    ///Evalua si el padrino tiene el logro para cambiar la imagen a color y el texto a negro
    NSString *logroAhijados1 = [response[LLogro] objectForKey:LAhijados_1];
    if (logroAhijados1){
        logroAhijados1 = logroAhijados1.uppercaseString;
        if ([logroAhijados1 isEqualToString: @"SI"]){
            UIImage *logroAhijados1ON = [UIImage imageNamed: @"ic_image_logros_apadrinado_on"];
            self.imageViewAhijados1.image = logroAhijados1ON;
            self.labelAhijados1.textColor = [UIColor blackColor];
        }
    }
    
    ///Evalua si el padrino tiene el logro para cambiar la imagen a color y el texto a negro
    NSString *logroAhijados2 = [response[LLogro] objectForKey:LAhijados_2];
    if (logroAhijados2){
        logroAhijados2 = logroAhijados2.uppercaseString;
        if ([logroAhijados2 isEqualToString: @"SI"]){
            UIImage *logroAhijados2ON = [UIImage imageNamed: @"ic_image_logros_2_apadrinados_on"];
            self.imageViewAhijados2.image = logroAhijados2ON;
            self.labelAhijados2.textColor = [UIColor blackColor];
        }
    }
    
    ///Evalua si el padrino tiene el logro para cambiar la imagen a color y el texto a negro
    NSString *logroAhijados3 = [response[LLogro] objectForKey:LAhijados_3];
    if (logroAhijados3){
        logroAhijados3 = logroAhijados3.uppercaseString;
        if ([logroAhijados3 isEqualToString: @"SI"]){
            UIImage *logroAhijados3ON = [UIImage imageNamed: @"ic_image_logros_3_apadrinados_on"];
            self.imageViewAhijados3.image = logroAhijados3ON;
            self.labelAhijados3.textColor = [UIColor blackColor];
        }
    }
    
    ///Evalua si el padrino tiene el logro para cambiar la imagen a color y el texto a negro
    NSString *logroAhijadosMas3 = [response[LLogro] objectForKey:LAhijados_mas_3];
    if (logroAhijadosMas3){
        logroAhijadosMas3 = logroAhijadosMas3.uppercaseString;
        if ([logroAhijadosMas3 isEqualToString: @"SI"]){
            UIImage *logroAhijadosMas3ON = [UIImage imageNamed: @"ic_image_logros_3_apadrinados_on"];
            self.imageViewAhijadosMas3.image = logroAhijadosMas3ON;
            self.labelAhijadosMas3.textColor = [UIColor blackColor];
        }
    }
    
    ///Evalua si el padrino tiene el logro para cambiar la imagen a color y el texto a negro
    NSString *logroRegalos1 = [response[LLogro] objectForKey:LRegalos_1];
    if (logroRegalos1){
        logroRegalos1 = logroRegalos1.uppercaseString;
        if ([logroRegalos1 isEqualToString: @"SI"]){
            UIImage *logroRegalos1ON = [UIImage imageNamed: @"ic_image_logros_regalo_on"];
            self.imageViewRegalos1.image = logroRegalos1ON;
            self.labelRegalos1.textColor = [UIColor blackColor];
        }
    }
    
    ///Evalua si el padrino tiene el logro para cambiar la imagen a color y el texto a negro
    NSString *logroRegalos2 = [response[LLogro] objectForKey:LRegalos_2];
    if (logroRegalos2){
        logroRegalos2 = logroRegalos2.uppercaseString;
        if ([logroRegalos2 isEqualToString: @"SI"]){
            UIImage *logroRegalos2ON = [UIImage imageNamed: @"ic_image_logros_regalo_on"];
            self.imageViewRegalos2.image = logroRegalos2ON;
            self.labelRegalos2.textColor = [UIColor blackColor];
        }
    }
    
    ///Evalua si el padrino tiene el logro para cambiar la imagen a color y el texto a negro
    NSString *logroRegalos3 = [response[LLogro] objectForKey:LRegalos_3];
    if (logroRegalos3){
        logroRegalos3 = logroRegalos3.uppercaseString;
        if ([logroRegalos3 isEqualToString: @"SI"]){
            UIImage *logroRegalos3ON = [UIImage imageNamed: @"ic_image_logros_regalo_on"];
            self.imageViewRegalos3.image = logroRegalos3ON;
            self.labelRegalos3.textColor = [UIColor blackColor];
        }
    }
    
    ///Evalua si el padrino tiene el logro para cambiar la imagen a color y el texto a negro
    NSString *logroRegalosMas3 = [response[LLogro] objectForKey:LRegalos_mas_3];
    if (logroRegalosMas3){
        logroRegalosMas3 = logroRegalosMas3.uppercaseString;
        if ([logroRegalosMas3 isEqualToString: @"SI"]){
            UIImage *logroRegalosMas3ON = [UIImage imageNamed: @"ic_image_logros_regalo_on"];
            self.imageViewRegalosMas3.image = logroRegalosMas3ON;
            self.labelRegalosMas3.textColor = [UIColor blackColor];
        }
    }
    
    ///Evalua si el padrino tiene el logro para cambiar la imagen a color y el texto a negro
    NSString *logroCartas2 = [response[LLogro] objectForKey:LCartas_2];
    if (logroCartas2){
        logroCartas2 = logroCartas2.uppercaseString;
        if ([logroCartas2 isEqualToString: @"SI"]){
            UIImage *logroCartas2ON = [UIImage imageNamed: @"ic_image_logros_cartas_on"];
            self.imageViewCartas2.image = logroCartas2ON;
            self.labelCartas2.textColor = [UIColor blackColor];
        }
    }
    
    ///Evalua si el padrino tiene el logro para cambiar la imagen a color y el texto a negro
    NSString *logroCartas4 = [response[LLogro] objectForKey:LCartas_4];
    if (logroCartas4){
        logroCartas4 = logroCartas4.uppercaseString;
        if ([logroCartas4 isEqualToString: @"SI"]){
            UIImage *logroCartas4ON = [UIImage imageNamed: @"ic_image_logros_cartas_on"];
            self.imageViewCartas4.image = logroCartas4ON;
            self.labelCartas4.textColor = [UIColor blackColor];
        }
    }
    
    ///Evalua si el padrino tiene el logro para cambiar la imagen a color y el texto a negro
    NSString *logroCartas6 = [response[LLogro] objectForKey:LCartas_6];
    if (logroCartas6){
        logroCartas6 = logroCartas6.uppercaseString;
        if ([logroCartas6 isEqualToString: @"SI"]){
            UIImage *logroCartas6ON = [UIImage imageNamed: @"ic_image_logros_cartas_on"];
            self.imageViewCartas6.image = logroCartas6ON;
            self.labelCartas6.textColor = [UIColor blackColor];
        }
    }
    
    ///Evalua si el padrino tiene el logro para cambiar la imagen a color y el texto a negro
    NSString *logroCartasMas8 = [response[LLogro] objectForKey:LCartas_mas_8];
    if (logroCartasMas8){
        logroCartasMas8 = logroCartasMas8.uppercaseString;
        if ([logroCartasMas8 isEqualToString: @"SI"]){
            UIImage *logroCartasMas8ON = [UIImage imageNamed: @"ic_image_logros_cartas_on"];
            self.imageViewCartasMas8.image = logroCartasMas8ON;
            self.labelCartasMas8.textColor = [UIColor blackColor];
        }
    }
    
    ///Evalua si el padrino tiene el logro para cambiar la imagen a color y el texto a negro
    NSString *logroCompartir1 = [response[LLogro] objectForKey:LCompartir_1];
    if (logroCompartir1){
        logroCompartir1 = logroCompartir1.uppercaseString;
        if ([logroCompartir1 isEqualToString: @"SI"]){
            UIImage *logroCompartir1ON = [UIImage imageNamed: @"ic_image_logros_compartio_on"];
            self.imageViewCompartir1.image = logroCompartir1ON;
            self.labelCompartir1.textColor = [UIColor blackColor];
        }
    }
    
    ///Evalua si el padrino tiene el logro para cambiar la imagen a color y el texto a negro
    NSString *logroCompartirMas1 = [response[LLogro] objectForKey:LCompartir_mas_1];
    if (logroCompartirMas1){
        logroCompartirMas1 = logroCompartirMas1.uppercaseString;
        if ([logroCompartirMas1 isEqualToString: @"SI"]){
            UIImage *logroCompartirMas1ON = [UIImage imageNamed: @"ic_image_logros_compartio_on"];
            self.imageViewCompartirMas1.image = logroCompartirMas1ON;
            self.labelCompartirMas1.textColor = [UIColor blackColor];
        }
    }
    
    ///Evalua si el padrino tiene el logro para cambiar la imagen a color y el texto a negro
    NSString *logroVisita = [response[LLogro] objectForKey:LVisita];
    if (logroVisita){
        logroVisita = logroVisita.uppercaseString;
        if ([logroVisita isEqualToString: @"SI"]){
            UIImage *logroVisitaON = [UIImage imageNamed: @"ic_image_logros_visita_on"];
            self.imageViewVisita.image = logroVisitaON;
            self.labelVisita.textColor = [UIColor blackColor];
        }
    }
    
    ///Evalua si el padrino tiene el logro para cambiar la imagen a color y el texto a negro
    NSString *logroAportacionAdicional = [response[LLogro] objectForKey:LAportacion_Adicional];
    if (logroAportacionAdicional){
        logroAportacionAdicional = logroAportacionAdicional.uppercaseString;
        if ([logroAportacionAdicional isEqualToString: @"SI"]){
            UIImage *logroAportacionAdicionalON = [UIImage imageNamed: @"ic_image_logros_aportacion_adicional_on"];
            self.imageViewAportacionAdicional.image = logroAportacionAdicionalON;
            self.labelAportacionAdicional.textColor = [UIColor blackColor];
        }
    }
}

@end