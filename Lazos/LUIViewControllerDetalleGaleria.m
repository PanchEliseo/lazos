//
//  LUIViewControllerDetalleGaleria.m
//  Lazos
//
//  Created by Programacion on 9/24/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerDetalleGaleria.h"
#import "UIImageView+WebCache.h"
#import "LServiceObjectGaleria.h"
#import "LMPadrino.h"
#import "LUtil.h"

@interface LUIViewControllerDetalleGaleria(){
    CGFloat imageMinScale;
    CGFloat imageMaxScale;
    CGFloat imageCurrentScale;
}
@end

@implementation LUIViewControllerDetalleGaleria

/**
 Metodo que se encarga de inicializar el controller de la vista
 */
-(void)viewDidLoad{
    
    [super viewDidLoad];
    //se setea un titulo al navigation bar
    [self.navigationItem setTitle:@"Galería"];
    self.imagenAhijado = [[UIImageView alloc] init];
    // se carga la url de la imagen del ahijado, que biene del servicio
    self.imageWebView.scalesPageToFit = YES;
    self.imageWebView.autoresizesSubviews = YES;
    [self.imageWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlImagen]]];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

/**
 Método que realiza la acción del botón de compartir en las redes sociales
 */
-(IBAction)shareInfo:(id)sender{
    ///Obtiene el padrino de la base de datos
    LUtil *functions = [LUtil instance];
    LMPadrino *padrino = [functions oftenPadrino];
    NSString * nip = [NSString stringWithFormat:@"%@", padrino.nip_godfather];
    
    LServiceObjectGaleria *service = [[LServiceObjectGaleria alloc] initWithGaleriaApilazos:nip tokenPadrino:padrino.token];
    [service startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error)
     {
         NSLog(@"Imprime la respuesta de compartir en galeria %@", response);
     }];
    
    NSURL *url = [NSURL URLWithString:self.urlImagen];
    [self.imagenAhijado sd_setImageWithURL:url placeholderImage:[UIImage alloc]];
    //[self.imagenAhijado sizeToFit];
    //aqui se comparte en las posibles redes sociales, o en msm, si estan instaladas
    //aqui el texto a compartir o una imagen comentada si se requiere
    //NSString *texttoshare = [NSString stringWithFormat:@"%@", self.imagenAhijado.image.images]; //this is your text string to share
    //se comparte la imagen del ahijado
    NSLog(@"compartir imagen %@", self.imagenAhijado.image);
    if(self.imagenAhijado.image){
        UIImage *imagetoshare = self.imagenAhijado.image; //this is your image to share
        NSArray *activityItems = @[imagetoshare];
        
        //se crea el array de las posibles opciones donde no se va a compartir la informacion
        NSArray *excludedActivities = @[UIActivityTypePostToFlickr, UIActivityTypePrint, UIActivityTypeAirDrop, UIActivityTypeAssignToContact,
                                        UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo, UIActivityTypePostToWeibo, UIActivityTypeMessage, UIActivityTypeAddToReadingList,UIActivityTypeCopyToPasteboard];
        
        //se usa UIActivityViewController para que salgan las opciones de compartir en las redes sociales
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        //aqui se quitan los tipos en los que se pueden compartir los datos
        //solo se va a compartir por mensaje de texto, correo y whats app
        activityVC.excludedActivityTypes = excludedActivities;
        //if iPhone
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [self presentViewController:activityVC animated:YES completion:nil];
        }
        //se comparte en ipad, ya que con la otra funcion marca error
        //if iPad
        else {
            // Change Rect to position Popover
            UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityVC];
            [popup presentPopoverFromRect:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4, 0, 0)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }
}

@end