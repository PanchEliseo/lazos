//
//  UIControllerLogin.m
//  Lazos
//
//  Created by Programacion on 8/31/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIControllerLogin.h"
#import "NoticiasViewController.h" //Prueba de noticias
#import "AMPopTip.h"
#import "LReachability.h"
#import "LServicesObjectLogin.h"
#import "LManagerObject.h"
#import "SWRevealViewController.h"
#import "LConstants.h"
#import "ViewController.h"
#import "LServicesObjectNoticia.h"
//#import "Lazos-Swift.h"
#import "DDIndicator.h"
#import "LServicesObjectAhijado.h"


@interface UIControllerLogin()

@property BOOL flag;
@property (nonatomic, strong) AMPopTip *popTip;
@property (strong, nonatomic) NSArray *padrinos;
@property UIActivityIndicatorView *spinner;
@property NSUserDefaults *userDefaults;

@end

@implementation UIControllerLogin

-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.flag = NO;
    [self.mensajeNoSesion setHidden:YES];
    self.campoClave.secureTextEntry = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //se anima la vista para que no se noten los cambios de contraints en la pantalla
    self.view.alpha = 0;
    [UIView animateWithDuration:0.1 animations:^(void)
     {
         self.view.alpha = 1.0;
     }];
    [self.helpNip addTarget:self action:@selector(press:event:) forControlEvents:UIControlEventTouchUpInside];
    
    //Agrega un borde redondeado al boton de login
    self.login.layer.cornerRadius = 5;
    
    //Seteo del tintColor a azul
    self.window.tintColor = [UIColor colorWithRed:16/255.0 green:28/255.0 blue:133/255.0 alpha:1.0];    
}

/**
 Metodo que se ejecuta al aparecer la vista
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    /*[UIView animateWithDuration:0.1 animations:^(void)
     {
     self.view.alpha = 1.0;
     }];*/
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
 Metodo que se encarga de mostrar los mensajes de ayuda
 */
