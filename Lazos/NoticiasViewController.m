//
//  NoticiasViewController.m
//  Lazos
//
//  Created by sferea on 04/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import "NoticiasViewController.h"
#import "NoticiaVideoTableViewCell.h"
#import "NoticiaTableViewCell.h"
#import "LServicesObjectNoticia.h"
#import "SWRevealViewController.h"
#import "LUIDetalleNoticiaViewController.h"
#import "LManagerObject.h"
#import "LMNoticia.h"
#import "LManagerObject.h"
#import "LConstants.h"
#import "LMNoticia.h"
#import "UIImageView+WebCache.h"
#import "LUIViewControllerVideo.h"
#import "LConstants.h"
#import "LUtil.h"
#import "LMPadrino.h"
//#import "Lazos-Swift.h"
#import "DDIndicator.h"

@interface NoticiasViewController ()
@property (strong,nonatomic) NSArray * noticias;
@property (strong, nonatomic)LMNoticia *noticia;
@property (strong, nonatomic)NSString *tipoSeague;
@end

@implementation NoticiasViewController

///Identificador de la celda para el video
static NSString *CellIdentifier = @"NoticiaVideoTableViewCell";
///Identificador de la celda para las noticias
static NSString *CellIdentifier2 = @"NoticiaTableViewCell";

///Almacena el título de la celda del video
NSArray *videoTexto;
///Almacena el título de la celda de la noticia
NSArray *noticiaTexto;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //si se pulsa la opcion del menu se vuelve a hacer la peticion de las noticias, si es la primera vez que entra en login se hacen ahi.
    NSNumber *mensaje = [[NSUserDefaults standardUserDefaults] objectForKey:LMenuNoticiasMensaje];
    if(mensaje.boolValue){
        //[SwiftSpinner show:@"Descargando noticias..." animated:YES];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        DDIndicator *loader = [[DDIndicator alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 20, self.view.frame.size.height / 2 -20, 40, 40)];
        view.backgroundColor = [UIColor whiteColor];
        view.alpha = 0.5;
        [self.view addSubview:view];
        [self.view addSubview:loader];
        [loader startAnimating];
        LUtil *util = [LUtil instance];
        LMPadrino *padrino = [util oftenPadrino];
        //se obtiene el nip y el token para enviarlos a la peticion de las noticias
        NSString *nip = [NSString stringWithFormat:@"%@", padrino.nip_godfather];
        //se hace la peticion de las noticias y se guardan en la base de datos
        NSLog(@"Lo que trae en NoticiasViewController nip: %@ token: %@", nip, padrino.token);
        LServicesObjectNoticia *serviceLogin = [[LServicesObjectNoticia alloc] initWithNoticia:nip tokenPadrino:padrino.token];
        [serviceLogin startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error)
         {
             NSLog(@"la respuesta %@", response);
             if(response && ![response isEqual:[NSNull null]]){
                 [self addViewData];
                 [self.tableView reloadData];
                 //[SwiftSpinner hide:nil];
                 view.backgroundColor = [UIColor clearColor];
                 view.alpha = 1.0;
                 [view removeFromSuperview];
                 [loader stopAnimating];
             }else{
                 //[SwiftSpinner hide:nil];
                 UIView *viewNoNoticias = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                 viewNoNoticias.backgroundColor = [UIColor whiteColor];
                 [self.view addSubview:viewNoNoticias];
                 view.backgroundColor = [UIColor clearColor];
                 view.alpha = 1.0;
                 [view removeFromSuperview];
                 [loader stopAnimating];
                 //se muestra un alert
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"Ocurrio un error con la conexión, favor de intentar de nuevo" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
             }
         }];
    }else{
        [self addViewData];
    }
    
    //se cambia de color del navigation bar
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:16/255.0 green:28/255.0 blue:133/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    //se cambia el color del texto del navigation bar
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //se setea un titulo al navigation bar
    [self.navigationItem setTitle:@"Noticias de tu interés"];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    //se le quita el texto de la flecha de back
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    self.hidesBottomBarWhenPushed = YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)addViewData{
    //se recibe la notificacion y se pone visible la vista principal
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectorNotification:) name:@"notificacion" object:nil];
    [self ordenaArregloNoticias];
}

-(void)ordenaArregloNoticias {
    
    LManagerObject *store = [LManagerObject sharedStore];
    self.noticias = [NSArray arrayWithArray: [store showData:@"LMNoticia"]];
             
    ///Ordena el arreglo de noticias según el id (asignado en initWithKey)
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id_noticia"
                                                          ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    self.noticias = [self.noticias sortedArrayUsingDescriptors:sortDescriptors];
}

#pragma mark - UIViewDataSource
///Informa al table view cuantas filas habrá en la sección dependiendo de la cantidad de Noticias y video
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger cantidadNoticias = [self noticias].count;
    NSLog(@"------------ %ld", (long)cantidadNoticias);
    ///Regresa el número de items en el arreglo
    return cantidadNoticias;
}


