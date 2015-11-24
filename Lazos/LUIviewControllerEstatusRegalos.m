//
//  LUIviewControllerEstatusRegalos.m
//  Lazos
//
//  Created by Programacion on 10/2/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIviewControllerEstatusRegalos.h"

@implementation LUIviewControllerEstatusRegalos

-(void)viewDidLoad{
    
    [super viewDidLoad];
    //se setea un titulo al navigation bar
    [self.navigationItem setTitle:@"Estado de tu regalo"];
    NSLog(@"mi estatus %@", self.estatus);
    [self addViewData];
    
}

/**
 Metodo que agrega la informacion requerida a la pantalla
 */
-(void)addViewData{
    
    self.heightWiew.constant = self.view.frame.size.width / 2;
    NSLog(@"-------- %f", self.view.frame.size.width / 2);
    if([self.estatus isEqualToString:@"New"]){
        [self.imagenRegaloEstatus1 setHidden:NO];
        [self.imagenRegaloEstatus2 setHidden:YES];
        //se activan las imagenes de los numeros que igual muestran el estatus de la carta
        self.imagenEstatus1.image = [UIImage imageNamed:@"ic_image_envios_uno_on.png"];
    }else if([self.estatus isEqualToString:@"Assigned"]){
        [self.imagenRegaloEstatus1 setHidden:YES];
        [self.imagenRegaloEstatus2 setHidden:NO];
        self.imagenEstatus1.image = [UIImage imageNamed:@"ic_image_envios_uno_on.png"];
        self.imagenEstatus2.image = [UIImage imageNamed:@"ic_image_envios_dos_on.png"];
    }else if([self.estatus isEqualToString:@"Closed"]){
        [self.imagenRegaloEstatus1 setHidden:YES];
        [self.imagenRegaloEstatus2 setHidden:YES];
        self.imagenEstatus1.image = [UIImage imageNamed:@"ic_image_envios_uno_on.png"];
        self.imagenEstatus2.image = [UIImage imageNamed:@"ic_image_envios_dos_on.png"];
        self.imagenEstatus3.image = [UIImage imageNamed:@"ic_image_envios_tres_on.png"];
    }
}

@end