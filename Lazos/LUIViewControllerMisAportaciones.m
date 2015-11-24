//
//  LUIViewControllerMisAportaciones.m
//  Lazos
//
//  Created by Programacion on 10/2/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerMisAportaciones.h"
#import "SWRevealViewController.h"
#import "AMPopTip.h"
#import "LUICellEncabezadoAportaciones.h"
#import "LUICellTableAportaciones.h"
#import "LUtil.h"
#import "LMPadrino.h"
#import "LServiceObjectAportaciones.h"
#import "LConstants.h"
#import "LMAportaciones.h"
#import "LUIViewControllerVerFactura.h"
//#import "Lazos-Swift.h"
#import "DDIndicator.h"

@interface LUIViewControllerMisAportaciones()

@property (nonatomic, strong) AMPopTip *popTip;
@property (nonatomic, strong) LMPadrino *padrino;
@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) NSString *fecha;
@property (strong, nonatomic) NSString *resibo;
@property (strong, nonatomic) NSString *xml;

@end

@implementation LUIViewControllerMisAportaciones

/**
 Metodo que llena el arreglo con las imagenes correspondientes a cada opcion del menu
 */
-(NSArray *)array{
    if(! _array){
        
        _array = [[NSMutableArray alloc] init];
        [_array addObject:@""];
        //se crea un spinner para que haga el loader de que esta esperando a que responda el web service de padrino
        //[SwiftSpinner show:@"Descargando aportaciones..." animated:YES];
        DDIndicator *loader = [[DDIndicator alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 20, self.view.frame.size.height / 2 -20, 40, 40)];
        [self.view addSubview:loader];
        self.view.backgroundColor = [UIColor blackColor];
        self.view.alpha = 0.5;
        [loader startAnimating];
        //aqui se tienen que sacar de la base el nip y el token reales para mandarlos en la peticion cuando este bien el servicio∫
        //se hace la peticion de la galeria de imagenes de los padrinos
        NSString * nip = [NSString stringWithFormat:@"%@", self.padrino.nip_godfather];
        //se hace la peticion al servicio correspondiente
        LServiceObjectAportaciones *serviceAportaciones = [[LServiceObjectAportaciones alloc] initWithData:nip token:self.padrino.token];
        [serviceAportaciones startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error){
            
            NSLog(@"La respuesta en las APORTACIONES %@", response[LAportaciones]);
            if(response && ![response isEqual:[NSNull null]]){
                if(![response[LAportaciones] isEqual:[NSNull null]]){
                    [self addDataPadrino];
                    
                    for(int cont=0; cont<[response[LAportaciones] count]; cont++){
                        LMAportaciones *aportaciones = [response[LAportaciones] objectAtIndex:cont];
                        [_array addObject:aportaciones];
                    }
                    //se recarga la tabla para que al terminar de hacer la peticion se recarguen los datos
                    [self.tableView reloadData];
                    //[SwiftSpinner hide:nil];
                    self.view.backgroundColor = [UIColor clearColor];
                    self.view.alpha = 1.0;
                    [loader stopAnimating];
                }else{
                    //[SwiftSpinner hide:nil];
                    self.view.backgroundColor = [UIColor clearColor];
                    self.view.alpha = 1.0;
                    [loader stopAnimating];
                    //se muestra un alert
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"Ocurrio un problema al tratar de conectarse favor de intentar de nuevo" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
                    [alert show];
                }
                //se recarga la tabla para que al terminar de hacer la peticion se recarguen los datos
                [self.tableView reloadData];
//                [SwiftSpinner hide:nil];
            }else{
                //[SwiftSpinner hide:nil];
                self.view.backgroundColor = [UIColor clearColor];
                self.view.alpha = 1.0;
                [loader stopAnimating];
                //se muestra un alert
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"Ocurrio un error al tratar de conectarse, por favor, intente de nuevo" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
        }];
    }
    return _array;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    //se cambia de color del navigation bar
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:16/255.0 green:28/255.0 blue:133/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    //se cambia el color del texto del navigation bar
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //se setea un titulo al navigation bar
    [self.navigationItem setTitle:@"Mis aportaciones"];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
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
    //se obtiene el padrino de la base de datos para mostrar la pantalla
    LUtil *functions = [LUtil instance];
    self.padrino = [functions oftenPadrino];
    
    /*NSString * nip = [NSString stringWithFormat:@"%@", self.padrino.nip_godfather];
    //se hace la peticion al servicio correspondiente
    LServiceObjectAportaciones *serviceAportaciones = [[LServiceObjectAportaciones alloc] initWithData:nip token:self.padrino.token];
    [serviceAportaciones startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error){
       
        NSLog(@"La respuesta en las APORTACIONES %@", response);
        [self addDataPadrino];
        
        self.array = [NSMutableArray arrayWithObjects:@"¡Felicidades!", @"¡Feliz Cumpleaños!", @"¡Feliz graduación!", @"¡Feliz Navidad!", @"¡Muchas felicidades!", @"Excelenteeee", nil];
        [self.tableView reloadData];
        
    }];*/
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.tableView reloadData];
    
}