- (IBAction)didiPressCmpartir:(UIButton*)sender event:(UIEvent*)event
{
    [self.popTip hide];
    //se crea un style para que el texto lo alinie al centro en los atributos del string
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    if(sender.tag == 1){
        if(self.popTip == nil) {
            
            self.popTip = [AMPopTip popTip];
            self.popTip.popoverColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
            self.popTip.borderWidth = 1;
            self.popTip.borderColor = [UIColor grayColor];
            
             NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:@"Tu NIP lo recibiste \n en tu paquete \n de bienvenida." attributes:@{                   NSFontAttributeName: [UIFont fontWithName:@"Arial" size:12], NSForegroundColorAttributeName: [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:133.0/255.0 alpha:1.0], NSParagraphStyleAttributeName:paragraphStyle}];
            
            [self.popTip showAttributedText:attributedText direction:AMPopTipDirectionLeft maxWidth:100 inView:self.scrollView fromFrame:self.helpNip.frame];
            /*[self.popTip showText:@"Tu NIP lo recibiste en tu paquete de bienvenida" direction:AMPopTipDirectionUp maxWidth:230 inView:self.view fromFrame:self.helpNip.frame];*/
        }else{
            self.popTip = nil;
        }
    }else if(sender.tag == 2){
        if(self.popTip == nil) {
            self.popTip = [AMPopTip popTip];
            self.popTip.popoverColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
            self.popTip.borderWidth = 1;
            self.popTip.borderColor = [UIColor grayColor];
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:@"Tu clave la recibiste en tu paquete de \n bienvenida, o la cambiaste en tu portal \n web de padrino." attributes:@{                   NSFontAttributeName: [UIFont fontWithName:@"Arial" size:12], NSForegroundColorAttributeName: [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:133.0/255.0 alpha:1.0], NSParagraphStyleAttributeName:paragraphStyle}];
            [self.popTip showAttributedText:attributedText direction:AMPopTipDirectionLeft maxWidth:240 inView:self.scrollView fromFrame:self.claveElectronica.frame];
            /*[self.popTip showText:@"Tu clave la recibiste en tu paquete de bienvenida, o la cambiaste en tu portal web de padrino" direction:AMPopTipDirectionUp maxWidth:250 inView:self.view fromFrame:self.claveElectronica.frame];*/
        }else{
            self.popTip = nil;
        }
    }else if(sender.tag == 3){
        if(self.popTip == nil) {
            self.popTip = [AMPopTip popTip];
            self.popTip.popoverColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
            self.popTip.borderWidth = 1;
            self.popTip.borderColor = [UIColor grayColor];
            
            ///Adjunta los íconos de teléfono y correo en el texto
            NSTextAttachment *attachmentTelefono = [[NSTextAttachment alloc] init];
            attachmentTelefono.image = [UIImage imageNamed:@"ic_Image_contacto_telefono"];
            NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachmentTelefono];
            
            NSTextAttachment *attachmentCorreo = [[NSTextAttachment alloc] init];
            attachmentCorreo.image = [UIImage imageNamed:@"ic_Image_contacto_correo"];
            NSAttributedString *attachmentStringCorreo = [NSAttributedString attributedStringWithAttachment:attachmentCorreo];
            
            //se crean estos arreglos que le dan atributos a los strings para darle un formato como el que se encuentra en el road map
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:@"Centro de atención a padrino Lazos \n\n" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:12], NSForegroundColorAttributeName: [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:133.0/255.0 alpha:1.0], NSParagraphStyleAttributeName:paragraphStyle}];
            
            [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Lunes a Jueves 09:00 a 20:00 horas. \n\nViernes de 09:00 a 16:00 horas. \n\n" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial" size:12],NSForegroundColorAttributeName: [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:133.0/255.0 alpha:1.0], NSParagraphStyleAttributeName:paragraphStyle}]];
            
            ///Agrega imagen y texto al dato de Área Metropolitana
            [attributedText appendAttributedString:attachmentString];
            NSAttributedString *myText = [[NSMutableAttributedString alloc] initWithString:@"  5250-5707 Área Metropolitana \n\n" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:12],NSForegroundColorAttributeName: [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:133.0/255.0 alpha:1.0], NSParagraphStyleAttributeName:paragraphStyle}];
            [attributedText appendAttributedString:myText];
            
            ///Agrega imagen y texto al dato de Interíor de la República
            [attributedText appendAttributedString:attachmentString];
            NSAttributedString *myTextR = [[NSMutableAttributedString alloc] initWithString:@"  01800-716-3009 Interíor de la República \n\n" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:12],NSForegroundColorAttributeName: [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:133.0/255.0 alpha:1.0], NSParagraphStyleAttributeName:paragraphStyle}];
            [attributedText appendAttributedString:myTextR];
            
            ///Agrega imagen y texto al dato del Correo
            [attributedText appendAttributedString:attachmentStringCorreo];
            NSAttributedString *myTextC = [[NSMutableAttributedString alloc] initWithString:@"  atnapadrinos@lazos.org.mx \n\n" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:12],NSForegroundColorAttributeName: [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:133.0/255.0 alpha:1.0], NSParagraphStyleAttributeName:paragraphStyle}];
            [attributedText appendAttributedString:myTextC];
            
            
            ////////
            CGFloat width = [UIScreen mainScreen].bounds.size.width;
            CGFloat height = [UIScreen mainScreen].bounds.size.height;
            NSLog(@"el ancho %lu", (long)width);
            NSLog(@"el alto %lu", (long)height);
            if(width <= 320 && height <= 600){
                //se muestran los popTips de ayuda al usuario, esta es una api ya desarrollada
                [self.popTip showAttributedText:attributedText direction:AMPopTipDirectionUp maxWidth:240 inView:self.scrollView fromFrame:self.buttonLlamar.frame];
            }else{
                [self.popTip showAttributedText:attributedText direction:AMPopTipDirectionUp maxWidth:240 inView:self.scrollView fromFrame:self.buttonLlamar.frame];
            }
            
        }else{
            self.popTip = nil;
        }
    }
    
}

/**
 Metodo que se encarga de realizar la accion del boton de inicio de sesion
 */
