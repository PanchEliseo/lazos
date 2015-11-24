//
//  LUIViewControllerBuzonAhijados.m
//  Lazos
//
//  Created by Programacion on 9/28/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerBuzonAhijados.h"
#import "LServiceObjectBuzon.h"
#import "LUIViewControllerBuzonVacio.h"
#import "BuzonEnviadosViewController.h"
#import "LConstants.h"
#import "LMPadrino.h"
#import "LMAhijado.h"
#import "LUtil.h"
#import "ImageUtils.h"
//#import "Lazos-Swift.h"
#import "DDIndicator.h"
#import "BuzonRecibidosViewController.h"
#import "LServicesObjectAhijado.h"

@interface LUIViewControllerBuzonAhijados()

@property (strong, nonatomic)UIViewController *viewControllerContainer;
@property (strong, nonatomic)UIViewController *viewController;
@property (strong, nonatomic)NSNumber *sesion;
@property (strong, nonatomic)LMPadrino *padrino;

@end

@implementation LUIViewControllerBuzonAhijados

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self initSegmentedControl];
    [self.parentViewController.navigationItem setTitle:@"Buzón"];
    
    /*UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"buzonViewController"];
    //se agrega a la vista del viewController principal
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];*/
    
    self.sesion = [[NSUserDefaults standardUserDefaults] objectForKey:@"LNipAhijado"];
    NSLog(@"variable de sesion - nip de ahijado %@", self.sesion);
    
    /*LUtil *functions = [LUtil instance];
    self.padrino = [functions oftenPadrino];*/
    [self.estadoSegmentedControl addTarget:self
                                    action:@selector(segmentControlAction:)
                          forControlEvents:UIControlEventValueChanged];
    
    //se agrega el reconocedor de resto swipe hacia la izquierda
    UISwipeGestureRecognizer * recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeleft:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.contenidoBuzonView addGestureRecognizer:recognizer];
    
    UISwipeGestureRecognizer * recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiperight:)];
    [recognizerRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.contenidoBuzonView addGestureRecognizer:recognizerRight];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    ///Setea el título del navigationItem
    [self.parentViewController.navigationItem setTitle:@"Buzón"];
    
    LUtil *functions = [LUtil instance];
    self.padrino = [functions oftenPadrino];
    //[SwiftSpinner show:@"Descargando cartas y regalos..." animated:YES];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    DDIndicator *loader = [[DDIndicator alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 20, self.view.frame.size.height / 2 -20, 40, 40)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    [self.parentViewController.view addSubview:view];
    [self.view addSubview:loader];
    [loader startAnimating];
    //se hace la peticion correspondiente dependiendo el boton seleccionado del segmentd conroller
    if(self.estadoSegmentedControl.selectedSegmentIndex == 0){
        NSString * nip = [NSString stringWithFormat:@"%@", self.padrino.nip_godfather];
        LServiceObjectBuzon *service = [[LServiceObjectBuzon alloc] initWithData:nip token:self.padrino.token tipo:@"enviados"];
        [service startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error)
        {
            NSLog(@"la respuesta del buzon ----> %@", response);
            if(response && ![response isEqual:[NSNull null]]){
                NSMutableArray *cuentaBuzon = [[NSMutableArray alloc] init];
                for(int cont=0; cont<[response[LBuzon] count]; cont++){
                    if([[[response[LBuzon] objectAtIndex:cont] objectForKey:LName] componentsSeparatedByString:@"APP"].count == 2 || [[[response[LBuzon] objectAtIndex:cont] objectForKey:LName] componentsSeparatedByString:@"WEB"].count == 2){
                        [cuentaBuzon addObject:response[LBuzon]];
                    }
                }
                if([cuentaBuzon count] > 0){
                    //se hace peticion de ahijado para obtener la foto
                    LServicesObjectAhijado *serviceAhijado = [[LServicesObjectAhijado alloc] initWithUser:nip token:self.padrino.token];
                    [serviceAhijado startDownloadWithCompletionBlock:^(NSDictionary *responseAhijadoInfo, NSError *error){
                        NSLog(@"Descarga completa ahijado info----------> %@", responseAhijadoInfo);
                        
                        for(int cont=0; cont<[responseAhijadoInfo[LAhijadoJson] count]; cont++){
                            LServicesObjectAhijado *serviceCalificaciones = [[LServicesObjectAhijado alloc] initWithAhijado:nip token:self.padrino.token nipAhijado:[[responseAhijadoInfo[LAhijadoJson] objectAtIndex:cont] objectForKey:LNipAhijado] tipo:@"buzonGeneral" response:responseAhijadoInfo];
                            [serviceCalificaciones startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error) {
                                NSLog(@"ya termino de descargar las calificaciones %@", response);
                            }];
                        }
                        //se instancia el viewController por medio del identificador que se le puso a el view Controller correspondiente
                        self.viewControllerContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"IdentificadorBuzonE"];
                        BuzonEnviadosViewController *buzon = (BuzonEnviadosViewController*)self.viewControllerContainer;
                        buzon.response = response;
                        buzon.responseAhijados = responseAhijadoInfo;
                        buzon.tipoMenu = @"ahijados";
                        [self addChildViewController:self.viewControllerContainer];
                        [self.contenidoBuzonView addSubview:self.viewControllerContainer.view];
                        //[SwiftSpinner hide:nil];
                        view.backgroundColor = [UIColor clearColor];
                        view.alpha = 1.0;
                        [view removeFromSuperview];
                        [loader stopAnimating];
                    }];
                }else{
                    //se envia el tipo de el controller para saber que leyenda colocar
                    self.viewControllerContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"LUIViewControllerBuzonVacio"];
                    LUIViewControllerBuzonVacio *vacio = (LUIViewControllerBuzonVacio*)self.viewControllerContainer;
                    vacio.texto = @"enviado";
                    [self addChildViewController:self.viewControllerContainer];
                    [self.contenidoBuzonView addSubview:self.viewControllerContainer.view];
                    //[SwiftSpinner hide:nil];
                    view.backgroundColor = [UIColor clearColor];
                    view.alpha = 1.0;
                    [view removeFromSuperview];
                    [loader stopAnimating];
                }
            }else{
                //[SwiftSpinner hide:nil];
                view.backgroundColor = [UIColor clearColor];
                view.alpha = 1.0;
                [view removeFromSuperview];
                [loader stopAnimating];
                //se muestra un alert
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"Ocurrio un error al tratar de conectarse, por favor, intente de nuevo" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
//            [SwiftSpinner hide:nil];
                 
        }];
    }else{
        ///Se remueve la vista para que al cambiar de opcion no cause problemas
        [self.viewControllerContainer removeFromParentViewController];
        [self.viewControllerContainer.view removeFromSuperview];
        NSLog(@"pulso el segundo valor");
        
        //NSString * nip = [NSString stringWithFormat:@"%@", self.padrino.nip_godfather];
        //colocar el nip y el token de los usuarios logeados
        LServiceObjectBuzon *service = [[LServiceObjectBuzon alloc] initRecibidos:@"56991" token:@"UWsHk2M7UZtclZIbjWkGlut7mYfJPrfKTVp=lJx9khyy"];
        //LServiceObjectBuzon *service = [[LServiceObjectBuzon alloc] initRecibidos:nip token:self.padrino.token];
        [service startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error)
         {
             //NSLog(@"la respuesta de los recibidos %@", response);
             if(response && ![response isEqual:[NSNull null]]){
                 if([response[LBuzonRecibidos] count] > 0){
                     
                     //falta hacer peticion de buzon recibidos
                     self.viewControllerContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"IdentificadorBuzonR"];
                     ///Se agrega a la vista contenedora el viewController correspondiente
                     [self addChildViewController:self.viewControllerContainer];
                     [self.contenidoBuzonView addSubview:self.viewControllerContainer.view];
                     BuzonRecibidosViewController *buzon = (BuzonRecibidosViewController*)self.viewControllerContainer;
                     buzon.response = response;
                     buzon.tipoMenu = @"ahijados";
                     view.backgroundColor = [UIColor clearColor];
                     view.alpha = 1.0;
                     [view removeFromSuperview];
                     [loader stopAnimating];
                 }else{
                     //se envia el tipo de el controller para saber que leyenda colocar
                     self.viewControllerContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"LUIViewControllerBuzonVacio"];
                     LUIViewControllerBuzonVacio *vacio = (LUIViewControllerBuzonVacio*)self.viewControllerContainer;
                     vacio.texto = @"recibido";
                     [self addChildViewController:self.viewControllerContainer];
                     [self.contenidoBuzonView addSubview:self.viewControllerContainer.view];
                     //[SwiftSpinner hide:nil];
                     view.backgroundColor = [UIColor clearColor];
                     view.alpha = 1.0;
                     [view removeFromSuperview];
                     [loader stopAnimating];
                 }
             }else{
                 //[SwiftSpinner hide:nil];
                 view.backgroundColor = [UIColor clearColor];
                 view.alpha = 1.0;
                 [view removeFromSuperview];
                 [loader stopAnimating];
                 //se muestra un alert
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"Ocurrio un error al tratar de conectarse, por favor, intente de nuevo" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
             }
         }];
    }
    
}

