//
//  LUIViewControllerRedactar.m
//  Lazos
//
//  Created by Programacion on 9/28/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIviewControllerRedactar.h"
#import "LManagerObject.h"
#import "LMAhijado.h"
#import "LMPadrino.h"
#import "LServiceObjectEnviarCarta.h"
#import "LUIViewControllerTabBar.h"
#import "LReachability.h"
#import "DDIndicator.h"

@interface LUIViewControllerRedactar()

@property(strong, nonatomic) LMAhijado *ahijado;
@property(strong, nonatomic) LMPadrino *padrino;
@property NSInteger plantilla;
@property BOOL flag;
@property BOOL bandera;

@end

@implementation LUIViewControllerRedactar

-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.imagenPlantilla.image = [UIImage imageNamed:@"ic_image_plantilla_papalote.png"];
    //se setea un titulo al navigation bar
    [self.parentViewController.navigationItem setTitle:@"Envíar una carta a tu ahijado"];
    
    NSNumber *sesion = [[NSUserDefaults standardUserDefaults] objectForKey:@"LNipAhijado"];
    LManagerObject *ahijadoDetalle = [LManagerObject sharedStore];
    self.ahijado = [ahijadoDetalle shareNip:sesion];
    NSArray *arrayPadrino = [ahijadoDetalle showData:@"LMPadrino"];
    /*for(int cont=0; cont<arrayPadrino.count; cont++){
     self.padrino = [arrayPadrino objectAtIndex:cont];
     }*/
    self.padrino = [arrayPadrino objectAtIndex:0];
    self.plantilla = 1;
    self.flag = NO;
    self.bandera = YES;
    [self addDataView];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.parentViewController.navigationItem setTitle:@"Envíar una carta a tu ahijado"];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerKeyboard];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self releaseKeyboard];
}

/**
 Metod que agrega los datos del servicio en la pantalla
 */
-(void)addDataView{
    self.nombreAhijado.text = [self.ahijado.nombre_ahijado uppercaseString];
    self.apellidosAhijado.text = [NSString stringWithFormat:@"%@%@%@", [self.ahijado.apellido_paterno_ahijado uppercaseString], @" ", [self.ahijado.apellido_materno_ahijado uppercaseString]];
}

/**
 Metodo que se encarga de realizar una accion al pulsar los botonos de la vista
 */
-(IBAction)pressButton:(UIButton*)sender{
    
    //si el tag es diferente de 5 se guarda para saber que plantilla se eligio
    if(sender.tag != 5){
        self.plantilla = sender.tag;
    }
    switch (sender.tag) {
        case 1:
            self.imagenPlantilla.image = [UIImage imageNamed:@"ic_image_plantilla_papalote.png"];
            break;
        case 2:
            self.imagenPlantilla.image = [UIImage imageNamed:@"ic_image_plantilla_muñeca.png"];
            break;
        case 3:
            self.imagenPlantilla.image = [UIImage imageNamed:@"ic_image_plantilla_robot.png"];
            break;
        case 4:
            self.imagenPlantilla.image = [UIImage imageNamed:@"ic_image_plantilla_avion.png"];
            break;
        case 5:
            [self conexion];
            break;
        default:
            break;
    }
}

/*!
 *  @brief  Metodo que verifica si hay internet, en caso contrario envia un alert
 */
-(void)conexion{
    LReachability *reachable = [LReachability reachabilityForInternetConnection];
    if(reachable.isReachable){
        [self showAlert];
    }else{
        //se muestra un alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Verifica tu conexión a internet" message:@"" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
        [alert show];
        self.bandera = NO;
    }
}

/**
 Metodo que muestra el alert de seguridad
 */
-(void)showAlert{
    if(![self.textoCarta.text isEqualToString:@""] && ![self.textoCarta.text isEqualToString:@"Escribe tu mensaje..."]){
        NSString *nombreAhijado = [NSString stringWithFormat:@"%@%@%@", self.nombreAhijado.text, @" " ,self.apellidosAhijado.text];
        //se muestra un alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Estas seguro que quieres enviar esta carta a:" message:nombreAhijado delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];
        [alert show];
    }else{
        //se muestra un alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"Escribe una carta para tu ahijado" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
        [alert show];
        self.bandera = NO;
    }
}