-(IBAction)session:(UIButton*)sender{
    if(sender.tag == 1){
        NSLog(@"que tieneeeeee %@ ------ %@", self.campoNip.text, self.campoClave.text);
        if(![self.campoNip.text isEqualToString:@""] && ![self.campoClave.text isEqualToString:@""]){
            //se llama a la clase que se encarga de saber si el dispositivo tiene internet
            LReachability *reachable = [LReachability reachabilityForInternetConnection];
            if(reachable.isReachable){
                
                //[SwiftSpinner show:@"Conectando..." animated:YES];
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                DDIndicator *loader = [[DDIndicator alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 20, self.view.frame.size.height / 2 -20, 40, 40)];
                //JG Antes era negro
                view.backgroundColor = self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ic_image_fondo"]];
                [super viewDidLoad];;
                view.alpha = 0.5;
                [self.parentViewController.parentViewController.view addSubview:view];
                [self.view addSubview:loader];
                [loader startAnimating];
                
                //se hace la peticion al webservice de padrinos de Lazos
                LServicesObjectLogin *serviceLogin = [[LServicesObjectLogin alloc] initWithUser:self.campoNip.text clavePadrino:self.campoClave.text tipo:@"lazos"];
                [serviceLogin startDownloadWithCompletionBlock:^(NSDictionary *responsePadrino, NSError *error){
                    
                    NSLog(@"Descarga completa del Padrino ----------> %@", responsePadrino[LPadrino]);
                    if([responsePadrino[LMensajePeticionPadrino] isEqualToString:LRespuestaPeticionPadrino]){
                        //[SwiftSpinner hide:nil];
                        //se regresa la vista como estaba originalmente y se detiene la animacion
                        view.backgroundColor = [UIColor clearColor];
                        view.alpha = 1.0;
                        [view removeFromSuperview];
                        [loader stopAnimating];
                        [self.buttonSession setHidden:YES];
                        [self.login setHidden:YES];
                        [self.mensajeSesion setHidden:YES];
                        [self.mensajeNoSesion setHidden:NO];
                        self.mensajeNoSesion.text = @"El NIP o Clave Electrónica son incorrectos, por favor verifica tus datos.";
                        //se crea un timer que mostrara el mensaje de usuario invalido
                        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timer) userInfo:nil repeats:NO];
                        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
                    }else if(!responsePadrino[LPadrino]){
                        //[SwiftSpinner hide:nil];
                        //se regresa la vista como estaba originalmente y se detiene la animacion
                        view.backgroundColor = [UIColor clearColor];
                        view.alpha = 1.0;
                        [view removeFromSuperview];
                        [loader stopAnimating];
                        //se muestra un alert
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"Verifica tu conexión a internet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        //                        [SwiftSpinner hide:nil];
                    }else{
                        //se obtienen el nip y el token para enviarlos a la peticion de apilazos y a las noticias
                        NSString *nip = [responsePadrino[LPadrino] objectForKey:LNipPadrino];
                        NSString *token = [responsePadrino[LPadrino] objectForKey:LTokenPadrino];
                        
                        /// Se obtienen también el nombre y apellidos de la respuesta en variables para mandárselas al método initWithUserApilazos que guarda el padrino en apilazos
                        NSString *nombreP = [responsePadrino[LPadrino] objectForKey:LNombrePadrino];
                        NSString *apellidoP_P = [responsePadrino[LPadrino] objectForKey:LApellidoPaternoPadrino];
                        NSString *apellidoP_M = [responsePadrino[LPadrino] objectForKey:LApellidoMaternoPadrino];
                        
                         //Se envían los parámetros al método que realiza petición a apilazos para guardar al padrino en la Base de datos donde se manejan los logros.
                         LServicesObjectLogin *serviceLoginBD = [[LServicesObjectLogin alloc] initWithUserApilazos:nip nombre:nombreP apellidoPaterno:apellidoP_P apellidoMaterno:apellidoP_M token:token tipo:@"apilazos"];
                        
                         [serviceLoginBD startDownloadWithCompletionBlock:^(NSDictionary *responseBD, NSError *error){
                         {
                             if(responseBD && ![responseBD isEqual:[NSNull null]]){
                                 NSLog(@"Respuesta de apilazos puede ser actualiza o guardado:::: %@", responseBD);
                             }
                             else{
                                 NSLog(@"No hay respuesta de apilazos %@", responseBD);
                             }
                         
                         }
                         }];
                        
                        ///Se envían los parámetros al método que realiza la petición a apilazos llamada ahijados
                        LServicesObjectAhijado *serviceAhijadoBD = [[LServicesObjectAhijado alloc] initWithUserApilazos:nip token:token tipo:@"ahijados"];
                        
                        [serviceAhijadoBD startDownloadWithCompletionBlock:^(NSDictionary *responseBD, NSError *error){
                            {
                                if(responseBD && ![responseBD isEqual:[NSNull null]]){
                                    NSLog(@"UIControllerLogin - Respuesta de apilazos puede ser actualiza o guardado:::: %@", responseBD);
                                }
                                else{
                                    NSLog(@"No hay respuesta de apilazos %@", responseBD);
                                }
                                
                            }
                        }];
                        
                        ///Se envían los parámetros al método que realiza la petición a apilazos llamada especiales. Debe realizarse antes de la llamada a guardarCasos de apilazos
                        LServicesObjectLogin *serviceEspecialesBD = [[LServicesObjectLogin alloc] initWithEspeciales:nip token:token tipo:@"especiales"];
                        
                        [serviceEspecialesBD startDownloadWithCompletionBlock:^(NSDictionary *responseBD, NSError *error){
                            {
                                if(responseBD && ![responseBD isEqual:[NSNull null]]){
                                    NSLog(@"UIControllerLogin - Especiales - Válido si respuesta es OK:::: %@", responseBD);
                                }
                                else{
                                    NSLog(@"No hay respuesta de apilazos %@", responseBD);
                                }
                                
                            }
                        }];
                        
                        ///Se envían los parámetros al método que realiza la petición a apilazos llamado guardarCasos que almacena el tipo de caso de la carta recibida al padrino
                        
                        LServicesObjectAhijado *serviceGuardaCasosBD = [[LServicesObjectAhijado alloc] guardaCasos:nip token:token];
                        
                        [serviceGuardaCasosBD startDownloadWithCompletionBlock:^(NSDictionary *responseBD, NSError *error){
                            {
                                if(responseBD && ![responseBD isEqual:[NSNull null]]){
                                    NSLog(@"UIControllerLogin - Respuesta de apilazos puede ser actualiza o guardado:::: %@", responseBD);
                                }
                                else{
                                    NSLog(@"No hay respuesta de apilazos %@", responseBD);
                                }
                                
                            }
                        }];

                        //se obtiene el nip y el token para enviarlos a la peticion de las noticias
                        //se hace la peticion de las noticias y se guardan en la base de datos
                        LServicesObjectNoticia *serviceLogin = [[LServicesObjectNoticia alloc] initWithNoticia:nip tokenPadrino:token];
                        [serviceLogin startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error)
                         {
                             NSLog(@"ServicesObject en Delegate NOTICIAS %@", response);
                             
                             //si la peticion causa algun error y devuelve null no dejara pasar y se mostrara un mensaje de error, en caso contrario entra ala aplicacion
                             if(response && ![response isEqual:[NSNull null]]){
                                 [self sendMessageNotification];
                                 //se remueve el view controller padre que es el pager, para que se muestre el que esta por debajo que es la pantalla principal.
                                 [self.parentViewController willMoveToParentViewController:nil];
                                 [self.parentViewController removeFromParentViewController];
                                 [self.parentViewController.view removeFromSuperview];
                                 //se detiene el spiner de la peticion
                                 //[SwiftSpinner hide:nil];
                                 view.backgroundColor = [UIColor clearColor];
                                 view.alpha = 1.0;
                                 [view removeFromSuperview];
                                 [loader stopAnimating];
                                 //si pulso el boton de mantener en sesion, se crea la variable que se mantiene en las perferencias
                                 if(self.flag){
                                     [self.userDefaults setObject:[NSNumber numberWithBool:YES]
                                                           forKey:LSession];
                                 }
                             }else{
                                 //[SwiftSpinner hide:nil];
                                 view.backgroundColor = [UIColor clearColor];
                                 view.alpha = 1.0;
                                 [view removeFromSuperview];
                                 [loader stopAnimating];
                                 //se muestra un alert
                                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"Ocurrio un error con la conexión, favor de intentar de nuevo" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                 [alert show];
                             }
                         }];
                    }
                    
                }];
                
            }else{
                //se muestra un alert
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"Verifica tu conexión a internet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }else{
            self.mensajeNoSesion.text = @"Por favor ingresa tu NIP y Clave eléctronica";
            //se ocultan y desocultan los botones y mensajes
            [self.buttonSession setHidden:YES];
            [self.login setHidden:YES];
            [self.mensajeSesion setHidden:YES];
            [self.mensajeNoSesion setHidden:NO];
            //se crea un timer que mostrara el mensaje de usuario invalido
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timer) userInfo:nil repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            
        }
        //se lleva el control de el boton de mantener en sesion
    }else if(sender.tag == 2){
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        if(self.flag){
            [self.buttonSession setImage:[UIImage imageNamed:@"ic_image_mantener_sesion_off.png"] forState:UIControlStateNormal];
            self.flag = NO;
            //se crea una variable que nos dira si pulso mantener en sesion o no
            [self.userDefaults setObject:[NSNumber numberWithBool:NO]
                                  forKey:LSession];
        }else{
            [self.buttonSession setImage:[UIImage imageNamed:@"ic_image_mantener_sesion_on.png"] forState:UIControlStateNormal];
            self.flag = YES;
        }
    }
}

/**
 Metodo que se encarga de ocultar los botones y mostrar el mensaje de que no es usuario valido
 */
-(void)timer{
    [self.mensajeNoSesion setHidden:YES];
    [self.buttonSession setHidden:NO];
    [self.login setHidden:NO];
    [self.mensajeSesion setHidden:NO];
}

/**
 Metodo que se encarga de controlar que al pulsar en cualquier parte de la pantalla se oculte el teclado
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
    [self.campoNip resignFirstResponder];
    [self.campoClave resignFirstResponder];
    [self.buttonSession resignFirstResponder];
}

/**
 Metodo que envia la notificacion de que se ha pulsado el boton de login
 */
-(void)sendMessageNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notificacion" object:nil];
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
    [self.scrollView scrollRectToVisible:self.login.frame animated:YES];
    
    //Anima el movimiento
    [UIView commitAnimations];
}


- (IBAction)press:(UIButton*)sender event:(UIEvent*)event{
    
    [self.imageHelp setHidden:NO];
    CGRect buttonFrame=[self.imageHelp convertRect:self.imageHelp.frame toView:self.imageHelp];
    [self.imageHelp setFrame:buttonFrame];
    
}

@end