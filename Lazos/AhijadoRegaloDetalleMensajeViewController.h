//
//  AhijadoRegaloDetalleMensajeViewController.h
//  Lazos
//
//  Created by sferea on 07/10/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUIViewControllerTabBar.h"

@interface AhijadoRegaloDetalleMensajeViewController : UIViewController

@property(strong, nonatomic) IBOutlet UILabel *nombreAhijado;
@property (weak, nonatomic) IBOutlet UILabel *apellidosAhijado;
@property (weak, nonatomic) IBOutlet UILabel *fechaRegalo;
@property (weak, nonatomic) IBOutlet UILabel *horaRegalo;
@property (weak, nonatomic) IBOutlet UITextView *descripcionRegalo;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewContent;

@end
