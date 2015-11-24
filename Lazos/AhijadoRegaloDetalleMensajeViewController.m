//
//  AhijadoRegaloDetalleMensajeViewController.m
//  Lazos
//
//  Created by sferea on 07/10/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

///Maneja el detalle del mensaje que lleva el regalo
#import <Foundation/Foundation.h>
#import "AhijadoRegaloDetalleMensajeViewController.h"
#import "LManagerObject.h"
#import "LMAhijado.h"
#import "LMPadrino.h"
#import "LUIViewControllerTabBar.h"
#import "LServiceObjectRegistrarRegalo.h"
#import "AhijadoRegaloViewController.h"
#import "LUIViewControllerBuzonAhijados.h"
#import "LConstants.h"
#import "LReachability.h"
#import "DDIndicator.h"

@interface AhijadoRegaloDetalleMensajeViewController ()
@property(strong, nonatomic) LMAhijado *ahijado;
@property(strong, nonatomic) LMPadrino *padrino;
@property BOOL flag;
@property BOOL bandera;
@end

@implementation AhijadoRegaloDetalleMensajeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ///Se setea un título al navigation bar
    [self.navigationItem setTitle:@"Registra tu regalo"];
    NSLog(@"Título en la pantalla de registrar el regalo - redacción %@", self.navigationItem.title);
    ///Agrega un borde redondeado al control del TextView: "descripcionRegalo"
    self.descripcionRegalo.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.descripcionRegalo.layer.borderWidth = 0.5;
    
    ///Se crea la variable de sesión que contiene el Nip del ahijado
    NSNumber *sesion = [[NSUserDefaults standardUserDefaults] objectForKey:@"LNipAhijado"];
    NSLog(@"Variable de sesión en RegaloDetalleMensaje- nip %@", sesion);
    ///Consulta y trae de la base la información del ahijado pasándole el nip
    LManagerObject *store = [LManagerObject sharedStore];
    self.ahijado = [store shareNip:sesion];
    NSLog(@"Nombre del ahijado de la Base de datos en RegaloDetalleMensaje- nombre %@", self.ahijado.nombre_ahijado);
    NSArray *arrayPadrino = [store showData:@"LMPadrino"];
    self.padrino = [arrayPadrino objectAtIndex:0];
    self.flag = NO;
    self.bandera = YES;
    [self addDataView];
}

-(void)viewDidAppear:(BOOL)animated{
    ///Se setea un título al navigation bar
    [self.navigationItem setTitle:@"Registra tu regalo"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
 Método que agrega los datos del servicio en la pantalla
 */
-(void)addDataView{
    self.nombreAhijado.text = [self.ahijado.nombre_ahijado uppercaseString];
    self.apellidosAhijado.text = [NSString stringWithFormat:@"%@%@%@", [self.ahijado.apellido_paterno_ahijado uppercaseString], @" ", [self.ahijado.apellido_materno_ahijado uppercaseString]];
    //Imprime la fecha actual del teléfono en el siguiente formato: 10/Mayo/2015
    ///Se le da el formato requerido a la fecha
    NSDate *fechaActual = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];
    dateFormatter.timeZone = destinationTimeZone;
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setDateFormat:@"dd/MMMM/YYYY"];
    dateFormatter.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
    self.fechaRegalo.text = [dateFormatter stringFromDate: fechaActual];
    NSLog(@"Fecha actual - Se imprime en AhijadoRegaloDetalle - %@",self.fechaRegalo.text);
    
    ///Imprime la hora actual del teléfono en el siguiente formato: 14:31 hrs.
    ///Formato de hora
    NSDate *horaActual = [NSDate date];
    ///Se le da el formato requerido a la hora
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *destinationTimeZone1 = [NSTimeZone systemTimeZone];
    timeFormatter.timeZone = destinationTimeZone1;
    [timeFormatter setDateStyle:NSDateFormatterLongStyle];
    [timeFormatter setDateFormat:@"HH:mm"];
    timeFormatter.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
    //self.horaRegalo.text = [timeFormatter stringFromDate: horaActual];
    
    self.horaRegalo.text = [NSString stringWithFormat:@"%@%@", [timeFormatter stringFromDate: horaActual], @" hrs."];
    NSLog(@"Hora actual - Se imprime en AhijadoRegaloDetalle - %@",self.horaRegalo.text);
}

/**
 Método que se encarga de llamar la alerta tras pulsar el botón de Registrar
 */
