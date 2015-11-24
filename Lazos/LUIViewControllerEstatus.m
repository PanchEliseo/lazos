//
//  LUIViewControllerEstatus.m
//  Lazos
//
//  Created by Programacion on 10/2/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerEstatus.h"

@implementation LUIViewControllerEstatus

-(void)viewDidLoad{
    
    [super viewDidLoad];
    //se setea un titulo al navigation bar
    [self.navigationItem setTitle:@"Estado de tu carta"];
    NSLog(@"mi estatus %@", self.estatus);
    [self addViewData];
    
}

/**
 Metodo que agrega la informacion requerida a la pantalla
 */
-(void)addViewData{
    
    if([self.estatus isEqualToString:@"New"]){
        [self.sobreEstatus1 setHidden:YES];
        [self.sobreEstatus2 setHidden:NO];
        [self.sobreEstatus3 setHidden:YES];
        //se activan las imagenes de los numeros que igual muestran el estatus de la carta
        self.imagenEstatus1.image = [UIImage imageNamed:@"ic_image_envios_uno_on.png"];
        self.imagenEstatus2.image = [UIImage imageNamed:@"ic_image_envios_dos_on.png"];
    }else if([self.estatus isEqualToString:@"Assigned"]){
        [self.sobreEstatus1 setHidden:YES];
        [self.sobreEstatus2 setHidden:YES];
        [self.sobreEstatus3 setHidden:NO];
        self.imagenEstatus1.image = [UIImage imageNamed:@"ic_image_envios_uno_on.png"];
        self.imagenEstatus2.image = [UIImage imageNamed:@"ic_image_envios_dos_on.png"];
        self.imagenEstatus3.image = [UIImage imageNamed:@"ic_image_envios_tres_on.png"];
    }else if([self.estatus isEqualToString:@"Closed"]){
        [self.sobreEstatus1 setHidden:YES];
        [self.sobreEstatus2 setHidden:YES];
        [self.sobreEstatus3 setHidden:YES];
        self.imagenEstatus1.image = [UIImage imageNamed:@"ic_image_envios_uno_on.png"];
        self.imagenEstatus2.image = [UIImage imageNamed:@"ic_image_envios_dos_on.png"];
        self.imagenEstatus3.image = [UIImage imageNamed:@"ic_image_envios_tres_on.png"];
        self.imagenEstatus4.image = [UIImage imageNamed:@"ic_image_envios_cuatro_on.png"];
    }else{
        //se ocultan las imagenes de los sobres que muestran el envio de la carta
        [self.sobreEstatus1 setHidden:NO];
        [self.sobreEstatus2 setHidden:YES];
        [self.sobreEstatus3 setHidden:YES];
        self.imagenEstatus1.image = [UIImage imageNamed:@"ic_image_envios_uno_on.png"];
    }
}

@end