//
//  LUIViewControllerMensajes.m
//  Lazos
//
//  Created by Programacion on 9/22/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerMensajes.h"
#import "LManagerObject.h"
#import "LUIViewControllerDetalleMensajeEnviados.h"

///Clase que configura el page view y setea los mensajes que deben ir en el Navigation dependiendo del tipo: cartas o regalos y del status: enviados o recibidos

@interface LUIViewControllerMensajes()

@property (strong, nonatomic) NSArray *page;

@end

@implementation LUIViewControllerMensajes

-(void)viewDidLoad{
    
    [super viewDidLoad];
    //se cambia de color del navigation bar
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:16/255.0 green:28/255.0 blue:133/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    //se cambia el color del texto del navigation bar
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    //se le quita el texto de la flecha de back
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    //se le asignan al array los nombres de los viewControllers que estaran en el pager de los mensajes
    self.page = @[@"mensajeAhijado", @"fotoAhijado"];
    NSNumber *sesion = [[NSUserDefaults standardUserDefaults] objectForKey:@"idBuzon"];
    NSString *idBuzon = [NSString stringWithFormat:@"%@", sesion];
    NSLog(@"en el detalle %@", idBuzon);
    if([idBuzon isEqualToString:@"recibidos"]){
        [self addView];
    }else{
        LManagerObject *store = [LManagerObject sharedStore];
        LMBuzon *buzon = [store shareIdBuzon:idBuzon];
        NSLog(@"--------- %@", buzon.tipo);
        if([buzon.tipo isEqualToString:@"Cartas"]){
            [self addViewCartasEnviadas];
        }else{
            [self addViewRegalosEnviados];
        }
    }
}

/**
 Metodo que agrega el pager de los detalles de los mensajes recibidos
 */
-(void)addView{
    //se crea el pager para colocarlo en el viewController
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewControllerMensajesRecibidos"];
    self.pageViewController.dataSource = self;
    
    //se obtiene el primer viewController a colocar
    UIViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.pageViewController.automaticallyAdjustsScrollViewInsets = NO;
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.pageViewController.view.backgroundColor = [UIColor clearColor];
    
    //se agrega a la vista del viewController principal
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

/**
 Metodo que agrega la vista de los mensajes de enviados
 */
-(void)addViewCartasEnviadas{
    //se setea un titulo al navigation bar
    [self.navigationItem setTitle:@"Mensaje enviado a tu ahijado"];
    self.viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"IdentificadorBuzonEnviados"];
    //se agrega a la vista del viewController principal
    [self addChildViewController:self.viewController];
    [self.view addSubview:self.viewController.view];
    [self.viewController didMoveToParentViewController:self];
}

/**
 Metodo que agrega la vista de los regalos enviados
 */
-(void)addViewRegalosEnviados{
    //se setea un titulo al navigation bar
    [self.navigationItem setTitle:@"Regalo registrado"];
    self.viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"IdentificadorBuzonEnviados"];
    //se agrega a la vista del viewController principal
    [self addChildViewController:self.viewController];
    [self.view addSubview:self.viewController.view];
    [self.viewController didMoveToParentViewController:self];
}

#pragma mark - Page View Controller Data Source
//metodo que se encarga de mostrar la pagina anterior del pager
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    //si se hace de esta forma se tiene que agregar el identificador en el story board en el restoration id
    NSString * identifier = viewController.restorationIdentifier;
    NSUInteger index = [self.page indexOfObject:identifier];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
    
}

//metodo que se encarga de mostrar la pagina posterior del pager
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

//metodo que se encarga de colocar las paginas
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    
    if (([self.page count] == 0) || (index >= [self.page count])) {
        return nil;
    }
    
    for(int cont=0; cont<self.page.count; cont++){
        NSLog(@"que traeeee %@", [self.page objectAtIndex:cont]);
    }
    
    NSString* page = self.page[index];
    
    // Create a new view controller and pass suitable data.
    UIViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:page];
    
    return pageContentViewController;
    
}

//metodo que se encarga de colocar el numero de paginas en el pager
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.page count];
}

//metodo que presenta el numero de veces las paginas
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end