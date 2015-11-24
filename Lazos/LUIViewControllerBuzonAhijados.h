//
//  LUIViewControllerBuzonAhijados.h
//  Lazos
//
//  Created by Programacion on 9/28/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUIViewControllerBuzonAhijados : UIViewController

///Contiene los segmentos "ENVIADOS" o "RECIBIDOS"
@property (weak, nonatomic) IBOutlet UISegmentedControl *estadoSegmentedControl;
///Vista a la que se le asigna el View Controller de "ENVIADOS" o "RECIBIDOS" según el Segmented Control con su correspondiente Table View
@property (weak, nonatomic) IBOutlet UIView *contenidoBuzonView;

@end
