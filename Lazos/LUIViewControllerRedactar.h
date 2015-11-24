//
//  LUIViewControllerRedactar.h
//  Lazos
//
//  Created by Programacion on 9/28/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUIViewControllerRedactar : UIViewController<UIAlertViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imagenPlantilla;
@property (weak, nonatomic) IBOutlet UILabel *nombreAhijado;
@property (weak, nonatomic) IBOutlet UILabel *apellidosAhijado;
@property (weak, nonatomic) IBOutlet UIButton *botonEnviar;
@property (weak, nonatomic) IBOutlet UITextView *textoCarta;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContent;
@end