-(void)initSegmentedControl
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor], NSForegroundColorAttributeName,
                                [UIFont systemFontOfSize:13], NSFontAttributeName,
                                nil];
    [self.estadoSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                           [UIFont boldSystemFontOfSize:13], NSFontAttributeName,
                                           nil];
    [self.estadoSegmentedControl  setTitleTextAttributes:highlightedAttributes forState:UIControlStateSelected];
    
    [self.estadoSegmentedControl setDividerImage:[ImageUtils imageWithColor:[UIColor clearColor]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.estadoSegmentedControl setBackgroundImage:[ImageUtils imageWithColor:self.estadoSegmentedControl.tintColor] forState:(UIControlStateSelected) barMetrics:UIBarMetricsDefault];
    
    [self.estadoSegmentedControl setBackgroundImage:[ImageUtils imageWithColor:self.estadoSegmentedControl.backgroundColor] forState:(UIControlStateNormal) barMetrics:UIBarMetricsDefault];
}

/**
 Metodo que realiza el swipe y cambia de controlador ala izquierda
 */
-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer {
    if(self.estadoSegmentedControl.selectedSegmentIndex == 0){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        DDIndicator *loader = [[DDIndicator alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 20, self.view.frame.size.height / 2 -20, 40, 40)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        [self.parentViewController.view addSubview:view];
        [self.view addSubview:loader];
        [loader startAnimating];
        //se remueve la vista para que al cambiar de opcion no cause problemas
        [self.viewControllerContainer removeFromParentViewController];
        [self.viewControllerContainer.view removeFromSuperview];
        self.viewControllerContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"IdentificadorBuzonE"];
        self.estadoSegmentedControl.selectedSegmentIndex = 1;
        
        LServiceObjectBuzon *service = [[LServiceObjectBuzon alloc] initRecibidos:@"56991" token:@"UWsHk2M7UZtclZIbjWkGlut7mYfJPrfKTVp=lJx9khyy"];
        //LServiceObjectBuzon *service = [[LServiceObjectBuzon alloc] initRecibidos:nip token:self.padrino.token];
        [service startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error)
         {
             //NSLog(@"la respuesta de los recibidos %@", response);
             if(response && ![response isEqual:[NSNull null]]){
                 if([response[LBuzonRecibidos] count] > 0){
                     
                     //falta hacer peticion de buzon recibidos
                     self.viewControllerContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"IdentificadorBuzonR"];
                     ///Se agrega a la vista contenedora el viewController correspondiente
                     [self addChildViewController:self.viewControllerContainer];
                     [self.contenidoBuzonView addSubview:self.viewControllerContainer.view];
                     BuzonRecibidosViewController *buzon = (BuzonRecibidosViewController*)self.viewControllerContainer;
                     buzon.response = response;
                     buzon.tipoMenu = @"ahijados";
                     view.backgroundColor = [UIColor clearColor];
                     view.alpha = 1.0;
                     [view removeFromSuperview];
                     [loader stopAnimating];
                 }else{
                     //se envia el tipo de el controller para saber que leyenda colocar
                     self.viewControllerContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"LUIViewControllerBuzonVacio"];
                     LUIViewControllerBuzonVacio *vacio = (LUIViewControllerBuzonVacio*)self.viewControllerContainer;
                     vacio.texto = @"recibido";
                     [self addChildViewController:self.viewControllerContainer];
                     [self.contenidoBuzonView addSubview:self.viewControllerContainer.view];
                     //[SwiftSpinner hide:nil];
                     view.backgroundColor = [UIColor clearColor];
                     view.alpha = 1.0;
                     [view removeFromSuperview];
                     [loader stopAnimating];
                 }
             }else{
                 //[SwiftSpinner hide:nil];
                 view.backgroundColor = [UIColor clearColor];
                 view.alpha = 1.0;
                 [view removeFromSuperview];
                 [loader stopAnimating];
                 //se muestra un alert
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"Ocurrio un error al tratar de conectarse, por favor, intente de nuevo" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
             }
         }];
        
        //se agrega al a vista contenedora el viewController correspondiente
        /*[self addChildViewController:self.viewControllerContainer];
        [self.contenidoBuzonView addSubview:self.viewControllerContainer.view];
        [self.viewController addChildViewController:self];*/
        //se baja el alpha a la vista para que parezca que desaparece
        self.contenidoBuzonView.alpha = 0;
        //se crea una animacion para colocar el nuevo viewController
        [UIView animateWithDuration:0.4 animations:^(void)
         {
             //se le da el nuev alpha a la vista
             self.contenidoBuzonView.alpha = 1.0;
             //se coloca el nuevo viewController en la vista
             [self.navigationController pushViewController:self.viewController animated:YES];
         }];
    }
}

