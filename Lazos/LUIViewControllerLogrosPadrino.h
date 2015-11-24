//
//  LUIViewControllerLogrosPadrino.h
//  Lazos
//
//  Created by Programacion on 10/12/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUIViewControllerLogrosPadrino : UIViewController

//propiedades de la clase
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
///Datos del encabezado
@property (weak, nonatomic) IBOutlet UILabel *padrinoNombreCompleto;
@property (weak, nonatomic) IBOutlet UILabel *padrinoGenero;
@property (weak, nonatomic) IBOutlet UILabel *padrinoNivel;
@property (weak, nonatomic) IBOutlet UILabel *padrinoFechaIngreso;

///Imágenes de los logros
@property (weak, nonatomic) IBOutlet UIImageView *imageViewAhijados1;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewAhijados2;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewAhijados3;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewAhijadosMas3;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewRegalos1;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewRegalos2;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewRegalos3;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewRegalosMas3;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCartas2;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCartas4;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCartas6;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCartasMas8;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCompartir1;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCompartirMas1;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewVisita;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewAportacionAdicional;

///Texto de los logros
@property (weak, nonatomic) IBOutlet UILabel *labelAhijados1;
@property (weak, nonatomic) IBOutlet UILabel *labelAhijados2;
@property (weak, nonatomic) IBOutlet UILabel *labelAhijados3;
@property (weak, nonatomic) IBOutlet UILabel *labelAhijadosMas3;
@property (weak, nonatomic) IBOutlet UILabel *labelRegalos1;
@property (weak, nonatomic) IBOutlet UILabel *labelRegalos2;
@property (weak, nonatomic) IBOutlet UILabel *labelRegalos3;
@property (weak, nonatomic) IBOutlet UILabel *labelRegalosMas3;
@property (weak, nonatomic) IBOutlet UILabel *labelCartas2;
@property (weak, nonatomic) IBOutlet UILabel *labelCartas4;
@property (weak, nonatomic) IBOutlet UILabel *labelCartas6;
@property (weak, nonatomic) IBOutlet UILabel *labelCartasMas8;
@property (weak, nonatomic) IBOutlet UILabel *labelCompartir1;
@property (weak, nonatomic) IBOutlet UILabel *labelCompartirMas1;
@property (weak, nonatomic) IBOutlet UILabel *labelVisita;
@property (weak, nonatomic) IBOutlet UILabel *labelAportacionAdicional;

@end