/**
 Metodo que controla los clicks del alert
 */
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"hizo click en algun boton de alert, pulso %ld", (long)buttonIndex);
    if(self.bandera){
        if (buttonIndex == 0) {
            if(self.flag){
                NSLog(@"buscando el tab Bar %@", self.parentViewController);
                LUIViewControllerTabBar *tabBar = (LUIViewControllerTabBar *)self.parentViewController;
                tabBar.selectedIndex = 4;
                self.flag = NO;
            }else{
                //hacer el segue para enviar a la siguiente pantalla que muestra la carta redactada, enviar hora de creacion y fecha, nombre de ahijado, imagen, descripcion de la carta
                NSString *nipPadrino = [NSString stringWithFormat:@"%@", self.padrino.nip_godfather];
                NSString *numeroPlantilla = [NSString stringWithFormat:@"%d", self.plantilla];
                NSString *genero = self.padrino.gender;
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                DDIndicator *loader = [[DDIndicator alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 20, self.view.frame.size.height / 2 -20, 40, 40)];
                view.backgroundColor = [UIColor blackColor];
                view.alpha = 0.5;
                [self.view addSubview:view];
                [self.view addSubview:loader];
                [loader startAnimating];
                LServiceObjectEnviarCarta *serviceEnvio = [[LServiceObjectEnviarCarta alloc] initWithData:nipPadrino token:self.padrino.token nipAhijado:self.ahijado.nip_ahijado plantilla:numeroPlantilla tipo:@"Cartas" descripcion:self.textoCarta.text ahijadoFilial:self.ahijado.filial escuela:self.ahijado.ni_escuela genero:genero];
                [serviceEnvio startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error)
                 {
                     NSLog(@"respuesta al enviar una carta %@", response);
                     
                     if ([response[@"mensaje"] isEqualToString:@"TRUE"] && ![response isEqual:[NSNull null]]) {
                         
                         LServiceObjectEnviarCarta *serviceEnvioApilazos = [[LServiceObjectEnviarCarta alloc] initWithDataApilazos:nipPadrino token:self.padrino.token];
                         [serviceEnvioApilazos startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error) {
                             NSLog(@"la respuesta de Apilazos %@", response);
                             //se muestra un alert
                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tu carta ha sido enviada exitosamente" message:@"" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
                             [alert show];
                             self.flag = YES;
                             view.backgroundColor = [UIColor clearColor];
                             view.alpha = 1.0;
                             [view removeFromSuperview];
                             [loader stopAnimating];
                         }];
                     }else{
                         //se muestra un alert
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ocurrio un error al enviar la carta" message:@"" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
                         [alert show];
                         self.flag = NO;
                         view.backgroundColor = [UIColor clearColor];
                         view.alpha = 1.0;
                         [view removeFromSuperview];
                         [loader stopAnimating];
                     }
                     
                 }];
            }
        }
    }else{
        self.bandera = YES;
    }
}

/**
 Metodo del delegate de un textview que maneja cuando se entra por primera vez al texView
 */
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if([self.textoCarta.text isEqualToString:@"Escribe tu mensaje..."]){
        self.textoCarta.text = @"";
    }
}

/**
 Metodo que se encarga de controlar que al pulsar en cualquier parte de la pantalla se oculte el teclado
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
    [self.textoCarta resignFirstResponder];
}

#pragma mark - Manejo del teclado

/** Registra los observadores del teclado **/
-(void)registerKeyboard
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

/** Libera los observadores del teclado**/
-(void)releaseKeyboard
{
    // Deja de recibir notificaciones del teclado
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

/**Método para responder a la acción de abrir el teclado**/
-(void)keyboardDidShow:(NSNotification *) notification
{
    //Obtiene el tamaño del teclado
    /* obtiene la información de la notificación */
    NSDictionary* info = [notification userInfo];
    
    /* Obtiene el tamaño del teclado */
    CGRect keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    /*Mueve la vista*/
    [self moveViewUp:YES by:keyboardSize.size.height];
    
}

/**Método para responder a la acción de cerrar el teclado**/
- (void)keyboardWillHide:(NSNotification *) notification
{
    
    //Obtiene el tamaño del teclado
    /* obtiene la información de la notificación */
    NSDictionary* info = [notification userInfo];
    
    /* Obtiene el tamaño del teclado */
    CGRect keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    /*Mueve la vista*/
    [self moveViewUp:NO by:keyboardSize.size.height];
    
}

/**Método para mover las vistas arriba o abajo cuantdo se muestra u oculta el teclado**/
-(void)moveViewUp:(BOOL)movedUp by:(CGFloat)size
{
    //Crea una animación
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    //Insets del scroll para moverlo
    UIEdgeInsets contentInsets;
    
    if (movedUp)
    {
        /*Crea los insets para el scrollview agregando el alto del teclado*/
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, size, 0.0);
    }
    else
    {
        /*Crea los insets con valor de 0 para el scroll*/
        contentInsets = UIEdgeInsetsZero;
    }
    
    /*Establece los nuevos insets en la vista y el scroll*/
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    if(movedUp)
    {
        //Realiza el scroll
        CGRect  fullFrame=self.view.frame;
        CGRect targetViewFrame=self.textoCarta.frame;
        fullFrame.size.height -= size;
        
        //if (!CGRectContainsPoint(fullFrame	, targetViewFrame.origin) )
        //{
        CGPoint scrollPoint = CGPointMake(0.0, targetViewFrame.origin.y);
        scrollPoint=[self.scrollContent convertPoint:scrollPoint fromView:self.textoCarta.superview];
        [self.scrollView setContentOffset:scrollPoint animated:YES];
        //}
    }
    //Anima el movimiento
    [UIView commitAnimations];
}

@end