/**
 Metodo que realiza el swipe y cambia de controlador ala derecha
 */
-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer {
    if(self.estadoSegmentedControl.selectedSegmentIndex == 1){
        //[SwiftSpinner show:@"Descargando cartas y regalos..." animated:YES];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        DDIndicator *loader = [[DDIndicator alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 20, self.view.frame.size.height / 2 -20, 40, 40)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        [self.parentViewController.view addSubview:view];
        [self.view addSubview:loader];
        [loader startAnimating];
        NSString * nip = [NSString stringWithFormat:@"%@", self.padrino.nip_godfather];
        LServiceObjectBuzon *service = [[LServiceObjectBuzon alloc] initWithData:nip token:self.padrino.token tipo:@"enviados"];
        [service startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error)
         {
             ///Se remueve la vista para que al cambiar de opcion no cause problemas
             [self.viewControllerContainer removeFromParentViewController];
             [self.viewControllerContainer.view removeFromSuperview];
             //NSLog(@"la respuesta del buzon ----> %@", response);
             if(response && ![response isEqual:[NSNull null]]){
                 NSMutableArray *cuentaBuzon = [[NSMutableArray alloc] init];
                 for(int cont=0; cont<[response[LBuzon] count]; cont++){
                     if([[[response[LBuzon] objectAtIndex:cont] objectForKey:LName] componentsSeparatedByString:@"APP"].count == 2 || [[[response[LBuzon] objectAtIndex:cont] objectForKey:LName] componentsSeparatedByString:@"APP"].count == 2){
                         [cuentaBuzon addObject:response[LBuzon]];
                     }
                 }
                 if([cuentaBuzon count] > 0){
                     //se hace peticion de ahijado para obtener la foto
                     LServicesObjectAhijado *serviceAhijado = [[LServicesObjectAhijado alloc] initWithUser:nip token:self.padrino.token];
                     [serviceAhijado startDownloadWithCompletionBlock:^(NSDictionary *responseAhijadoInfo, NSError *error){
                         NSLog(@"Descarga completa ahijado info----------> %@", responseAhijadoInfo);
                         
                         for(int cont=0; cont<[responseAhijadoInfo[LAhijadoJson] count]; cont++){
                             LServicesObjectAhijado *serviceCalificaciones = [[LServicesObjectAhijado alloc] initWithAhijado:nip token:self.padrino.token nipAhijado:[[responseAhijadoInfo[LAhijadoJson] objectAtIndex:cont] objectForKey:LNipAhijado] tipo:@"buzonGeneral" response:responseAhijadoInfo];
                             [serviceCalificaciones startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error) {
                                 NSLog(@"ya termino de descargar las calificaciones %@", response);
                             }];
                         }
                         //se agrega la vista que aparecera al entrar en esta pantalla que es la de productos AHMSA
                         //se instancia el viewController por medio del identificador que se le puso a el view Controller correspondiente
                         self.viewControllerContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"IdentificadorBuzonE"];
                         BuzonEnviadosViewController *buzon = (BuzonEnviadosViewController*)self.viewControllerContainer;
                         buzon.response = response;
                         buzon.responseAhijados = responseAhijadoInfo;
                         buzon.tipoMenu = @"ahijados";
                         [self addChildViewController:self.viewControllerContainer];
                         [self.contenidoBuzonView addSubview:self.viewControllerContainer.view];
                         //[SwiftSpinner hide:nil];
                         view.backgroundColor = [UIColor clearColor];
                         view.alpha = 1.0;
                         [view removeFromSuperview];
                         [loader stopAnimating];
                     }];
                 }else{
                     //se envia el tipo de el controller para saber que leyenda colocar
                     self.viewControllerContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"LUIViewControllerBuzonVacio"];
                     LUIViewControllerBuzonVacio *vacio = (LUIViewControllerBuzonVacio*)self.viewControllerContainer;
                     vacio.texto = @"enviado";
                     [self addChildViewController:self.viewControllerContainer];
                     [self.contenidoBuzonView addSubview:self.viewControllerContainer.view];
                     //[SwiftSpinner hide:nil];
                     view.backgroundColor = [UIColor clearColor];
                     view.alpha = 1.0;
                     [view removeFromSuperview];
                     [loader stopAnimating];
                 }
             }else{
                 //[SwiftSpinner hide:nil];
                 view.backgroundColor = [UIColor clearColor];
                 view.alpha = 1.0;
                 [view removeFromSuperview];
                 [loader stopAnimating];
                 //se muestra un alert
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"Ocurrio un error al tratar de conectarse, por favor, intente de nuevo" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
             }