/**
 Metodo que agrega los datos del padrino
 */
-(void)addDataPadrino{
    
    [self.nombrePadrino setHidden:NO];
    [self.apellidosPadrino setHidden:NO];
    [self.buttonHelp setHidden:NO];
    [self.imagenNoRfc setHidden:NO];
    [self.leyendaNip setHidden:NO];
    [self.imagenNoRfc setHidden:NO];
    [self.nipPadrino setHidden:NO];
    [self.periodicidadPadrino setHidden:NO];
    [self.RFC setHidden:NO];
    [self.periodicidad setHidden:NO];
    //se pasa el texto a los outlets correspondientes, el texto debe de ser en mayusculas.
    self.nombrePadrino.text = [self.padrino.name uppercaseString];
    self.apellidosPadrino.text = [self.padrino.apellidos uppercaseString];
    NSString * nip = [NSString stringWithFormat:@"%@", self.padrino.nip_godfather];
    self.nipPadrino.text = nip;
    if([self.padrino.rfc isEqualToString:@""]){
        //sei no se tienen RFC se va a remover esta leyenda y se pondra en el footer la otra, para que se mueva y no se quede el hueco en el header de la pantalla, se agregaron constraints con prioridad menor al del que esta exactamente arriba, esto para que al remover el RFC no se quede el hueco en blanco y se recorra el texto de abajo
        [self.RFC removeFromSuperview];
    }else{
        self.RFC.text = self.padrino.rfc;
        [self.textoLeyenda removeFromSuperview];
        [self.buttonHelp removeFromSuperview];
        [self.imagenNoRfc removeFromSuperview];
        [self.leyendaDeRFC setHidden:NO];
    }
    
}

/**
 Metodo que muestra la ayuda de información con el contacto de lazos
 */
- (IBAction)showHelp:(id)sender {
    
    //se oculta el pop
    [self.popTip hide];
    //se le da estilo a la letra que tendra el pop de ayuda
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment = NSTextAlignmentCenter;
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
        
        [self.popTip showAttributedText:attributedText direction:AMPopTipDirectionUp maxWidth:240 inView:self.viewFooter fromFrame:self.textoLeyenda.frame];
        
    }else{
        self.popTip = nil;
    }
    
}

#pragma mark - UIViewDataSource
///Informa al table view cuantas filas habrá en la sección dependiendo de la cantidad de Noticias y video
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self array] count];
}

/**
 Metodo que agrega un encabezado a la tabla
 */
/*-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    LUICellEncabezadoAportaciones *cellHeader = [tableView dequeueReusableCellWithIdentifier:@"LUICellEncabezadoAportaciones"];
    
    if (cellHeader == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LUICellEncabezadoAportaciones" owner:self options:nil];
        cellHeader = [nib objectAtIndex:0];
    }
    
    return cellHeader;
}*/

/**
 Metodo que le da un tamaño al encabezado de la tabla
 */
/*-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}*/

