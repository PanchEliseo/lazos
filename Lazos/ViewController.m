//
//  ViewController.m
//  Lazos
//
//  Created by Programacion on 8/27/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import "ViewController.h"
#import "LConstants.h"
#import "NoticiasViewController.h"
#import "LUIViewControllerVideo.h"
#import "LServicesObjectNoticia.h"
#import "LMPadrino.h"
#import "LManagerObject.h"
//#import "Lazos-Swift.h"
#import "DDIndicator.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *page;
@property NSUInteger pageIndex;
@property UIActivityIndicatorView *spinner;
@property BOOL bandera;
@property (strong, nonatomic)NSNumber *sesion;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //se crea inicializa la variable
    self.bandera = YES;
    //se obtiene la variable de sesion para saber si se pulso el boton de mantener sesion abierta o volver a poner el pager
    self.sesion = [[NSUserDefaults standardUserDefaults] objectForKey:LSession];
    //si no se ha presionado el boton de mantener en sesion
    if(!self.sesion.boolValue){
        //se agregan las paginas del page al arreglo correspondiente
        self.page = @[@"Login", @"Lazos", @"Ayuda"];
        [self addLogin];
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    //si se presiono el boton de mantener en sesion solo se agrega el menu
    if(self.bandera){
         if(self.sesion.boolValue){
             NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
             [userDefaults setObject:[NSNumber numberWithBool:NO]
                              forKey:LMenuNoticiasMensaje];
             //[SwiftSpinner show:@"Conectando..." animated:YES];
             
             [self addMenu];
         
         }
    }else{
        self.bandera = YES;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Page View Controller Data Source
/*!
 *  @brief  Metodo que se encarga de mostrar la pagina anterior del pager
 *
 *  @param pageViewController Caracteristicas del pagerController
 *  @param viewController     Caracteristicas de l viewController
 *
 *  @return El controlador anterior
 */
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    //si se hace de esta forma se tiene que agregar el identificador en el history board en el restoration id
    NSString * identifier = viewController.restorationIdentifier;
    NSUInteger index = [self.page indexOfObject:identifier];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
    
}

/*!
 *  @brief  Metodo que se encarga de mostrar la pagina posterior del pager
 *
 *  @param pageViewController Caracteristicas del pagerController
 *  @param viewController     Caracteristicas de l viewController
 *
 *  @return El controlador siguiente
 */
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    NSString *identifier = viewController.restorationIdentifier;
    NSUInteger index = [self.page indexOfObject:identifier];
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.page count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

/*!
 *  @brief  Metodo que se encarga de colocar las paginas
 *
 *  @param index Posicion del viewController
 *
 *  @return Los viewController
 */
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    
    if (([self.page count] == 0) || (index >= [self.page count])) {
        return nil;
    }
    
    NSString* page = self.page[index];
    
    // Create a new view controller and pass suitable data.
    UIViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:page];
    
    return pageContentViewController;
    
}

/*!
 *  @brief  etodo que se encarga de colocar el numero de paginas en el pager
 *
 *  @param pageViewController Caracteristicas del pageViewController
 *
 *  @return La cantidad de paginas en el pager
 */
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.page count];
}

//metodo que presenta el numero de veces las paginas
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

/*!
 *  @brief  Metodo que muestra el menu cuando ya se pulso el boton de mantener en sesion
 */
-(void)addMenu{

    //se agrega un loader de descarga, y se customisa la vista para que le de un efecto
    DDIndicator *loader = [[DDIndicator alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 20, self.view.frame.size.height / 2, 40, 40)];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.alpha = 0.5;
    [self.view addSubview:loader];
    [loader startAnimating];
    //se obtiene el usuario que esta en la base de datos, por si se pulso el boton de guardar en sesion
    LManagerObject *store = [LManagerObject sharedStore];
    NSArray *data = [store showData:@"LMPadrino"];
    LMPadrino *padrino;
    for(int cont=0; cont<data.count; cont++){
        padrino = [data objectAtIndex:cont];
    }
    NSString *nip = [NSString stringWithFormat:@"%@", padrino.nip_godfather];
    //se hace la peticion de las noticias y se guardan en la base de datos
    LServicesObjectNoticia *serviceNoticia = [[LServicesObjectNoticia alloc] initWithNoticia:nip tokenPadrino:padrino.token];
    [serviceNoticia startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error)
     {
         NSLog(@"al guardar en sesion %@", response);
         if(response && ![response isEqual:[NSNull null]]){
             self.revealViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
             [self addChildViewController:self.revealViewController];
             [self.view addSubview:self.revealViewController.view];
             [self.revealViewController didMoveToParentViewController:self];
             //[SwiftSpinner hide:nil];
             //se regresa la vista como estaba originalmente y se detiene la animacion
             self.view.backgroundColor = [UIColor clearColor];
             self.view.alpha = 1.0;
             [loader stopAnimating];
         }else{
             //[SwiftSpinner hide:nil];
             self.view.backgroundColor = [UIColor clearColor];
             self.view.alpha = 1.0;
             [loader stopAnimating];
             //se muestra un alert
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"Ocurrio un error con la conexión, favor de intentar de nuevo" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
         }
         
     }];
}

/*!
 *  @brief  Metodo que coloca el menu principal y el pager de login en la aplicacion
 */
-(void)addLogin{
    //se coloca primero el view controller que es el menu y la pagina principal, para que al remover el pager no se comporte de una forma extraña como lo hacia antes.
    self.revealViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    [self addChildViewController:self.revealViewController];
    [self.view addSubview:self.revealViewController.view];
    [self.revealViewController didMoveToParentViewController:self];
    [self.revealViewController.view setHidden:YES];
    
    //se recibe la notificacion y se pone visible la vista principal
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectorNotification:) name:@"notificacion" object:nil];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    UIViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.pageViewController.automaticallyAdjustsScrollViewInsets = NO;
    
    // Change the size of page view controller
    self.pageViewController.view.frame = self.contentView.bounds;//CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:self.pageViewController];
    [self.contentView addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}

/*!
 *  @brief  Metodos que se encargan de poner todos los controladores en portrait, solo el viewController del video tiene permiso de los dos modos
 *
 *  @return Tipo de orientacion
 */
-(NSUInteger)supportedInterfaceOrientations
{
    if ([self.revealViewController.frontViewController isKindOfClass:[UINavigationController class]])
    {
        if ([[((UINavigationController *)self.revealViewController.frontViewController).viewControllers lastObject] isKindOfClass:[LUIViewControllerVideo class]])
        {
            return UIInterfaceOrientationMaskLandscape | UIInterfaceOrientationMaskPortrait;
        }
        else
        {
            return UIInterfaceOrientationMaskPortrait;
        }
    }
    
    return UIInterfaceOrientationMaskPortrait;
 
}

/*!
 *  @brief  Metodo que se encarga de realizar la accion al recibir la notificacion
 *
 *  @param notification Caracteristicas de la notificacion
 */
-(void)selectorNotification:(NSNotificationCenter*)notification{
    //se muestra el view controller principal
    [self.revealViewController.view setHidden:NO];
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    self.bandera = NO;
    
}

@end