-(IBAction)pressButton:(UIButton*)sender{
    NSLog(@"Llama la alerta tras presionar el botón de Registrar tras Redactar la descripción %@", self.descripcionRegalo.text);
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
 Método que muestra el alert de seguridad
 */
-(void)showAlert{
    ///Si el padrino escribió un mensaje y da click en Registrar se muestra un alert solicitando confirmar el envío
    if(![self.descripcionRegalo.text isEqualToString:@""] && ![self.descripcionRegalo.text isEqualToString:@"Describe tu regalo..."]){
        NSString *nombreAhijado = [NSString stringWithFormat:@"%@%@%@", self.nombreAhijado.text, @" " ,self.apellidosAhijado.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Estas seguro que quieres registrar este regalo para:" message:nombreAhijado delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];
        [alert show];
    }else{
        ///Si el padrino no escribió un mensaje y da click en Registrar se muestra un alert solicitando describir el regalo
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"Por favor redacta el regalo que vas a enviar a tu ahijado." delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
        [alert show];
        self.bandera = NO;
    }
}

/**
 Método que controla los clicks del alert
 */
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"hizo click en algun boton de alert, pulso %ld", (long)buttonIndex);
    if(self.bandera){
        ///Si dió click en Aceptar para enviar la carta busca el tab bar y selecciona el item del Buzón para que aparezca esa vista
        if (buttonIndex == 0) {
            if(self.flag){
                ///Realiza el segue para mostrar el Buzón de Enviados
                [self performSegueWithIdentifier:@"segueRegistradoBuzon" sender:self];
                NSLog(@"Realiza el segue para mostrar el Buzón de Enviados");
                
                self.flag = NO;
            }else{
                NSString *nipPadrino = [NSString stringWithFormat:@"%@", self.padrino.nip_godfather];
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                DDIndicator *loader = [[DDIndicator alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 20, self.view.frame.size.height / 2 -20, 40, 40)];
                view.backgroundColor = [UIColor whiteColor];
                view.alpha = 0.5;
                [self.view addSubview:view];
                [self.view addSubview:loader];
                [loader startAnimating];
                LServiceObjectRegistrarRegalo *serviceRegistro = [[LServiceObjectRegistrarRegalo alloc] initWithDataGift:nipPadrino token:self.padrino.token nipAhijado:self.ahijado.nip_ahijado tipo:@"Regalos" descripcion:self.descripcionRegalo.text ahijadoFilial:self.ahijado.filial escuela:self.ahijado.ni_escuela generoPadrino:self.padrino.gender];
                
                [serviceRegistro startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error)
                 {
                     NSLog(@"respuesta al registrar el regalo %@", response);
                     ///Valida la respuesta en el JSon tras registrar el regalo
                     if ([response[@"mensaje"] isEqualToString:@"TRUE"] && ![response isEqual:[NSNull null]]) {
                         LServiceObjectRegistrarRegalo *serviceRegistroApilazos = [[LServiceObjectRegistrarRegalo alloc] initWithDataApilazos:nipPadrino token:self.padrino.token];
                         [serviceRegistroApilazos startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error) {
                             NSLog(@"que traeee %@", response);
                             ///Cambia el título al navigation bar de "Registra tu regalo" a 'Regalo registrado' cuando se le da Aceptar a la pregunta de registrar el regalo
                             [self.navigationItem setTitle:@"Regalo registrado"];
                             ///Se muestra un alert
                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tu regalo ha sido registrado exitosamente" message:@"" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
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
 Método del delegate de un textview que maneja cuando se entra por primera vez al texView
 */
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if([self.descripcionRegalo.text isEqualToString:@"Describe tu regalo..."]){
        self.descripcionRegalo.text = @"";
    }
}

/**
 Método que se encarga de controlar que al pulsar en cualquier parte de la pantalla se oculte el teclado
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
    [self.descripcionRegalo resignFirstResponder];
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
    // obtiene la información de la notificación
    NSDictionary* info = [notification userInfo];
    
    //Obtiene el tamaño del teclado
    CGRect keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //Mueve la vista
    [self moveViewUp:YES by:keyboardSize.size.height];
    
}

/**Método para responder a la acción de cerrar el teclado**/

- (void)keyboardWillHide:(NSNotification *) notification
{
    
    //Obtiene el tamaño del teclado
    // obtiene la información de la notificación
    NSDictionary* info = [notification userInfo];
    
    // Obtiene el tamaño del teclado
    CGRect keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    //Mueve la vista
    [self moveViewUp:NO by:keyboardSize.size.height];
    
}


/**Método para mover las vistas arriba o abajo cuando se muestra u oculta el teclado**/

-(void)moveViewUp:(BOOL)movedUp by:(CGFloat)size
{
    //Crea una animación
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    //Insets del scroll para moverlo
    UIEdgeInsets contentInsets;
    
    if (movedUp)
    {
        //Crea los insets para el scrollview agregando el alto del teclado
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, size, 0.0);
    }
    else
    {
        //Crea los insets con valor de 0 para el scroll
        contentInsets = UIEdgeInsetsZero;
    }
    
    //Establece los nuevos insets en la vista y el scroll
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    if(movedUp)
    {
        //Realiza el scroll
        CGRect  fullFrame=self.view.frame;
        CGRect targetViewFrame=self.descripcionRegalo.frame;
        fullFrame.size.height -= size;
        
        //if (!CGRectContainsPoint(fullFrame	, targetViewFrame.origin) )
        //{
        CGPoint scrollPoint = CGPointMake(0.0, targetViewFrame.origin.y);
        scrollPoint=[self.viewContent convertPoint:scrollPoint fromView:self.descripcionRegalo.superview];
        [self.scrollView setContentOffset:scrollPoint animated:YES];
        //}
    }
    //Anima el movimiento
    [UIView commitAnimations];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //se manda al tab bar un string que es el tipo de redactar para que posicione la opcion del buzon
    LUIViewControllerTabBar *tab = [segue destinationViewController];
    tab.tipo = @"registrar";
    
}
@end
