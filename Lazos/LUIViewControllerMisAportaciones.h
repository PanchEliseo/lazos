//
//  LUIViewControllerMisAportaciones.h
//  Lazos
//
//  Created by Programacion on 10/2/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface LUIViewControllerMisAportaciones : UIViewController<UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, UIAlertViewDelegate>

//propiedades escuchadoras de la vista
///Botón superior para acceder al menú
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (weak, nonatomic) IBOutlet UIButton *buttonHelp;
@property (weak, nonatomic) IBOutlet UIView *viewFooter;
@property (weak, nonatomic) IBOutlet UILabel *textoLeyenda;
@property (weak, nonatomic) IBOutlet UILabel *RFC;
@property (weak, nonatomic) IBOutlet UILabel *leyendaDeRFC;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imagenNoRfc;
@property (weak, nonatomic) IBOutlet UILabel *nombrePadrino;
@property (weak, nonatomic) IBOutlet UILabel *nipPadrino;
@property (weak, nonatomic) IBOutlet UILabel *apellidosPadrino;
@property (weak, nonatomic) IBOutlet UILabel *periodicidadPadrino;
@property (weak, nonatomic) IBOutlet UILabel *leyendaNip;
@property (weak, nonatomic) IBOutlet UILabel *periodicidad;

@end
