//
//  UIControllerLogin.h
//  Lazos
//
//  Created by Programacion on 8/31/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "SWRevealViewController.h"

@interface UIControllerLogin : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic) IBOutlet UITextField *nipText;
@property (weak, nonatomic) IBOutlet UIButton *helpNip;
@property (weak, nonatomic) IBOutlet UIButton *claveElectronica;
@property (weak, nonatomic) IBOutlet UIButton *buttonSession;
@property (weak, nonatomic) IBOutlet UIButton *buttonLlamar;
@property (weak, nonatomic) IBOutlet UITextField *campoNip;
@property (weak, nonatomic) IBOutlet UITextField *campoClave;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UILabel *mensajeSesion;
@property (weak, nonatomic) IBOutlet UILabel *mensajeNoSesion;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) SWRevealViewController *swViewController;
@property (weak, nonatomic) IBOutlet UIImageView *imageHelp;
@property (weak, nonatomic) IBOutlet UILabel *leyendaAyuda;

@end
