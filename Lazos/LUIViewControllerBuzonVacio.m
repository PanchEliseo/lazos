//
//  LUIViewControllerBuzonVacio.m
//  Lazos
//
//  Created by Programacion on 9/22/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerBuzonVacio.h"

@implementation LUIViewControllerBuzonVacio

-(void)viewDidLoad{
    
    [super viewDidLoad];
    NSLog(@"se recarga el controller %@", self.texto);
    if([self.texto isEqualToString:@"enviado"]){
        self.textoBuzon.text = @"Aún no has enviado cartas o registrado regalos para tu ahijado. Te invitamos a comenzar la comunicación escribiéndole una carta.";
    }else if([self.texto isEqualToString:@"recibido"]){
        self.textoBuzon.text = @"Aún no has recibido mensajes de tu ahijado. Te invitamos a comenzar la comunicación escribiéndole una carta.";
    }
    
}

@end