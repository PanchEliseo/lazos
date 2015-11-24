//
//  LUIViewControllerTabBar.m
//  Lazos
//
//  Created by Programacion on 9/14/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerTabBar.h"
#import "SWRevealViewController.h"

@implementation LUIViewControllerTabBar

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    if([self.tipo isEqualToString:@"registrar"]){
        self.selectedIndex = 4;
    }
    
    //se cambia de color del navigation bar
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:16/255.0 green:28/255.0 blue:133/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    //se cambia el color del texto del navigation bar
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    //se le quita el texto de la flecha de back
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    //se pregunta si se instancio la clase del menu para hacer que vuelva al menu si se presiona el boton de menu
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    ///Establece el color de la barra del tab bar a azul
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:16/255.0 green:28/255.0 blue:133/255.0 alpha:1.0]];

    ///Establece que los íconos de los BarItems los tome de las imágenes color blanco para que no aparezcan en gris
    UITabBarItem *tabBarItem1 = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [self.tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [self.tabBar.items objectAtIndex:3];
    UITabBarItem *tabBarItem5 = [self.tabBar.items objectAtIndex:4];
    tabBarItem1.image = [[UIImage imageNamed:@"ic_image_menu_ahijado.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem2.image = [[UIImage imageNamed:@"ic_image_menu_galeria.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem3.image = [[UIImage imageNamed:@"ic_image_menu_redactar.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem4.image = [[UIImage imageNamed:@"ic_image_menu_registrar.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem5.image = [[UIImage imageNamed:@"ic_image_menu_buzon-1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    ///Establece el color del texto en color blanco para que no aparezca en gris
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1.0], NSForegroundColorAttributeName, nil]
                                             forState:UIControlStateNormal];
    
    ///Cuando es seleccionado, el ícono y el texto son blancos paa que no aparezca en azul
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1.0]];
    ///Cuando es seleccionado, el fondo cambia de azul a rosa
    [[UITabBar appearance] setSelectionIndicatorImage:[LUIViewControllerTabBar imageFromColor:[UIColor colorWithRed:198/255.0 green:23/255.0 blue:145/255.0 alpha:1.0] forSize:CGSizeMake(64, 49) withCornerRadius:0]];
}

///Crea la imagen que se le pasa como fondo del tab item seleccionado
+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}

@end