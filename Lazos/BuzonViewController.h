//
//  BuzonViewController.h
//  Lazos
//
//  Created by sferea on 17/09/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface BuzonViewController : UIViewController

///Botón superior para acceder al menú
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
///Contiene los segmentos "ENVIADOS" o "RECIBIDOS"
@property (weak, nonatomic) IBOutlet UISegmentedControl *estadoSegmentedControl;
///Vista a la que se le asigna el View Controller de "ENVIADOS" o "RECIBIDOS" según el Segmented Control con su correspondiente Table View
@property (weak, nonatomic) IBOutlet UIView *contenidoBuzonView;

@end