//             [SwiftSpinner hide:nil];
             
         }];
        self.contenidoBuzonView.alpha = 0;
        [UIView animateWithDuration:0.4 animations:^(void)
         {
             self.contenidoBuzonView.alpha = 1.0;
             [self.navigationController pushViewController:self.viewController animated:YES];
         }];
    }
}



///Metodo que controla la seleccion del segmentControl
- (void)segmentControlAction:(UISegmentedControl *)segment{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    DDIndicator *loader = [[DDIndicator alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 20, self.view.frame.size.height / 2 -20, 40, 40)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    [self.parentViewController.view addSubview:view];
    [self.view addSubview:loader];
    [loader startAnimating];
    ///Condicion para saber que vista inicializar
    if(segment.selectedSegmentIndex == 0){
        //[SwiftSpinner show:@"Descargando cartas y regalos..." animated:YES];
        NSString * nip = [NSString stringWithFormat:@"%@", self.padrino.nip_godfather];
        LServiceObjectBuzon *service = [[LServiceObjectBuzon alloc] initWithData:nip token:self.padrino.token tipo:@"enviados"];
        [service startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error)
         {
             ///Se remueve la vista para que al cambiar de opcion no cause problemas
             [self.viewControllerContainer removeFromParentViewController];
             [self.viewControllerContainer.view removeFromSuperview];
             //NSLog(@"la respuesta del buzon ----> %@", response);
             if(response && ![response isEqual:[NSNull null]]){
                 NSMutableArray *cuentaBuzon = [[NSMutableArray alloc] init];
                 for(int cont=0; cont<[response[LBuzon] count]; cont++){
                     if([[[response[LBuzon] objectAtIndex:cont] objectForKey:LName] componentsSeparatedByString:@"APP"].count == 2 || [[[response[LBuzon] objectAtIndex:cont] objectForKey:LName] componentsSeparatedByString:@"APP"].count == 2){
                         [cuentaBuzon addObject:response[LBuzon]];
                     }
                 }
                 if([cuentaBuzon count] > 0){
                     //se hace peticion de ahijado para obtener la foto
                     LServicesObjectAhijado *serviceAhijado = [[LServicesObjectAhijado alloc] initWithUser:nip token:self.padrino.token];
                     [serviceAhijado startDownloadWithCompletionBlock:^(NSDictionary *responseAhijadoInfo, NSError *error){
                         NSLog(@"Descarga completa ahijado info----------> %@", responseAhijadoInfo);
                         
                         for(int cont=0; cont<[responseAhijadoInfo[LAhijadoJson] count]; cont++){
                             LServicesObjectAhijado *serviceCalificaciones = [[LServicesObjectAhijado alloc] initWithAhijado:nip token:self.padrino.token nipAhijado:[[responseAhijadoInfo[LAhijadoJson] objectAtIndex:cont] objectForKey:LNipAhijado] tipo:@"buzonGeneral" response:responseAhijadoInfo];
                             [serviceCalificaciones startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error) {
                                 NSLog(@"ya termino de descargar las calificaciones %@", response);
                             }];
                         }
                         //se agrega la vista que aparecera al entrar en esta pantalla que es la de productos AHMSA
                         //se instancia el viewController por medio del identificador que se le puso a el view Controller correspondiente
                         self.viewControllerContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"IdentificadorBuzonE"];
                         BuzonEnviadosViewController *buzon = (BuzonEnviadosViewController*)self.viewControllerContainer;
                         buzon.response = response;
                         buzon.responseAhijados = responseAhijadoInfo;
                         buzon.tipoMenu = @"ahijados";
                         [self addChildViewController:self.viewControllerContainer];
                         [self.contenidoBuzonView addSubview:self.viewControllerContainer.view];
                         //[SwiftSpinner hide:nil];
                         view.backgroundColor = [UIColor clearColor];
                         view.alpha = 1.0;
                         [view removeFromSuperview];
                         [loader stopAnimating];
                     }];
                 }else{
                     //se envia el tipo de el controller para saber que leyenda colocar
                     self.viewControllerContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"LUIViewControllerBuzonVacio"];
                     LUIViewControllerBuzonVacio *vacio = (LUIViewControllerBuzonVacio*)self.viewControllerContainer;
                     vacio.texto = @"enviado";
                     [self addChildViewController:self.viewControllerContainer];
                     [self.contenidoBuzonView addSubview:self.viewControllerContainer.view];
                     //[SwiftSpinner hide:nil];
                     view.backgroundColor = [UIColor clearColor];
                     view.alpha = 1.0;
                     [view removeFromSuperview];
                     [loader stopAnimating];
                 }
             }else{
                 //[SwiftSpinner hide:nil];
                 view.backgroundColor = [UIColor clearColor];
                 view.alpha = 1.0;
                 [view removeFromSuperview];
                 [loader stopAnimating];
                 //se muestra un alert
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"Ocurrio un error al tratar de conectarse, por favor, intente de nuevo" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
             }
//             [SwiftSpinner hide:nil];
             
         }];
    }else{
        ///Se remueve la vista para que al cambiar de opcion no cause problemas
        [self.viewControllerContainer removeFromParentViewController];
        [self.viewControllerContainer.view removeFromSuperview];
        NSLog(@"pulso el segundo valor");
        
        //NSString * nip = [NSString stringWithFormat:@"%@", self.padrino.nip_godfather];
        //colocar el nip y el token de los usuarios logeados
        LServiceObjectBuzon *service = [[LServiceObjectBuzon alloc] initRecibidos:@"56991" token:@"UWsHk2M7UZtclZIbjWkGlut7mYfJPrfKTVp=lJx9khyy"];
        //LServiceObjectBuzon *service = [[LServiceObjectBuzon alloc] initRecibidos:nip token:self.padrino.token];
        [service startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error)
         {
             //NSLog(@"la respuesta de los recibidos %@", response);
             if(response && ![response isEqual:[NSNull null]]){
                 if([response[LBuzonRecibidos] count] > 0){
                     
                     //falta hacer peticion de buzon recibidos
                     self.viewControllerContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"IdentificadorBuzonR"];
                     ///Se agrega a la vista contenedora el viewController correspondiente
                     [self addChildViewController:self.viewControllerContainer];
                     [self.contenidoBuzonView addSubview:self.viewControllerContainer.view];
                     BuzonRecibidosViewController *buzon = (BuzonRecibidosViewController*)self.viewControllerContainer;
                     buzon.response = response;
                     buzon.tipoMenu = @"ahijados";
                     view.backgroundColor = [UIColor clearColor];
                     view.alpha = 1.0;
                     [view removeFromSuperview];
                     [loader stopAnimating];
                 }else{
                     //se envia el tipo de el controller para saber que leyenda colocar
                     self.viewControllerContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"LUIViewControllerBuzonVacio"];
                     LUIViewControllerBuzonVacio *vacio = (LUIViewControllerBuzonVacio*)self.viewControllerContainer;
                     vacio.texto = @"recibido";
                     [self addChildViewController:self.viewControllerContainer];
                     [self.contenidoBuzonView addSubview:self.viewControllerContainer.view];
                     //[SwiftSpinner hide:nil];
                     view.backgroundColor = [UIColor clearColor];
                     view.alpha = 1.0;
                     [view removeFromSuperview];
                     [loader stopAnimating];
                 }
             }else{
                 //[SwiftSpinner hide:nil];
                 view.backgroundColor = [UIColor clearColor];
                 view.alpha = 1.0;
                 [view removeFromSuperview];
                 [loader stopAnimating];
                 //se muestra un alert
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"Ocurrio un error al tratar de conectarse, por favor, intente de nuevo" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
             }
         }];
    }
    
}

@end