///Se llama a éste método cuando la tabla es mostrada
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //si es la primera posicion se agrega un encabezado con la descripcion de cada elemento en las filas
    if(indexPath.row == 0){
        LUICellEncabezadoAportaciones *cellHeader = [tableView dequeueReusableCellWithIdentifier:@"LUICellEncabezadoAportaciones"];
        
        if (cellHeader == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LUICellEncabezadoAportaciones" owner:self options:nil];
            cellHeader = [nib objectAtIndex:0];
        }
        
        return cellHeader;
    }else{
        NSLog(@"probandoooo %@", [[[self array] objectAtIndex:indexPath.row] objectForKey:LFechaCargoAportacion]);
        LUICellTableAportaciones *cell = [tableView dequeueReusableCellWithIdentifier:@"LUICellTableAportaciones"];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LUICellTableAportaciones" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        if(![self.padrino.rfc isEqualToString:@""]){
            UIImage *imagenPdf = [UIImage imageNamed:@"ic_image_lupa_on.png"];
            [cell.botonPDF setBackgroundImage:imagenPdf forState:UIControlStateNormal];
            cell.botonPDF.tag = indexPath.row;
            [cell.botonPDF addTarget:self action:@selector(verPdf:) forControlEvents:UIControlEventTouchUpInside];
            UIImage *imagenEnviar = [UIImage imageNamed:@"ic_image_sobre_on.png"];
            [cell.botonEnviar setBackgroundImage:imagenEnviar forState:UIControlStateNormal];
            cell.botonEnviar.tag = indexPath.row;
            [cell.botonEnviar addTarget:self action:@selector(enviarFactura:) forControlEvents:UIControlEventTouchUpInside];
            cell.tipo = @"rfc";
        }else{
            UIImage *imagenPdf = [UIImage imageNamed:@"ic_image_lupa_off.png"];
            [cell.botonPDF setBackgroundImage:imagenPdf forState:UIControlStateNormal];
            UIImage *imagenEnviar = [UIImage imageNamed:@"ic_image_sobre_off.png"];
            [cell.botonEnviar setBackgroundImage:imagenEnviar forState:UIControlStateNormal];
        }
        int monto = [[[[self array] objectAtIndex:indexPath.row] objectForKey:LMontoAportacion] intValue];
        NSString *montoAportaciones = [[NSNumber numberWithInt:monto] descriptionWithLocale:[NSLocale currentLocale]];
        NSString *montoFinal = [NSString stringWithFormat:@"%@%@", @"$ ", montoAportaciones];
        cell.montoAportaciones.text = montoFinal;
        //se cambia la fecha a date para poderle dar un formato
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSDate * fecha_aportacion = [dateFormatter dateFromString:[[[self array] objectAtIndex:indexPath.row] objectForKey:LFechaCargoAportacion]];
        //se le da el formato requerido a la fecha del servicio
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        formatter.locale=[NSLocale localeWithLocaleIdentifier:@"es_MX"];
        [formatter setDateFormat:@"dd MMMM YYYY"];
        NSString *resultDate = [formatter stringFromDate:fecha_aportacion];
        cell.fechaAportaciones.text = resultDate;
        self.fecha = resultDate;
        
        return cell;
    }
    
}

-(IBAction)verPdf:(UIButton*)sender{
    NSLog(@"el pulsadoooooooo %@ = %ld", [[[self array] objectAtIndex:sender.tag] objectForKey:LResiboAportacion], (long)sender.tag);
    self.resibo = [[[self array] objectAtIndex:sender.tag] objectForKey:LResiboAportacion];
    [self performSegueWithIdentifier:@"verFactura" sender:self];
}

-(IBAction)enviarFactura:(UIButton*)sender{
    NSLog(@"el pulsadoooooooo %@ = %ld", [[[self array] objectAtIndex:sender.tag] objectForKey:LResiboAportacion], (long)sender.tag);
    self.resibo = [[[self array] objectAtIndex:sender.tag] objectForKey:LResiboAportacion];
    self.xml = [[[self array] objectAtIndex:sender.tag] objectForKey:LXmlAportacion];
    //se envia por correo la url del cfdi
    [self enviar];
}

/**
 Metodo que se encarga de mostrar la opcion de enviar un correo
 */
-(void)enviar{
    //enviar por correo el rfc
    MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
    mailCont.mailComposeDelegate = self;
    
    NSString *asunto = [NSString stringWithFormat:@"%@%@", @"Estado de cuenta Programa Lazos: ", self.fecha];
    [mailCont setSubject:asunto];
    NSString *mensaje = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@", @"Estimado Padrino / Madrina: \n \n En los siguientes links podrás consultar y descargar tu Comprobante Fiscal correspondiente a la aportación realizada el ", self.fecha, @" \n \n Consultar o descargar la representación impresa en PDF: \n", self.resibo, @"\n\n Descargar archivo XML: \n", self.xml ,@" \n \n ", @"Para cualquier duda y/o aclaración quedamos a tus órdenes en: \n\n Nuestro Centro de Atención a Padrinos Lazos \n\n DF y Area Metropolitana: \n\n Lunes a Jueves: 09:00 a 20:00 horas \n Viernes: 09:00 a 16:00 horas \n Teléfono: 52.50.57.07 \n Interior de la República \n Lada sin costo: 01.800.716.30.09 \n\n Atentamente \n Lazos"];
    [mailCont setMessageBody:mensaje isHTML:NO];
    /*UIViewController *vc = [[UIViewController alloc] init];
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:link];
    [vc setView:view];
    [mailCont addChildViewController:vc];*/
    [self presentModalViewController:mailCont animated:YES];
    
}

//este metodo es para que al darle cancel en el correo se cierre el viewController
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

/**
 *@brief metodo para enviar datos a la siguiente pantalla que hara los calculos.
 *@param segue se utiliza en el metodo para saber cual es el destino del boton
 *@param sender se utiliza en las actividades del metodo
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    LUIViewControllerVerFactura *verFactura = [segue destinationViewController];
    verFactura.url = self.resibo;
    
}

/**
 Metodo que controla los clicks del alert
 */
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        NSLog(@"pulso el primer boton");
        [self array];
    }else{
        NSLog(@"pulso el segundo");
    }
    
}

@end