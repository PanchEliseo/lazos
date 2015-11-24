//  LUIViewControllerDetalleGaleria.h
//  Lazos
//
//  Created by Programacion on 9/24/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUIViewControllerDetalleGaleria : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *imagenAhijado;
@property (strong, nonatomic) NSString *urlImagen;
@property (weak, nonatomic) IBOutlet UIWebView *imageWebView;

@end
