//
//  LUIViewControllerAhijados.h
//  Lazos
//
//  Created by Programacion on 9/23/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUIViewControllerColeccionAhijados.h"
#import "LUIViewControllerTabBar.h"
#import "LMAhijado.h"

@interface LUIViewControllerAhijados : UIViewController

@property (strong, nonatomic) LUIViewControllerTabBar *controllerContainer;
@property (strong, nonatomic) LUIViewControllerColeccionAhijados *controllerColeccion;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (strong, nonatomic)LMAhijado *ahijado;
@property (strong, nonatomic)NSDictionary *ahijadosJson;

@end