//Método Personalizado para asignar la vista del video como el encabezado
- (UIView *) tableView:(UITableView *)tableView headerVideo:(NSInteger)section {
    
    ///Reutiliza la celda si existe
    NoticiaVideoTableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    ///Crea la celda si no existe
    if (headerView == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        headerView = [nib objectAtIndex:0];
    }
    
    LMNoticia * noticia = noticia= [self.noticias objectAtIndex:section];
    if (!noticia.id_noticia)
    {
        [self ordenaArregloNoticias];
        noticia= [self.noticias objectAtIndex:section];
    }
    
    ///Llena el título del video
    headerView.videoTexto.text=noticia.titulo;
    ///Se obtiene la imagen de la direccion url de la noticia mediante las clases que utilizan blocks
    NSURL *url = [NSURL URLWithString:noticia.url_imagen];
    [headerView.videoImagen sd_setImageWithURL:url placeholderImage:[UIImage alloc]];
    
    
    ///Regresa la celda del video
    return headerView;
}

#pragma mark - UIViewDelegate
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
}

///Se llama a éste método cuando la tabla es mostrada
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     NSLog(@"tipo noticia %ld", (long)indexPath.row);
    
    [self ordenaArregloNoticias];
    ///Asigna la información a cada noticia
    LMNoticia * noticia;
    noticia= [self.noticias objectAtIndex:indexPath.row];
    
    if (!noticia.id_noticia)
    {
        [self ordenaArregloNoticias];
        noticia= [self.noticias objectAtIndex:indexPath.row];
    }
    NSLog(@"tipo noticia %@", noticia.id_noticia);
    
    if ([noticia.tipo_noticia isEqualToString:@"noticia"]){
       
        
        //Reutiliza la celda si existe
        NoticiaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        //Crea la celda si no existe
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier2 owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        ///Llena el título del video
        cell.noticiaTexto.text=noticia.titulo;
        
        ///Se obtiene la imagen de la direccion url de la noticia mediante las clases que utilizan blocks
        NSString * direccion =noticia.url_imagen;
        direccion = [direccion stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:direccion];
        [cell.noticiaImagen sd_setImageWithURL:url placeholderImage:[UIImage alloc]];
        
        return cell;
    }
    else if ([noticia.tipo_noticia isEqualToString:@"video"])
    {
        UITableViewCell *vistaVideo = (UITableViewCell *)[self tableView:tableView headerVideo:indexPath.row];
        return vistaVideo;
    }
    
    return nil;
}

///Establece la altura de las filas del Table View de Noticias
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return self.view.frame.size.height / 2;
    } else {
        return self.view.frame.size.height / 3;
    }
    
}

/**
 Metodo que controla el click sobre los elementos de la tabla de las noticias
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //si se pulsa una noticia manda al avista que muestra su detalle
    if(indexPath.row != 0){
        
        self.noticia = [self.noticias objectAtIndex:indexPath.row];
        
        if (!self.noticia.id_noticia)
        {
            [self ordenaArregloNoticias];
            self.noticia= [self.noticias objectAtIndex:indexPath.row];
        }
        
        self.tipoSeague = @"detalle";
        //se hace la ejecucion del seague que llevara a la siguiente pantalla
        [self performSegueWithIdentifier:@"detalleNoticia" sender:self];
    }else{
        [self ordenaArregloNoticias];
        self.noticia = [self.noticias objectAtIndex:indexPath.row];
        
        UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        self.tipoSeague = @"video";
        [self performSegueWithIdentifier:@"video" sender:headerView];
    }
}

/**
 Metodo que envia informacion a la siguiente pantalla por el metodo del seague
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"entra al metodo del seague?");
    if([self.tipoSeague isEqualToString:@"detalle"]){
        //se envia el objeto de la noticia para mostrar el detalle de la noticia
        LUIDetalleNoticiaViewController *detalleNoticia = [segue destinationViewController];
        detalleNoticia.noticia = self.noticia;
    }else{
        //enviar la url del video que se mostrara en el viewController
        LUIViewControllerVideo *video = [segue destinationViewController];
        NSLog(@"mi url %@", self.noticia.url_video);
        video.urVideo = self.noticia.url_video;
    }
}

/**
 Metodo que se encarga de cambiar de orientacion al entrar a esta actidividad
 */
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

/**
 Metodo que se encarga de realizar la accion al recibir la notificacion
 */
-(void)selectorNotification:(NSNotificationCenter*)notification{
    //se vuelven a obtener de la base de datos los datos de las noticias
    [self ordenaArregloNoticias];
    //se recarga la tabla para que muestre las noticias
    [self.tableView reloadData];
}

@end