//
//  LUIViewControllerVerFactura.m
//  Lazos
//
//  Created by Programacion on 10/9/15.
//  Copyright © 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerVerFactura.h"
#import "LUtil.h"

@implementation LUIViewControllerVerFactura

-(void)viewDidLoad{
    
    [super viewDidLoad];
    //se setea un titulo al navigation bar
    [self.navigationItem setTitle:@"Mis aportaciones"];
    // se carga la url de la imagen del ahijado, que biene del servicio
    self.webView.scalesPageToFit = YES;
    self.webView.autoresizesSubviews = YES;
    
    LUtil *util = [LUtil instance];
    NSString *urlPdfFinal = [util obtenerPDF:self.url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlPdfFinal]]];
    
}

@end