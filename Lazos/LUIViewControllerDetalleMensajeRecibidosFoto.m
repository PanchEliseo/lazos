//
//  LUIViewControllerDetalleMensajeRecibidosFoto.m
//  Lazos
//
//  Created by Carlos molina on 11/11/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerDetalleMensajeRecibidosFoto.h"
#import "LManagerObject.h"
#import "LMBuzonRecibidos.h"
#import "UIImageView+WebCache.h"

@implementation LUIViewControllerDetalleMensajeRecibidosFoto

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*LManagerObject *store = [LManagerObject sharedStore];
    //se obtiene el padrino de la base
    NSArray *recibidos = [store showData:@"LMBuzonRecibidos"];
    LMBuzonRecibidos *recibidosBuzon = [recibidos objectAtIndex:0];
    //aqui descomentar para colocar la imagen del json
    NSURL *url = [NSURL URLWithString:recibidosBuzon.url_imagen_respuesta];
    [self.imagenAhijado sd_setImageWithURL:url placeholderImage:[UIImage alloc]];*/
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
