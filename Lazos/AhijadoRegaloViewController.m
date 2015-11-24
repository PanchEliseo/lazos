//
//  AhijadoRegaloViewController.m
//  Lazos
//
//  Created by sferea on 30/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

///Manejo del Page View para el Registro del Regalo
#import "AhijadoRegaloViewController.h"
#import "LUIViewControllerTabBar.h"
#import "AhijadoRegaloDetalleMensajeViewController.h"

@interface AhijadoRegaloViewController ()
@property (strong, nonatomic) NSArray *page;
@end

@implementation AhijadoRegaloViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.parentViewController.navigationItem setTitle:@"Registra tu regalo"];
    
    self.page = @[@"AhijadoRegaloContentViewController0", @"AhijadoRegaloContentViewController1", @"AhijadoRegaloContentViewController2", @"AhijadoRegaloContentViewController3"];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RegaloPageViewController"];
    self.pageViewController.dataSource = self;
    
    UIViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.pageViewController.automaticallyAdjustsScrollViewInsets = NO;
    
    ///Obtiene la altura del tab bar
    UITabBarController *tabBarController = [UITabBarController new];
    CGFloat tabBarHeight = tabBarController.tabBar.frame.size.height;
    NSLog(@"Altura del Tab bar %f", tabBarHeight);
    
    NSLog(@"Tamaño del page view previo a restarle la altura del tab bar: %f%@%f", self.pageViewController.view.frame.size.width, @", alto: ", self.pageViewController.view.frame.size.height);
    ///Cambia el tamaño del page view controller restando la altura del tab bar para visualizar los puntos
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-(tabBarHeight+2));
    NSLog(@"Tamaño del page view restándole la altura del tab bar: %f%@%f", self.pageViewController.view.frame.size.width, @", alto: ", self.pageViewController.view.frame.size.height);
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    NSLog(@"entra al timer");
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    //se le pone el nombre al navigation al momento que aparece
    [self.parentViewController.navigationItem setTitle:@"Registra tu regalo"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Page View Controller Data Source
///Método que se encarga de mostrar la pagina anterior del pager
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    ///Si se hace de esta forma se tiene que agregar el identificador en el history board en el restoration id
    NSString * identifier = viewController.restorationIdentifier;
    
    ///Se obtiene el page index actual
    NSUInteger index = [self.page indexOfObject:identifier];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    ///Se decrementa el número del index y retornamos el view controller a mostrar
    index--;
    return [self viewControllerAtIndex:index];
    
}

///Método que se encarga de mostrar la pagina posterior del pager
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    NSString *identifier = viewController.restorationIdentifier;
    
    ///Se obtiene el page index actual
    NSUInteger index = [self.page indexOfObject:identifier];
    
    if (index == NSNotFound) {
        return nil;
    }
    
    ///Se incrementa el número del index y retornamos el view controller a mostrar y se verifica si se llegó al límite de las páginas y se regresa nulo en ese caso
    index++;
    if (index == [self.page count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

///Método que se encarga de colocar las páginas
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    
    if (([self.page count] == 0) || (index >= [self.page count])) {
        return nil;
    }
    
    NSString* page = self.page[index];
    
    // Create a new view controller and pass suitable data.
    UIViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:page];
    
    //JG
    [pageContentViewController.view setFrame:(CGRect) self.pageViewController.view.frame];
    NSLog(@"Tamaño del view controller, ancho: %f%@%f", pageContentViewController.view.frame.size.width, @", alto: ", pageContentViewController.view.frame.size.height);
    return pageContentViewController;
    
}

//metodo que se encarga de colocar el numero de paginas en el pager
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    NSLog(@"que regresa el page en la cuenta de páginas: %@",self.page);
    return [self.page count];
}

//metodo que presenta el numero de veces las paginas
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
@end