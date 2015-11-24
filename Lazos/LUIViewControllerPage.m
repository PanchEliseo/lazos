//
//  LUIViewControllerPage.m
//  Lazos
//
//  Created by Programacion on 9/11/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerPage.h"

@interface LUIViewControllerPage()
@property (strong, nonatomic)UIViewController *viewControllerContainer;

@end

@implementation LUIViewControllerPage

-(void)viewDidLoad{
    
    [super viewDidLoad];

    self.view.alpha = 0;
    [UIView animateWithDuration:0.1 animations:^(void)
     {
         self.view.alpha = 1.0;
     }];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

/**
 Metodo que se encarga de mandar a la pagina de lazos 
 */
- (IBAction)ayudaLazos:(id)sender {
    
    //se abre la pagina de lazos
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.lazos.org.mx"]];
    
}


@end
